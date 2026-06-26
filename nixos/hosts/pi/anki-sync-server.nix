{ ... }:

{
  services.anki-sync-server = {
    enable = true;
    openFirewall = true;
    port = 27701;
    users = [
      {
        username = "peter";
        # hashed
        password = "$pbkdf2-sha256$i=600000,l=32$737AaYXuePeO9IUQTSJEsA$537Kgu+XLyiqUM6sVIBi7x4vrWUyyECepTinl9U4MM8";
      }
    ];
  };

  systemd.services.anki-sync-server.environment.PASSWORDS_HASHED = "1";
}
