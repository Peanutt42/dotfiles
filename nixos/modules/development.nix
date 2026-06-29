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

    direnv

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

    util-linux

    neovim
    ripgrep
    fzf
    # lsp
    nixd
    nixfmt
    tree-sitter
    prettier
    lua5_1
    luarocks
    wget
    fd

    typst
    typstyle
    typst-live
    tinymist

    cloudflared

    # haskell
    ghc
    cabal-install
    haskell-language-server
    hlint
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
