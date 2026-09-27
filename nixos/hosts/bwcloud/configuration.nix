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
    serviceNames = [
      "uptime-kuma"
      "grafana"
      "matrix-synapse"
    ];
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
}
