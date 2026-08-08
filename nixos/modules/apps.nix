{
  lib,
  pkgs,
  config,
  ...
}:

{
  options.apps = {
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

        openstackclient
      ]
      ++ lib.optionals (!config.apps.headless) [
        appimage-run
        steam

        wl-clipboard # needed by tmux-yank

        thunderbird
        zapzap
        signal-desktop
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

    programs.firefox.enable = lib.mkIf (!config.apps.headless) true;

    services.flatpak.enable = lib.mkIf (!config.apps.headless) true;

    services.tailscale = {
      enable = true;
    };

    programs.localsend = {
      enable = !config.apps.headless;
      openFirewall = true;
    };
  };
}
