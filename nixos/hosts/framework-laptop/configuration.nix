{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./wluma
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/sddm.nix
    ../../modules/nixos/apps.nix
    ../../modules/nixos/gui-apps.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/ai-tools.nix
    ../../modules/nixos/gnupg.nix
    ../../modules/nixos/eduroam
    ../../modules/nixos/services/onedrive-rclone.nix
    ../../users/presentation/nixos.nix
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
      "presentation" = {
        imports = [
          ../../users/presentation/home.nix
          ../../modules/homeManager/dms.nix
        ];
      };
    };
  };

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

  # see ./hardware-configuration.nix for uuid
  boot.initrd.luks.devices."luks-c03d8d38-b843-49fc-b813-9538f7297527".device =
    "/dev/disk/by-uuid/c03d8d38-b843-49fc-b813-9538f7297527";
  boot.resumeDevice = "/dev/mapper/luks-c03d8d38-b843-49fc-b813-9538f7297527";
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "1h";
    SuspendState = "mem";
  };

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

  # see ../../modules/nixos/secure-boot.nix
  secure-boot = {
    enable = true;
    includeFirmwareBuiltinKeys = true;
  };

  # Enable audio enhancement for Framework Laptop 13
  hardware.framework.laptop13.audioEnhancement.rawDeviceName =
    lib.mkDefault "alsa_output.pci-0000_c1_00.6.analog-stereo";
  # See: https://community.frame.work/t/microphone-not-working-after-nixos-update/74915
  services.pipewire.wireplumber.extraConfig.no-ucm = {
    "monitor.alsa.properties" = {
      "alsa.use-ucm" = false;
    };
  };

  sops.secrets = {
    "eduroam/domain".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/radius".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/identity".sopsFile = ../../secrets/eduroam.yaml;
    "eduroam/password".sopsFile = ../../secrets/eduroam.yaml;
  };

  services.networking.eduroam = {
    enable = true;
    domainFile = config.sops.secrets."eduroam/domain".path;
    radiusFile = config.sops.secrets."eduroam/radius".path;
    identityFile = config.sops.secrets."eduroam/identity".path;
    passwordFile = config.sops.secrets."eduroam/password".path;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
