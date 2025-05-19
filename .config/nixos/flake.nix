{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-cachyos-kernel.url = "github:drakon64/nixos-cachyos-kernel";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cachyos-kernel, ... } @ inputs: {
    nixosConfigurations = {
      avell-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./custom-kernel.nix
          ./xfce.nix
          ./bluetooth.nix
          nixos-cachyos-kernel.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.majunior = import ./home.nix;
          }
        ];
      };
    };
  };
      # Optionally, use home-manager.extraSpecialArgs to pass
      # arguments to home.nix
}
