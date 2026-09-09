{ ... }:

{
  services.vikunja = {
    enable = true;
    frontendScheme = "https";
    frontendHostname = "vikunja.peternhennig.de";
    port = 3456;
    database.type = "sqlite";
  };
}
