{ ... }:

{
  services.octoprint = {
    enable = true;
    openFirewall = true;
    plugins =
      plugins: with plugins; [
        themeify
        stlviewer
        bedlevelvisualizer
      ];
  };
}
