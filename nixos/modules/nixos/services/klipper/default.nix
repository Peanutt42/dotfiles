{ pkgs, ... }:

let
  # mainsail + moonraker are kind of weird to proxy over tailnet, so local only for now
  localPiIp = "192.168.0.143";
  mainsailPort = 8084;
  moonrakerPort = 7125;
in
{
  services.klipper = {
    enable = true;
    user = "moonraker";
    group = "moonraker";
    mutableConfig = true;
    configDir = "/var/lib/moonraker/config";
    configFile = ./printer.cfg;

    firmwares.mcu = {
      enable = true;
      configFile = ./klipper-mcu.config;
      # serial = "/dev/serial/by-id/usb-Klipper_stm32f401xc_XXXX-if00";
    };
  };
  systemd.services.klipper.serviceConfig.ReadWritePaths = [ "/var/lib/moonraker" ];

  services.moonraker = {
    enable = true;
    address = "127.0.0.1";
    port = moonrakerPort;
    settings.authorization = {
      trusted_clients = [
        "10.0.0.0/8"
        "127.0.0.0/8"
        "169.254.0.0/16"
        "172.16.0.0/12"
        "192.168.0.0/16"
        "FE80::/10"
        "::1/128"
        "100.64.0.0/10"
      ];
      cors_domains = [
        "*://my.mainsail.xyz"
        "*://*.local"
        "*://*.lan"
      ];
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/moonraker/config 0750 moonraker moonraker -"
    "d /var/lib/moonraker/gcodes 0750 moonraker moonraker -"
  ];
  users.users.moonraker.extraGroups = [ "dialout" ];

  environment.systemPackages = [ pkgs.mainsail ];

  networking.firewall.allowedTCPPorts = [ mainsailPort ];

  services.caddy.virtualHosts."http://${localPiIp}:${toString mainsailPort}".extraConfig = ''
    encode zstd gzip

    @moonraker path /websocket /printer/* /api/* /access/* /machine/* /server/*
    handle @moonraker {
      reverse_proxy 127.0.0.1:${toString moonrakerPort}
    }

    handle {
      root * ${pkgs.mainsail}/share/mainsail
      try_files {path} /index.html
      file_server
    }
  '';
}
