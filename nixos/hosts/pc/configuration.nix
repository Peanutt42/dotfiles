{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/niri.nix
    ../../modules/gnome.nix
    ../../modules/sddm.nix
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/onedrive-rclone.nix
    ../../modules/ai-tools.nix
    ../../modules/gnupg.nix
  ];

  networking.hostName = "peter-pc";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # NVIDIA driver
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    # experimental
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    nvidiaPersistenced = true;

    # dont use open kernel modules
    open = false;

    nvidiaSettings = true;

    # legacy 580 for NVIDIA GTX 1050 TI
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
}
