{ config, ... }:

{
  sops.secrets."anki-sync-server/password".sopsFile = ../secrets/anki-sync-server.yaml;

  services.anki-sync-server = {
    enable = true;
    openFirewall = true;
    port = 27701;
    users = [
      {
        username = "peter";
        passwordFile = config.sops.secrets."anki-sync-server/password".path;
      }
    ];
  };
}
