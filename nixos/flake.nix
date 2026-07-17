{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git_progress_sync = {
      url = "github:Peanutt42/git_progress_sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    no_bs_habit_tracker = {
      url = "github:Peanutt42/no_bs_habit_tracker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      dms-plugin-registry,
      git_progress_sync,
      no_bs_habit_tracker,
      ...
    }:
    let
      tmux-fork-overlay = import ./overlays/tmux-fork.nix;
      gwq-overlay = import ./overlays/gwq.nix;
      bitwarden-desktop-overlay = import ./overlays/bitwarden-desktop.nix;

      mkSystem =
        { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                # since bitwarden uses EOL electron
                "electron-39.8.10"
              ];
            };
            overlays = [
              tmux-fork-overlay
              git_progress_sync.overlays.default
              gwq-overlay
              bitwarden-desktop-overlay
            ];
          };
          modules = [
            ./modules/shared.nix

            # does not enable the service, just adds the option
            no_bs_habit_tracker.nixosModules.default
          ]
          ++ modules;
          specialArgs = { inherit dms-plugin-registry; };
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

      packages.x86_64-linux.bwcloud-qcow2 =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          bw-cloud = mkSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/bwcloud/configuration.nix
            ];
          };
        in
        pkgs.callPackage "${nixpkgs}/nixos/lib/make-disk-image.nix" {
          inherit pkgs;
          lib = pkgs.lib;

          config = bw-cloud.config;

          format = "qcow2";
        };
    };
}
