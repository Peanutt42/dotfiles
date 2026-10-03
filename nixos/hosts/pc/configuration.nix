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
    useGlobalPkgs = true;
    users = {
      "peter" = {
        imports = [
          ../../users/peter/home.nix
          ../../modules/homeManager/dms.nix
        ];
      };
    };
  };

  networking.hostName = "peter-pc";

  boot.initrd.luks.devices."luks-ed8bb8e6-65ba-4561-9c7d-fb0715d929e0".device =
    "/dev/disk/by-uuid/ed8bb8e6-65ba-4561-9c7d-fb0715d929e0";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # see ../../modules/nixos/secure-boot.nix
  secure-boot = {
    enable = true;
    includeFirmwareBuiltinKeys = true;
  };

  # see ../../modules/nixos/boot-splash.nix
  boot-splash.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
