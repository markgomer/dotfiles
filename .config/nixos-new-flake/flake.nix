{
    description = "Check out this one configuration!";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:nix-community/stylix/release-25.11";

        # Framework to structure flake.
        # Can name and import modules by name.
        flake-parts.url = "github:hercules-ci/flake-parts";
        # Import all modules recursively.
        import-tree.url = "github:vic/import-tree";

        # Used to configure programs.
        wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    };

    outputs = inputs: inputs.flake-parts.lib.mkFlake {
        inherit inputs;
    } (inputs.import-tree ./modules);
}
