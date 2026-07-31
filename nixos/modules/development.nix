{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    full = lib.mkOption {
      default = true;
      description = "whether to include tools like ghc, hls, jdk, gradle, maven, etc.";
    };
  };

  config = {
    programs.fish.enable = true;

    environment.systemPackages =
      with pkgs;
      [
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

        git
        git-lfs
        lazygit
        delta # syntax highlighter for (lazy-)git
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

        cloudflared
      ]
      ++ lib.optionals (config.full) [
        jdk21
        maven
        gradle

        cargo-tauri
        sqlx-cli
        trunk

        typst
        typstyle
        typst-live
        tinymist

        # haskell
        ghc
        cabal-install
        haskell-language-server
        hlint
      ];

    programs.java = {
      enable = config.full;
      package = pkgs.jdk21;
    };
  };
}
