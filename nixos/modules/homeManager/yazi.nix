{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    keymap.mgr.prepend_keymap = [
      {
        on = [
          "g"
          "i"
        ];
        run = "plugin lazygit";
        desc = "run lazygit";
      }
    ];
    plugins = with pkgs.yaziPlugins; {
      git = {
        package = git;
        setup = true;
        settings = {
          order = 1500;
        };
      };
      lazygit = {
        package = lazygit;
      };
      starship = {
        package = starship;
        setup = true;
      };
    };
    settings = {
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];
    };
  };
}
