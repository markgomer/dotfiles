{
    description = "New Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:nix-community/stylix/release-25.11";
    };

    outputs = { nixpkgs, nixpkgs-stable, home-manager, stylix, ... }: {
        nixosConfigurations = {
            # sudo nixos-rebuild switch --flake .#avell --impure
            # avell Serial number = GI5KN4721712000??
            avell = nixpkgs.lib.nixosSystem {
                specialArgs = let
                    system = "x86_64-linux";
                in {
                    pkgs-stable = import nixpkgs-stable {
                        inherit system;
                        config.allowUnfree = true;
                    };
                };
                modules = [
                    ./hosts/avell.nix
                    ./modules

                    home-manager.nixosModules.home-manager {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.majunior.imports = [ ./home/majunior.nix ];
                            backupFileExtension = "backup";
                        };
                    }
                    stylix.nixosModules.stylix
                ];
            };
        };
    };
}
