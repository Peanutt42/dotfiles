{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];

  systemd.enableStrictShellChecks = true;

  systemd.services.mount-onedrive-rclone = {
    description = "Mounts OneDrive using rclone";

    wantedBy = [ "default.target" ];

    script = ''
      ${pkgs.coreutils}/bin/mkdir -p /home/peter/OneDrive

      ${pkgs.rclone}/bin/rclone mount --config /home/peter/.config/rclone/rclone.conf --vfs-cache-mode full --vfs-write-back 0s --vfs-cache-max-age 0s --dir-cache-time 30s --no-checksum=false --rc OneDrive: /home/peter/OneDrive
    '';

    serviceConfig = {
      Type = "simple";
      User = "peter";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ]; # for fusermount3
    };
  };
}
