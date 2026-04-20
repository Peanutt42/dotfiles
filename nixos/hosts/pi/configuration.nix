{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/cloudflared-tunnel.nix
    ../../modules/nginx.nix
    ../../modules/adguard-home.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/gnupg.nix
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
    settings.PasswordAuthentication = true;
  };

  # see ../../modules/apps.nix
  headless = true;

  # since we downloaded pre release unstable nixos sd images
  system.stateVersion = lib.mkForce "26.05";
}
