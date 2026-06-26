{ pkgs, ... }:

let
  domain = "vault.peternhennig.de";
  bind_address = "127.0.0.1";
  port = 8222;
in
{
  services.vaultwarden = {
    enable = true;

    dbBackend = "sqlite";

    config = {
      DOMAIN = "https://${domain}";
      SIGNUPS_ALLOWED = true;

      ADMIN_TOKEN = "$argon2id$v=19$m=65540,t=3,p=4$aldd9IORgZ3YEV6EG6zZjZ25AhLxl/7EclGdhtWYdGM$GelFpVqtqKfD5oe4+dkXzMcl88rQ0CcBKD28+2T5mXI";
      LOG_FILE = "/var/lib/vaultwarden/access.log";

      ROCKET_ADDRESS = bind_address;
      ROCKET_PORT = port;
      ROCKET_LOG = "critical";
    };
  };

  environment.systemPackages = with pkgs; [ vaultwarden ];

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${domain}" = {
      extraConfig = ''
        access_log /var/log/nginx/${domain}.access.log;
        error_log /var/log/nginx/${domain}.error.log;
      '';

      locations."/" = {
        proxyPass = "http://${bind_address}:${toString port}";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
