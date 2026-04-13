{ pkgs, ... }:

{
  programs.firefox.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run

    thunderbird
    zapzap
    vesktop

    bitwarden-desktop
    ente-auth

    localsend

    obs-studio

    # proton-vpn ???

    p3x-onenote

    anki-bin

    spotify

    libreoffice

    gimp

    kitty

    sioyek

    mission-center

    winboat
    freerdp

    podman-desktop

    # also development, but more GUI
    github-desktop
    gitkraken
    zed-editor

    # cursor
    bibata-cursors

    # font
    nerd-fonts.jetbrains-mono
  ];
}
