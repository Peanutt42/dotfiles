{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.caddy = {
    privateServices = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.attrTag {
          port = lib.mkOption {
            type = lib.types.port;
            description = "Local port to reverse proxy to.";
          };
          caddyConfig = lib.mkOption {
            type = lib.types.lines;
            description = "Raw Caddy configuration.";
          };
        }
      );
      description = "a map of subdomain names (subdomain.sh.peternhennig.de) to either a local port to reverse proxy or custom caddy config";
    };
    extraPublicDomainCaddyConfigs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "list of extra caddy configuration to inject into the base domain (peternhennig.de)";
    };
  };

  config = {
    sops.secrets."caddy-cloudflare-env" = {
      sopsFile = ../../../secrets/caddy-cloudflare.env;
      owner = "caddy";
      group = "caddy";
      mode = "0400";
      format = "dotenv";
    };

    services.caddy =
      let
        cfg = config.caddy;
        domain = "peternhennig.de";
        privateServicesDomain = "sh.${domain}"; # sh = self-hosted
        match =
          value: cases:
          let
            tag = builtins.head (builtins.attrNames value);
          in
          cases.${tag} value.${tag};
        handlePrivateService = name: portOrCaddyConfig: ''
          @${name} host ${name}.${privateServicesDomain}
          handle @${name} {
          ${match portOrCaddyConfig {
            port = port: "reverse_proxy 127.0.0.1:${toString port}";
            caddyConfig = config: config;
          }}
          }
        '';
      in
      {
        enable = true;

        virtualHosts = {
          # public site: portfolio (+ matrix feredation)
          "http://${domain}:8080".extraConfig = ''
            bind 127.0.0.1

            ${lib.concatStrings cfg.extraPublicDomainCaddyConfigs}

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
          + lib.concatStrings (lib.mapAttrsToList handlePrivateService cfg.privateServices)
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
  };
}
