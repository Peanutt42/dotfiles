{ config, ... }:

{
  caddy.privateServices."vikunja".port = config.services.vikunja.port;

  services.vikunja = {
    enable = true;
    frontendScheme = "https";
    frontendHostname = "vikunja.sh.peternhennig.de";
    port = 3456;
    database.type = "sqlite";
  };
}
