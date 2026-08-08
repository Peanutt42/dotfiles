{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nginx.nix
    ../../modules/adguard-home.nix
    ../../modules/octoprint.nix
    ../../modules/vaultwarden.nix
    ../../modules/anki-sync-server.nix
    ../../modules/vikunja.nix
    ../../modules/restic.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/gnupg.nix
    ../../modules/onedrive-rclone.nix
    ../../modules/cloudflared-tunnel.nix
    ../../modules/kosync.nix
  ];

  networking.hostName = "peter-pi";

  hardware.enableRedistributableFirmware = true;

  # override shared.nix boot config
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  # configure raspberrypis boot
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # see ../../modules/apps.nix
  apps.headless = true;
  # see ../../modules/development.nix
  development.full = false;
  # see ../../modules/cloudflared-tunnel.nix
  cloudflared-tunnel.tunnelID = "4ca9765d-1875-4d76-bf02-7e4c88257fbe";
  # see ../../modules/restic.nix
  restic = {
    passwordFile = config.sops.secrets."restic/pi/password".path;
    rcloneOneDrivePath = "/Backups/pi";
    serviceNames = [
      "AdGuardHome"
      "anki-sync-server"
      "octoprint"
      "vaultwarden"
      "vikunja"
      "kosync"
    ];
  };
  sops.secrets."restic/pi/password".sopsFile = ../../secrets/restic.yaml;

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # since we downloaded pre release unstable nixos sd images
  system.stateVersion = lib.mkForce "26.05";
}
