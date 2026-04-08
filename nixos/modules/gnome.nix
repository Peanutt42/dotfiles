{ pkgs, ... }:

# GNOME Desktop Environment
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "niri";
}
