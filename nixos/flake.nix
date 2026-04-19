{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    git_progress_sync.url = "github:Peanutt42/git_progress_sync";
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      git_progress_sync,
      ...
    }:
    let
      tmux-fork-overlay = import ./overlays/tmux-fork.nix;

      mkSystem =
        { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              tmux-fork-overlay
              git_progress_sync.overlays.default
            ];
          };
          modules = [ ./modules/shared.nix ] ++ modules;
        };
    in
    {
      nixosConfigurations.pc = mkSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/pc/configuration.nix
        ];
      };

      nixosConfigurations.framework-laptop = mkSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.framework-amd-ai-300-series
          ./hosts/framework-laptop/configuration.nix
        ];
      };

      nixosConfigurations.lenovo-laptop = mkSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/lenovo-laptop/configuration.nix
        ];
      };

      nixosConfigurations.pi = mkSystem {
        system = "aarch64-linux";
        modules = [
          # nixos-hardware.nixosModules.raspberry-pi-4
          ./hosts/pi/configuration.nix
        ];
      };
    };
}
