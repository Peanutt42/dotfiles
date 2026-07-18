{ ... }:

{
  services.vikunja = {
    enable = true;
    frontendScheme = "http";
    frontendHostname = "localhost";
    port = 3456;
    database.type = "sqlite";
  };
}
