{
    description = "New Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    };

    outputs = { self, nixpkgs, ... }: {
        nixosConfigurations.nixos-architect = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };
}
