{ pkgs, config, ... }:

let
  baseDomain = "peternhennig.de";
in
{
  services.postgresql.enable = true;
  # ALTER ROLE "matrix-synapse" PASSWORD null;
  services.postgresql.initialScript = pkgs.writeText "synapse-init.sql" ''
    CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
    CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
      TEMPLATE template0
      LC_COLLATE = "C"
      LC_CTYPE = "C";
  '';

  sops.secrets."matrix/synapse/registration_shared_secret" = {
    sopsFile = ../../../secrets/matrix.yaml;
    owner = "matrix-synapse";
    mode = "0400";
  };

  caddy.extraPublicDomainCaddyConfigs =
    let
      matrixWellKnownResponseServer = ''{"m.server":"matrix.peternhennig.de:443"}'';
      matrixWellKnownResponseClient = ''{"m.homeserver":{"base_url":"https://matrix.peternhennig.de"}}'';
    in
    [
      ''
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
      ''
    ];

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = baseDomain;
      registration_shared_secret_path =
        config.sops.secrets."matrix/synapse/registration_shared_secret".path;
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "localhost" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = false;
            }
          ];
        }
      ];
    };
  };
}
