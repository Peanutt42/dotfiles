{ lib, pkgs, ... }:

let
  services = [
    "AdGuardHome"
    "anki-sync-server"
    "no_bs_habit_tracker"
    "octoprint"
    "vaultwarden"
    "vikunja"
  ];
  systemdServiceUnits = map lib.toLower services;
in
{
  environment.systemPackages = [ pkgs.restic ];

  services.restic.backups.onedrive = {
    user = "root";
    repository = "rclone:OneDrive:/Backups/pi";
    initialize = true;
    passwordFile = "/home/peter/restic-password-file.txt"; # temporary till sops
    rcloneConfigFile = "/home/peter/.config/rclone/rclone.conf";

    paths = map (s: "/var/lib/" + s) services ++ [ "/var/lib/private" ];

    backupPrepareCommand = "systemctl stop " + lib.join " " systemdServiceUnits;
    backupCleanupCommand = "systemctl start " + lib.join " " systemdServiceUnits;

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
}
