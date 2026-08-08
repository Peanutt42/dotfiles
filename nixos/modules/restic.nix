{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.restic = {
    serviceNames = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    systemdServiceUnits = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = map lib.toLower config.restic.serviceNames;
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      restic
      backrest
    ];

    sops.secrets."restic/password".sopsFile = ../secrets/restic.yaml;

    services.restic.backups.onedrive = {
      user = "root";
      repository = "rclone:OneDrive:/Backups/pi";
      initialize = true;
      passwordFile = config.sops.secrets."restic/password".path;
      rcloneConfigFile = "/home/peter/.config/rclone/rclone.conf";

      paths = map (s: "/var/lib/" + s) config.restic.serviceNames ++ [ "/var/lib/private" ];

      backupPrepareCommand = "systemctl stop " + lib.join " " config.restic.systemdServiceUnits;
      backupCleanupCommand = "systemctl start " + lib.join " " config.restic.systemdServiceUnits;

      # daily at 3:00 am
      timerConfig = {
        OnCalendar = "03:00";
        Persistent = true;
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
        "--keep-yearly 2"
      ];
    };

    # web ui interface for restic
    systemd.services.backrest = {
      description = "Launch backrest to take care of backups";
      wantedBy = [ "default.target" ];
      requires = [ "network-online.target" ];
      script = "backrest";
      path = [ pkgs.backrest ];
      environment = {
        BACKREST_PORT = "0.0.0.0:9898";
      };
      serviceConfig = {
        Type = "simple";
        User = "root";
        # AmbientCapabilities = "CAP_DAC_READ_SEARCH";
        # CapabilityBoundingSet = "CAP_DAC_READ_SEARCH";
        # ExecStart = "backrest";
        # It’s often a good idea to mark the service active after the command finishes.
        # RemainAfterExit = true;
      };
    };
  };
}
