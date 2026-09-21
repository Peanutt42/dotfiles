{
  lib,
  config,
  pkgs,
  ...
}:

{
  sops.secrets."caddy-cloudflare-env" = {
    sopsFile = ../../../secrets/caddy-cloudflare.env;
    owner = "caddy";
    group = "caddy";
    mode = "0400";
    format = "dotenv";
  };

  services.caddy =
    let
      domain = "peternhennig.de";
      privateServicesDomain = "sh.${domain}"; # sh = self-hosted
      privateServices = {
        "adguard" = 3003;
        "octoprint" = 5000;
        "vault" = 8222;
        "anki" = 27701;
        "vikunja" = 3456;
        "backrest" = 9898;
      };
      handlePrivateService = name: port: ''
        @${name} host ${name}.${privateServicesDomain}
        handle @${name} {
          reverse_proxy 127.0.0.1:${toString port}
        }
      '';
      # run on http://localhost:8080
      publicStaticSites = {
        "${domain}" = "/var/www/portfolio";
        "raumreservierung.${domain}" = "/var/www/raumreservierung";
      };
      handlePublicStaticSite = full_domain: dir: {
        "http://${full_domain}:8080".extraConfig = ''
          bind 127.0.0.1
          root * ${dir}
          file_server
          encode gzip
        '';
      };
    in
    {
      enable = true;

      virtualHosts = {
        # private services
        "*.${privateServicesDomain}".extraConfig = ''
          tls {
            dns cloudflare {env.CF_API_TOKEN}
            resolvers 1.1.1.1
          }
        ''
        + lib.concatStrings (lib.mapAttrsToList handlePrivateService privateServices)
        + ''
          handle {
            abort
          }
        '';
      }
      # public static sites
      // lib.mergeAttrsList (lib.mapAttrsToList handlePublicStaticSite publicStaticSites);

      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/cloudflare@v0.2.4"
        ];
        hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
      };
    };

  systemd.services.caddy.serviceConfig.EnvironmentFile =
    config.sops.secrets."caddy-cloudflare-env".path;

  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [ 443 ];
  };
}
