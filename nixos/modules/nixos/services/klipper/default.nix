{ pkgs, ... }:

let
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
    # only localhost, since it gets reverse proxied by caddy
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
        # tailnet
        "100.64.0.0/10"
        "fd7a:115c:a1e0::/48"
      ];
      cors_domains = [
        "*://my.mainsail.xyz"
        "*://*.local"
        "*://*.lan"
        "*://mainsail.sh.peternhennig.de"
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

  caddy.privateServices."mainsail".caddyConfig = ''
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
