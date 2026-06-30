{ pkgs, dms-plugin-registry, ... }:

{
  imports = [ dms-plugin-registry.nixosModules.default ];

  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
    plugins = {
      dankBatteryAlerts.enable = true;
      calculator.enable = true;
      nixPackageRunner.enable = true;
    };
  };
  programs.dsearch.enable = true;
  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite # for X11 support on Wayland
    playerctl # for play/pause/prev/next etc. audio controls
    libqalculate # for calculator plugin
  ];
}
