{ pkgs, ... }:

{
  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
    # disabled cuz for some reason it breaks my nixos build process as sqhinx docu>
    enableCalendarEvents = false;
  };
  programs.dsearch.enable = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

  programs.xwayland.enable = true;
  environment.systemPackages = [ pkgs.xwayland-satellite ];
}
