{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/shared.nix
          ./hosts/pc/configuration.nix
        ];
      };
      nixosConfigurations.framework-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/shared.nix
          ./hosts/framework-laptop/configuration.nix

          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
      nixosConfigurations.lenovo-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/shared.nix
          ./hosts/lenovo-laptop/configuration.nix
        ];
      };
      nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";

        modules = [
          # nixos-hardware.nixosModules.raspberry-pi-4
          ./modules/shared.nix
          ./hosts/pi/configuration.nix
        ];
      };
    };
}
