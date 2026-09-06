{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    appimage-run
    steam

    wl-clipboard # needed by tmux-yank

    thunderbird
    zapzap
    signal-desktop
    slack
    vesktop

    bitwarden-desktop
    ente-auth

    obs-studio

    proton-vpn

    p3x-onenote

    (anki.withAddons [
      pkgs.ankiAddons.review-heatmap
    ])

    libreoffice

    gimp
    inkscape

    kitty

    mission-center

    winboat
    freerdp

    podman-desktop

    # also development, but more GUI
    github-desktop
    gitkraken
    zed-editor
    jetbrains.idea-oss
    vscode

    # cursor
    bibata-cursors

    # font
    nerd-fonts.jetbrains-mono

    # icons
    tela-icon-theme

    # cisco anyconnect vpn: uni-ulm
    openconnect
    networkmanager-openconnect
    gp-saml-gui

    # 3d printing
    orca-slicer
  ];

  programs.firefox.enable = true;

  services.flatpak.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
