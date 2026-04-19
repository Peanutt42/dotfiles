{ ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."peternhennig.de" = {
      root = "/var/www/portfolio";
    };
  };
}
