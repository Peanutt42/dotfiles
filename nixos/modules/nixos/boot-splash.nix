{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.boot-splash.enable = lib.options.mkEnableOption "Shows graphical luks passphrase prompt with cute nixos logo";

  config = lib.mkIf config.boot-splash.enable {
    boot.plymouth = {
      enable = true;
      font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf";
      logo = ../../wallpapers/boot_logo.png;
    };
  };
}
