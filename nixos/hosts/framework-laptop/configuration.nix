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
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "peter" = {
        imports = [
          ../../modules/homeManager/default-home.nix
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
  boot.resumeDevice = "/dev/disk/by-uuid/8d7a6e4d-802b-44fd-8e07-9980d8e9995b";
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
    user = "peter";
    domainFile = config.sops.secrets."eduroam/domain".path;
    radiusFile = config.sops.secrets."eduroam/radius".path;
    identityFile = config.sops.secrets."eduroam/identity".path;
    passwordFile = config.sops.secrets."eduroam/password".path;
  };
}
