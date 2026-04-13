{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/cachix.nix
    ../../modules/tui-apps.nix
    ../../modules/development.nix
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

  # since we downloaded pre release unstable nixos sd images
  system.stateVersion = lib.mkForce "26.05";
}
