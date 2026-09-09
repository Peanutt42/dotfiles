{ lib, ... }:

{
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group"
      "--group-directories-first"
      "--color-scale=all"
    ];
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      vim = "nvim";
      nv = "nvim";
      v = "nvim";
      lg = "lazygit";
    };

    shellAliases = {
      llm = "__fish_eza_llm";
      tree = "__fish_eza_tree";
    };

    functions = {
      __fish_eza_llm = {
        body = "eza --all --header --long --sort=modified $argv";
        wraps = "eza";
      };

      __fish_eza_tree = {
        body = "eza --tree $argv";
        wraps = "eza";
      };

      git-clone-setup-gh-codeberg = {
        body = lib.fileContents ./git-clone-setup-gh-codeberg.fish;
        argumentNames = [
          "repo"
          "codeberg_url"
          "github_url"
        ];
      };

      __tmux_sessionizer_bind = {
        body = ''
          commandline -r "tms"
          commandline -f execute
        '';
      };

      fish_user_key_bindings = {
        body = ''
          bind \b 'backward-kill-word'
          bind \e\[3\;5~ 'kill-word'
          bind \cf __tmux_sessionizer_bind
        '';
      };
    };

    shellInit = lib.fileContents ./shellInit.fish;

    interactiveShellInit = lib.fileContents ./interactiveShellInit.fish;
  };
}
