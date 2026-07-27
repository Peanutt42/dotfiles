{ pkgs, ... }:

{
  security.pam.services.login.fprintAuth = false;

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
  };

  environment.etc."sddm.conf.d/hidpi.conf".text = ''
    [General]
    GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=1.75,QT_FONT_DPI=192
    inputs.

    [Wayland]
    EnableHiDPI=true
  '';

  programs.silentSDDM = {
    enable = true;
    theme = "default";
    backgrounds.default = ../wallpapers/greeter.png;
    settings = {
      "LoginScreen" = {
        background = "greeter.png";
      };
      "LockScreen" = {
        background = "greeter.png";
      };
    };
  };
}
