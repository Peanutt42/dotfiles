{ config, ... }:

{
  sops.secrets."grafana/secret_key" = {
    sopsFile = ../secrets/grafana.yaml;
    owner = "grafana";
    group = "grafana";
    mode = "0400";
  };

  services.grafana = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "grafana.peternhennig.de";
        serve_from_sub_path = true;
      };
      security = {
        secret_key = "$__file{${config.sops.secrets."grafana/secret_key".path}}";
      };
    };
  };
}
