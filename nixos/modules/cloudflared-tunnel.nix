{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloudflared
  ];

  environment.etc."cloudflared/config.yml".text = ''
    tunnel: raspberrypi
    credentials-file: /etc/cloudflared/4ca9765d-1875-4d76-bf02-7e4c88257fbe.json
  '';

  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --config /etc/cloudflared/config.yml run";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
