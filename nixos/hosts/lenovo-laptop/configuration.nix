{ inputs, pkgs, ... }:

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

  networking.hostName = "peter-lenovo-laptop";

  services.fwupd.enable = true;

  hardware.enableRedistributableFirmware = true;

  hardware.cpu.amd.updateMicrocode = true;

  services.power-profiles-daemon.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  services.logind.settings.Login.HandleLidSwitch = "suspend";

  # bluetooth:
  # may need to run `rfkill unblock bluetooth` once on first install to unblock the softblock on bluetooth
  hardware.bluetooth.enable = true;

  # disable TPM, as the jobs for /dev/tmp0 and /dev/tmprm0 timeout on startup
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  users.users.tim = {
    isNormalUser = true;
    description = "Tim";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
      "docker"
      "greeter"
    ];
    packages = with pkgs; [ cachix ];
    shell = pkgs.fish;
  };
}
