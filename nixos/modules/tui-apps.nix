{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    rclone
    starship
    zoxide
    fastfetch
    stow
    htop
    btop

    tmux # forked version! (see ../overlays/tmux-fork.nix)
    tmux-sessionizer

    podman
  ];
}
