{
    description = "New Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        # sudo nixos-rebuild switch --flake .#avell --impure
        nixosConfigurations.avell = nixpkgs.lib.nixosSystem {
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
            ];
        };
    };
}
