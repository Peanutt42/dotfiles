{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.services.networking.eduroam;

  nmconnection = ''
    [connection]
    id=eduroam (nixos)
    uuid=89fc49fd-01ee-490a-ab0d-71d7cf48863b
    type=wifi
    autoconnect-priority=101
    permissions=user:${cfg.user}:;
    timestamp=1785490905

    [wifi]
    ssid=eduroam

    [wifi-security]
    group=ccmp;tkip;
    key-mgmt=wpa-eap
    pairwise=ccmp;
    proto=rsn;

    [802-1x]
    anonymous-identity=anonymous.PKIv4@${
      if cfg.domainFile != null then "$(cat ${cfg.domainFile})" else cfg.domain
    }
    ca-cert=${./ca.pem}
    domain-match=${if cfg.radiusFile != null then "$(cat ${cfg.radiusFile})" else cfg.radius}
    eap=ttls;
    identity=${if cfg.identityFile != null then "$(cat ${cfg.identityFile})" else cfg.identity}
    password=${if cfg.passwordFile != null then "$(cat ${cfg.passwordFile})" else cfg.password}
    password-flags=0
    phase2-auth=pap

    [ipv4]
    method=auto
    route-metric=100

    [ipv6]
    addr-gen-mode=default
    method=auto
    route-metric=100

    [proxy]
  '';
  script = pkgs.writeShellScript "eduroam-configure.sh" ''
    cat << EOF > /etc/NetworkManager/system-connections/eduroam.nmconnection
    ${nmconnection}
    EOF
  '';
in
{
  options.services.networking.eduroam = {
    enable = lib.mkEnableOption "eduroam";
    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    domainFile = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    radius = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    radiusFile = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    identity = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    identityFile = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    password = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    passwordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
    };
    user = lib.mkOption {
      type = lib.types.nonEmptyStr;
    };
    extraServiceConfig = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "f /etc/NetworkManager/system-connections/eduroam.nmconnection 600"
    ];

    systemd.services.eduroam-configure = lib.mergeAttrs {
      enable = true;
      description = "eduroam auto-config";
      before = [ "network-pre.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = script;
      };
    } cfg.extraServiceConfig;
  };
}
