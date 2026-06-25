{
  lib,
  pkgs,
  config,
  ...
}:

{
  options = {
    headless = lib.mkOption {
      default = false;
    };
  };

  config = {
    environment.systemPackages =
      with pkgs;
      [
        unzip
        starship
        zoxide
        fastfetch
        stow
        htop
        btop

        tmux # forked version! (see ../overlays/tmux-fork.nix)
        tmux-sessionizer

        gwq # build from source (see ../overlays/gwq/overlay.nix)

        podman
      ]
      ++ lib.optionals (!config.headless) [
        appimage-run
        steam

        wl-clipboard # needed by tmux-yank

        thunderbird
        zapzap
        vesktop

        bitwarden-desktop
        ente-auth

        obs-studio

        proton-vpn

        p3x-onenote

        (anki.withAddons [
          pkgs.ankiAddons.review-heatmap
        ])

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
        jetbrains.idea-oss
        vscode

        # cursor
        bibata-cursors

        # font
        nerd-fonts.jetbrains-mono

        # cisco anyconnect vpn: uni-ulm
        openconnect
        networkmanager-openconnect
        gp-saml-gui

        # 3d printing
        orca-slicer
      ];

    programs.firefox.enable = lib.mkIf (!config.headless) true;

    services.flatpak.enable = lib.mkIf (!config.headless) true;

    programs.localsend = {
      enable = !config.headless;
      openFirewall = true;
    };
  };
}
