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

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux-sessionizer = {
      url = "github:Peanutt42/tmux-sessionizer/feat/create-windows-for-worktrees";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    oniri = {
      url = "github:Peanutt42/oniri/feat/nix-flake";
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
      silentSDDM,
      sops-nix,
      tmux-sessionizer,
      oniri,
      ...
    }:
    let
      tmux-fork-overlay = import ./overlays/tmux-fork.nix;
      gwq-overlay = import ./overlays/gwq.nix;

      mkSystem =
        { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                "electron-40.10.5" # bitwarden-desktop uses EOL
                "idea-oss-2025.3.4" # jetbrains...
              ];
            };
            overlays = [
              tmux-fork-overlay
              git_progress_sync.overlays.default
              gwq-overlay
              tmux-sessionizer.overlays.default
              oniri.overlays.default
            ];
          };
          modules = [
            ./modules/shared.nix

            # does not enable the service, just adds the option
            no_bs_habit_tracker.nixosModules.default

            silentSDDM.nixosModules.default

            sops-nix.nixosModules.sops
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
          nixos-hardware.nixosModules.raspberry-pi-4
          ./hosts/pi/configuration.nix
        ];
      };
      nixosConfigurations.bwcloud = mkSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bwcloud/configuration.nix
        ];
      };

      packages.x86_64-linux.bwcloud-qcow2 =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        pkgs.callPackage "${nixpkgs}/nixos/lib/make-disk-image.nix" {
          inherit pkgs;
          lib = pkgs.lib;

          config = self.nixosConfigurations.bwcloud.config;

          format = "qcow2-compressed";
        };
    };
}
