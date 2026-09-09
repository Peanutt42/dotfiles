{ inputs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/sddm.nix
    ../../modules/nixos/apps.nix
    ../../modules/nixos/gui-apps.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/ai-tools.nix
    ../../modules/nixos/gnupg.nix
    ../../modules/nixos/services/onedrive-rclone.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "peter" = {
        imports = [
          ../../modules/homeManager/default-home.nix
        ];
      };
    };
  };

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
