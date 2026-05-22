{ pkgs, lib, ... }:

# newer linux kernel versions break bluetooth driver, will probably be fixed in newer kernel versions
let
  linux_7_0_6 = pkgs.linux_7_0.override {
    argsOverride = rec {
      version = "7.0.6";
      modDirVersion = version;
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v7.x/linux-${version}.tar.xz";
        hash = "sha256-y6REQKpXr/18ISQdxbwjSw31PEmfj/w+vCkN0zkKdSM=";
      };
    };
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/niri.nix
    ../../modules/gnome.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/onedrive-rclone.nix
    ../../modules/ai-tools.nix
    ../../modules/gnupg.nix
  ];

  networking.hostName = "peter-framework-laptop";

  boot.kernelPackages = lib.mkForce (pkgs.linuxPackagesFor linux_7_0_6);

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
