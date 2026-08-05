{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./cloudflared-tunnel.nix
    ../../modules/nginx.nix
    ../../modules/adguard-home.nix
    ../../modules/octoprint.nix
    ../../modules/no_bs_habit_tracker.nix
    ../../modules/vaultwarden.nix
    ../../modules/anki-sync-server.nix
    ../../modules/vikunja.nix
    ../../modules/restic.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/gnupg.nix
    ../../modules/onedrive-rclone.nix
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
  headless = true;
  # see ../../modules/development.nix
  full = false;

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # since we downloaded pre release unstable nixos sd images
  system.stateVersion = lib.mkForce "26.05";
}
