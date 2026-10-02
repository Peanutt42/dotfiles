{
  ...
}:

let
  port = 17200;
in
{
  caddy.privateServices."kosync".port = port;

  systemd.services.docker-kosync = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  virtualisation.oci-containers = {
    backend = "docker";

    containers.kosync = {
      image = "koreader/kosync:latest";

      ports = [ "${toString port}:${toString port}" ];

      volumes = [
        "/var/lib/kosync/logs/app:/app/koreader-sync-server/logs"
        "/var/lib/kosync/logs/redis:/var/log/redis"
        "/var/lib/kosync/data/redis:/var/lib/redis"
      ];

      autoStart = true;
    };
  };
}
