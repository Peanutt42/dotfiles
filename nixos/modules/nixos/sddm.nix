{ pkgs, inputs, ... }:

{
  imports = [
    inputs.silentSDDM.nixosModules.default
  ];

  security.pam.services.login.fprintAuth = false;

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
    ];
  };

  programs.silentSDDM = {
    enable = true;
    theme = "default";
    backgrounds.default = ../../wallpapers/greeter.png;
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
