{ ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."peternhennig.de" = {
      root = "/var/www/portfolio";
      listen = [
        {
          addr = "127.0.0.1";
          port = 8081;
        }
      ];
    };
    virtualHosts."raumreservierung.peternhennig.de" = {
      root = "/var/www/raumreservierung";
      listen = [
        {
          addr = "127.0.0.1";
          port = 8082;
        }
      ];
    };
  };
}
