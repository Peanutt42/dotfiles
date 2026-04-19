{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/cachix.nix
    ../../modules/niri.nix
    ../../modules/gnome.nix
    ../../modules/apps.nix
    ../../modules/development.nix
  ];

  networking.hostName = "peter-pc";

  # NVIDIA driver
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];

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
