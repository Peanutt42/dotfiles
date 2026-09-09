{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/apps.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/gnupg.nix
    ../../modules/nixos/services/nginx.nix
    ../../modules/nixos/services/adguard-home.nix
    ../../modules/nixos/services/octoprint.nix
    ../../modules/nixos/services/vaultwarden.nix
    ../../modules/nixos/services/anki-sync-server.nix
    ../../modules/nixos/services/vikunja.nix
    ../../modules/nixos/services/restic.nix
    ../../modules/nixos/services/onedrive-rclone.nix
    ../../modules/nixos/services/cloudflared-tunnel.nix
    ../../modules/nixos/services/kosync.nix
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

  networking.hostName = "peter-pi";

  hardware.enableRedistributableFirmware = true;

  # override shared.nix boot config
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  # configure raspberrypis boot
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # see ../../modules/development.nix
  development.full = false;
  # see ../../modules/services/cloudflared-tunnel.nix
  cloudflared-tunnel.tunnelID = "4ca9765d-1875-4d76-bf02-7e4c88257fbe";
  # see ../../modules/services/restic.nix
  restic = {
    passwordFile = config.sops.secrets."restic/pi/password".path;
    rcloneOneDrivePath = "/Backups/pi";
    serviceNames = [
      "AdGuardHome"
      "anki-sync-server"
      "octoprint"
      "vaultwarden"
      "vikunja"
      "kosync"
    ];
  };
  sops.secrets."restic/pi/password".sopsFile = ../../secrets/restic.yaml;

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # since we downloaded pre release unstable nixos sd images
  system.stateVersion = lib.mkForce "26.05";
}
