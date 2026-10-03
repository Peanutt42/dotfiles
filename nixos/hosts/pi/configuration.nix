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
    ../../modules/nixos/services/caddy.nix
    ../../modules/nixos/services/adguard-home.nix
    ../../modules/nixos/services/klipper
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
    useGlobalPkgs = true;
    users = {
      "peter" = {
        imports = [ ../../users/peter/home.nix ];
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

  services.resolved.enable = lib.mkForce false;

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
    services = {
      "adguardhome" = "/var/lib/AdGuardHome";
      "anki-sync-server" = "/var/lib/anki-sync-server";
      "klipper" = "/var/lib/klipper";
      "moonraker" = "/var/lib/moonraker";
      "vaultwarden" = "/var/lib/vaultwarden";
      "vikunja" = "/var/lib/vikunja";
      "docker-kosync" = "/var/lib/kosync";
      "caddy" = "/var/lib/caddy";
    };
  };
  sops.secrets."restic/pi/password".sopsFile = ../../secrets/restic.yaml;

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
