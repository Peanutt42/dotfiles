{ ... }:

{
  services.flatpak = {
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    uninstallUnmanaged = true; # only packages declared here are allowed to be installed :3
    packages = [
      "app.zen_browser.zen"
      "com.github.tchx84.Flatseal"
      "com.google.AndroidStudio"
      "com.google.Chrome"
      "com.spotify.Client"
      "io.vikunja.Vikunja"
    ];
  };
}
