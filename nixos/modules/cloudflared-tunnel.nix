{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.cloudflared-tunnel = {
    tunnelID = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      cloudflared
    ];

    environment.etc."cloudflared/config.yml".text = ''
      tunnel: raspberrypi
      credentials-file: /etc/cloudflared/${config.cloudflared-tunnel.tunnelID}.json
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
  };
}
