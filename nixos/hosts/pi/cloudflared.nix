{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    cloudflared
  ];

  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel run raspberrypi";
      Restart = "on-failure";
      RestartSec = 5;
      User = "peter";
    };
  };
}
