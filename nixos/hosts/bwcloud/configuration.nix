{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/virtualisation/openstack-config.nix"
    ../../modules/apps.nix
    ../../modules/development.nix
    ../../modules/cloudflared-tunnel.nix
    ../../modules/restic.nix
    ../../modules/onedrive-rclone.nix
    ../../modules/uptime-kuma.nix
    ../../modules/grafana.nix
  ];

  # openstack has some spellcheck warnings
  systemd.enableStrictShellChecks = lib.mkForce false;

  # see ../../modules/apps.nix
  apps.headless = true;
  # see ../../modules/development.nix
  development.full = false;
  # see ../../modules/cloudflared-tunnel.nix
  cloudflared-tunnel.tunnelID = "69cac2c6-6166-4977-91bb-96383425e6d3";
  # see ../../modules/restic.nix
  restic = {
    passwordFile = config.sops.secrets."restic/bwcloud/password".path;
    rcloneOneDrivePath = "/Backups/bwcloud";
    serviceNames = [
      "uptime-kuma"
      "grafana"
    ];
  };
  sops.secrets."restic/bwcloud/password".sopsFile = ../../secrets/restic.yaml;

  networking.hostName = "bwcloud";

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  services.qemuGuest.enable = true;

  users.users.peter.initialHashedPassword = "$y$j9T$qH9rynM1KrfHgs8.1bZ0Z/$aBOWzink2fHF3CBLhGta6V0KslNyY5IqTO5dN0TfUu6";

  boot.loader.grub.device = "/dev/vda";
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
}
