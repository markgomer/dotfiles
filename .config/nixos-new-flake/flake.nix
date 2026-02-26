{
    description = "New Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:nix-community/stylix/release-25.11";
    };

    outputs = { self, nixpkgs, home-manager, stylix, ... }: {
        # sudo nixos-rebuild switch --flake .#avell --impure
        nixosConfigurations.avell = nixpkgs.lib.nixosSystem {
            # avell Serial number = GI5KN4721712000??
            modules = [
                # Ensure this exists via nixos-generate-config
                /etc/nixos/hardware-configuration.nix
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.majunior.imports = [
                            ./home.nix
                        ];
                    };
                }
                stylix.nixosModules.stylix
            ];
        };
    };
}
