{ config, lib, ... }:

{
  options.secure-boot = {
    enable = lib.options.mkEnableOption "Secure boot using lanzaboote";

    includeFirmwareBuiltinKeys = lib.options.mkOption {
      type = lib.types.bool;
      default = true;
      description = "whether lanzaboote should include the --firmware builin keys when auto-enrolling the keys";
    };
  };

  config =
    let
      cfg = config.secure-boot;
    in
    lib.mkIf cfg.enable {
      # secure boot
      boot.loader.systemd-boot.enable = lib.mkForce false; # lanzaboote replaces the systemd-boot module
      boot.lanzaboote = {
        enable = true;
        autoEnrollKeys = {
          enable = true;
          includeFirmwareBuiltinKeys = cfg.includeFirmwareBuiltinKeys;
        };
        autoGenerateKeys.enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
}
