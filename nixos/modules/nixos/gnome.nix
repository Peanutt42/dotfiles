{ ... }:

{
  # GNOME Desktop Environment
  services.desktopManager.gnome.enable = true;

  # Online Accounts
  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
