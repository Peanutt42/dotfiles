{ pkgs, ... }:

{
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
    github-desktop
    gitkraken

    neovim
    ripgrep
    fzf
    # lsp
    nixd
    nixfmt

    # tmux, build our own fork from source
    tmux-sessionizer

    zed-editor
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
