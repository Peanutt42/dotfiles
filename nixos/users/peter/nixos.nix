{ pkgs, ... }:

{
  users.users.peter = {
    isNormalUser = true;
    description = "Peter";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
      "docker"
      "greeter"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
