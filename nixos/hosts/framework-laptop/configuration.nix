{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./wluma
    ../../modules/niri.nix
    ../../modules/gnome.nix
    ../../modules/sddm.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/onedrive-rclone.nix
    ../../modules/ai-tools.nix
    ../../modules/gnupg.nix
    ../../modules/eduroam
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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  sops.secrets = {
    "eduroam/domain".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/radius".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/identity".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/password".sopsFile = ../../secrets/eduroam.yaml;
  };

  services.networking.eduroam = {
    enable = true;
    user = "peter";
    domainFile = config.sops.secrets."eduroam/domain".path;
    radiusFile = config.sops.secrets."eduroam/radius".path;
    identityFile = config.sops.secrets."eduroam/identity".path;
    passwordFile = config.sops.secrets."eduroam/password".path;
  };
}
