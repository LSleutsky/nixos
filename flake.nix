{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:

  let
    system = "x86_64-linux";
    overlays = [ inputs.neovim-nightly-overlay.overlay ];
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      hyprnova = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lush = import ./home;
            nixpkgs.overlays = overlays;
          }
        ];
      };                                                                                 
    };
  };
}
