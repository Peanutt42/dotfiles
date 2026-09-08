{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];
  programs.fuse = {
    enable = true;
    userAllowOther = true;
  };

  systemd.enableStrictShellChecks = true;

  systemd.services.mount-onedrive-rclone = {
    description = "Mounts OneDrive using rclone";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "default.target" ];

    script = ''
      ${pkgs.coreutils}/bin/mkdir -p /home/peter/OneDrive

      ${pkgs.rclone}/bin/rclone mount \
        --allow-other \
        --rc \
        --fast-list \
        --onedrive-delta \
        --config /home/peter/.config/rclone/rclone.conf \
        --vfs-cache-mode full \
        OneDrive: /home/peter/OneDrive
    '';

    serviceConfig = {
      Type = "simple";
      User = "peter";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ]; # for fusermount3
    };
  };
}
