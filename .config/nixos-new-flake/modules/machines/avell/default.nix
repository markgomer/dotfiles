{ self, inputs, ... }:
{
    flake.nixosConfigurations = {
        avell = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = let
                system = "x86_64-linux";
            in {
                pkgs-unstable = import inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                };
            };

            modules = [
                self.nixosModules.AvellConfiguration
                self.nixosModules.HyprModule
                self.nixosModules.majuniorHome
                self.nixosModules.DisplayManagerModule
                inputs.stylix.nixosModules.stylix
            ];
        };
    };
}
