{ pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;

    dbBackend = "sqlite";

    config = {
      DOMAIN = "https://vault.peternhennig.de";
      SIGNUPS_ALLOWED = true;

      ADMIN_TOKEN = "$argon2id$v=19$m=65540,t=3,p=4$aldd9IORgZ3YEV6EG6zZjZ25AhLxl/7EclGdhtWYdGM$GelFpVqtqKfD5oe4+dkXzMcl88rQ0CcBKD28+2T5mXI";
      LOG_FILE = "/var/lib/vaultwarden/access.log";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };

  environment.systemPackages = with pkgs; [ vaultwarden ];
}
