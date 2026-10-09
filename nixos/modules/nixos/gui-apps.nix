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
    element-desktop

    # wraps bitwarden-desktop but with SECURE_KEY_CONTAINER_BACKEND=keyctl in order to not block hibernation (would use secretmem)
    # (this is fine since we have full disk encryption + secure boot)
    (pkgs.symlinkJoin {
      name = "bitwarden-desktop-with-keyctl";
      paths = [ pkgs.bitwarden-desktop ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/bitwarden" --set SECURE_KEY_CONTAINER_BACKEND keyctl
      '';
    })

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

    wezterm

    mission-center
    nethogs # used by mission-center

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

    screen-message
  ];

  programs.firefox.enable = true;

  services.flatpak.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # for mission-center: https://gitlab.com/mission-center-devs/mission-center/-/wikis/Home/CPU
  services.udev.extraRules = ''
    SUBSYSTEM=="powercap", KERNEL=="intel-rapl*", \
        RUN+="${pkgs.coreutils}/bin/chmod -R a+r /sys/%p/"
  '';
  # for mission-center: https://gitlab.com/mission-center-devs/mission-center/-/wikis/Home/Nethogs
  security.wrappers.nethogs = {
    source = "${pkgs.nethogs}/bin/nethogs";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,o+rx";
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
}
