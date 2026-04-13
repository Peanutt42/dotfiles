{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.adguardhome = {
    enable = true;

    # web ui
    port = 3003;
    # opens firewall just for the web ui
    openFirewall = true;

    settings = {
      dns = {
        port = 53;

        upstream_dns = [
          "1.1.1.1" # cloudflare dns
          "8.8.8.8" # google dns
        ];
      };

      filters =
        map
          (url: {
            enabled = true;
            url = url;
          })
          [
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # AdGuard DNS filter
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt" # AdAway Default Blocklist
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_50.txt" # uBlock filters - badware risks
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt" # OISD Block list Big
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_51.txt" # HaGeZi's Pro++ Blocklist
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_44.txt" # HaGeZi's Threat Intelligence Feeds
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt" # Steven Black's List
          ];
    };
  };

  # open firewall for dns queries
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
