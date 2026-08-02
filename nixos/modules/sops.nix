{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    ssh-to-age
  ];

  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/home/peter/.config/sops/age/keys.txt";
    };

    secrets = {
      "eduroam/domain" = {
        sopsFile = ../secrets/eduroam.yaml;
      };
      "eduroam/radius" = {
        sopsFile = ../secrets/eduroam.yaml;
      };
      "eduroam/identity" = {
        sopsFile = ../secrets/eduroam.yaml;
      };
      "eduroam/password" = {
        sopsFile = ../secrets/eduroam.yaml;
      };

      "anki-sync-server/password" = {
        sopsFile = ../secrets/anki-sync-server.yaml;
      };

      "restic/password" = {
        sopsFile = ../secrets/restic.yaml;
      };
    };
  };
}
