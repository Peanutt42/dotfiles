{
  inputs,
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/virtualisation/openstack-config.nix"
    ../../modules/nixos/apps.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/services/cloudflared-tunnel.nix
    ../../modules/nixos/services/restic.nix
    ../../modules/nixos/services/onedrive-rclone.nix
    ../../modules/nixos/services/uptime-kuma.nix
    ../../modules/nixos/services/grafana.nix
    ../../modules/nixos/services/matrix.nix
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

  # see ../../modules/development.nix
  development.full = false;
  # see ../../modules/services/cloudflared-tunnel.nix
  cloudflared-tunnel.tunnelID = "69cac2c6-6166-4977-91bb-96383425e6d3";
  # see ../../modules/services/restic.nix
  restic = {
    passwordFile = config.sops.secrets."restic/bwcloud/password".path;
    rcloneOneDrivePath = "/Backups/bwcloud";
    services = {
      "uptime-kuma" = "/var/lib/uptime-kuma";
      "grafana" = "/var/lib/grafana";
      "matrix-synapse" = "/var/lib/matrix-synapse";
    };
  };
  sops.secrets."restic/bwcloud/password".sopsFile = ../../secrets/restic.yaml;

  networking.hostName = "bwcloud";

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services.qemuGuest.enable = true;

  users.users.peter.initialHashedPassword = "$y$j9T$qH9rynM1KrfHgs8.1bZ0Z/$aBOWzink2fHF3CBLhGta6V0KslNyY5IqTO5dN0TfUu6";

  boot.loader.grub.device = "/dev/vda";
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
