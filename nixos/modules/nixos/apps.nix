{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    starship
    zoxide
    eza
    bat
    yazi
    fastfetch
    stow
    htop
    btop

    tmux # forked version! (see ../overlays/tmux-fork.nix)
    tmux-sessionizer

    gwq # build from source (see ../overlays/gwq/overlay.nix)

    podman

    openstackclient
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    extraSetFlags = [
      "--accept-dns=false"
      "--operator=peter"
    ];
  };
}
