{ self, inputs, ... }:
{
    flake.nixosConfigurations = {
        thinkpad = inputs.nixpkgs.lib.nixosSystem {
            specialArgs =
            let
                system = "x86_64-linux";
            in {
                pkgs-unstable = import inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                };
            };

            modules = [
                self.nixosModules.ThinkPadConfiguration
                self.nixosModules.NiriModule
                self.nixosModules.majuniorHome
                self.nixosModules.DisplayManagerModule
            ];
        };
    };
}
