{ pkgs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    rustup
    gcc
    clang
    clang-tools
    cmake
    gnumake
    ninja
    pkg-config
    python3
    just
    nodejs

    jdk21
    maven
    gradle

    cargo-tauri
    sqlx-cli
    trunk

    git
    lazygit
    gh
    git_progress_sync # not in nixpkgs, but added using overlay (see ../flake.nix)

    neovim
    ripgrep
    fzf
    # lsp
    nixd
    nixfmt

    cloudflared
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
