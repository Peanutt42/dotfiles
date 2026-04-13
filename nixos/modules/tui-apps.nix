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

    # tmux, build our own fork from source
    tmux-sessionizer

    podman
  ];
}
