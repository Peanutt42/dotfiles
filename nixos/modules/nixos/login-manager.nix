{ ... }:

{
  security.pam.services.login.fprintAuth = false;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife";
      bigclock_12hr = false;
      save = true;
      load = true;
    };
  };
}
