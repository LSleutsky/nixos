{
  description = "NixOS Configuration";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    dipc.url = "github:doprz/dipc";
    helix.url = "github:helix-editor/helix";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    nur.url = "github:nix-community/NUR";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, nixos-hardware, chaotic, home-manager, nixvim, ... }@inputs:

  let
    system = "x86_64-linux";
    overlays = [inputs.neovim-nightly-overlay.overlay];
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      hyprnova = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          chaotic.nixosModules.default
          nixos-hardware.nixosModules.framework-12th-gen-intel
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.lush = import ./home-manager;
            nixpkgs.overlays = overlays;
          }
          nixvim.nixosModules.nixvim
					./nixvim
        ];
      };                                                                                 
    };
  };
}
