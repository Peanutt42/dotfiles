{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.adguardhome = {
    enable = true;
    host = "127.0.0.1";
    port = 3003;
    openFirewall = true;
  };
}
