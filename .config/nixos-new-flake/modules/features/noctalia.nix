{ inputs, ... }: {
    perSystem = { system, ... }:
    let
        pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        packages.NoctaliaConfig = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit pkgs-unstable;
            settings = (builtins.fromJSON
                (builtins.readFile ./noctalia.json)).settings;
        };
    };
}
