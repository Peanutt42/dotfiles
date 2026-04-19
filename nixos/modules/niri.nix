{ pkgs, ... }:

{
  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
  };
  programs.dsearch.enable = true;
  programs.xwayland.enable = true;
  environment.systemPackages = [ pkgs.xwayland-satellite ];
}
