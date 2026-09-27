{
  lib,
  config,
  pkgs,
  ...
}:

# TODO: move from .extraConfig = '''' to using the provided types by the module

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
    in
    {
      enable = true;

      virtualHosts = {
        # public site: portfolio (+ matrix feredation)
        "http://${domain}:8080".extraConfig =
          let
            matrixWellKnownResponseServer = ''{"m.server":"matrix.peternhennig.de:443"}'';
            matrixWellKnownResponseClient = ''{"m.homeserver":{"base_url":"https://matrix.peternhennig.de"}}'';
          in
          ''
            bind 127.0.0.1

            # enables federation of matrix server from peternhennig.de -> matrix.peternhennig.de
            handle /.well-known/matrix/server {
              header Content-Type application/json
              respond `${matrixWellKnownResponseServer}` 200
            }
            handle /.well-known/matrix/client {
              header Content-Type application/json
              header Access-Control-Allow-Origin *
              respond `${matrixWellKnownResponseClient}` 200
            }

            root * /var/www/portfolio
            file_server
            encode gzip
          '';

        # public site: ASQ Raumreservierung (TODO: remove, this is done...)
        "http://raumreservierung.${domain}:8080".extraConfig = ''
          bind 127.0.0.1
          root * /var/www/raumreservierung
          file_server
          encode gzip
        '';

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
      };

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
