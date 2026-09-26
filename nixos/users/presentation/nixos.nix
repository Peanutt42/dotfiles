{ pkgs, ... }:

{
  users.users."presentation" = {
    description = "Presentation";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };

  programs.fish.enable = true;

  environment.systemPackages = [ pkgs.haskell-language-server ];
}
