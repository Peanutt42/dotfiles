{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/niri.nix
    ../../modules/gnome.nix
    ../../modules/apps.nix
    ../../modules/development.nix
  ];

  networking.hostName = "peter-framework-laptop";

  # BIOS updates through LVFS (run `fwupdmgr update` to update and install BIOS updates)
  services.fwupd.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.framework.enableKmod = true;

  # Fingerprint sensor
  services.fprintd.enable = true;
  security.pam.services = {
    sudo.fprintAuth = true;
    gdm.fprintAuth = true;
    gdm-password.fprintAuth = true;
  };
}
