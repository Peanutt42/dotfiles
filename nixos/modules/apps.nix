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
      ]
      ++ lib.optionals (!config.headless) [
        appimage-run

        thunderbird
        zapzap
        vesktop

        bitwarden-desktop
        ente-auth

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
        jetbrains.idea
        vscode

        # cursor
        bibata-cursors

        # font
        nerd-fonts.jetbrains-mono

        # cisco anyconnect vpn: uni-ulm
        openconnect
        networkmanager-openconnect
        gp-saml-gui
      ];

    programs.firefox.enable = lib.mkIf (!config.headless) true;

    services.flatpak.enable = lib.mkIf (!config.headless) true;

    programs.localsend = {
      enable = !config.headless;
      openFirewall = true;
    };
  };
}
