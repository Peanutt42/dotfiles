{ pkgs, ... }:

{
  services.displayManager.defaultSession = "niri";

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite # for X11 support on Wayland
    playerctl # for play/pause/prev/next etc. audio controls
    libqalculate # for calculator plugin
    pulseaudioFull # mainly for bluetooth audio codec
    oniri # forked, see flake inputs
  ];

  # make Chromium and Electron apps use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
