{
  ...
}:

{
  systemd.services.docker-kosync = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  virtualisation.oci-containers = {
    backend = "docker";

    containers.kosync = {
      image = "koreader/kosync:latest";

      ports = [ "17200:17200" ];

      volumes = [
        "/var/lib/kosync/logs/app:/app/koreader-sync-server/logs"
        "/var/lib/kosync/logs/redis:/var/log/redis"
        "/var/lib/kosync/data/redis:/var/lib/redis"
      ];

      autoStart = true;
    };
  };
}
