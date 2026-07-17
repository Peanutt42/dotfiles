{ lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/virtualisation/openstack-config.nix"
    ../../modules/apps.nix
    ../../modules/development.nix
  ];

  # see ../../modules/apps.nix
  headless = true;

  networking.hostName = "bwcloud";

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  services.qemuGuest.enable = true;

  users.users.peter.initialHashedPassword = "$y$j9T$qH9rynM1KrfHgs8.1bZ0Z/$aBOWzink2fHF3CBLhGta6V0KslNyY5IqTO5dN0TfUu6";

  boot.loader.grub.device = "/dev/vda";
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
}
