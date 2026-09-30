{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.restic = {
    passwordFile = lib.mkOption {
      type = lib.types.str;
    };
    rcloneOneDrivePath = lib.mkOption {
      type = lib.types.str;
    };
    services = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "maps systemdUnitNames to paths to backup";
      default = { };
      example = {
        "systemdUnitName" = "/var/lib/systemdUnitName";
      };
    };
  };

  config =
    let
      cfg = config.restic;
      systemdServiceUnits = lib.mapAttrsToList (systemdUnitName: _: systemdUnitName) cfg.services;
      serviceDataPaths = lib.mapAttrsToList (_: dataPath: dataPath) cfg.services;
    in
    {
      environment.systemPackages = with pkgs; [
        restic
        backrest
      ];

      services.restic.backups.onedrive = {
        user = "root";
        repository = "rclone:OneDrive:${config.restic.rcloneOneDrivePath}";
        initialize = true;
        passwordFile = config.restic.passwordFile;
        rcloneConfigFile = "/home/peter/.config/rclone/rclone.conf";

        paths = serviceDataPaths ++ [ "/var/lib/private" ];

        backupPrepareCommand = "systemctl stop " + lib.join " " systemdServiceUnits;
        backupCleanupCommand = "systemctl start " + lib.join " " systemdServiceUnits;

        # daily at 3:00 UTC -> 5:00 Berlin/CEST
        timerConfig = {
          OnCalendar = "*-*-* 03:00:00 UTC";
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
