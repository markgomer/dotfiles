
{
    imports = [
        # Ensure this exists via nixos-generate-config
        # sudo nixos-rebuild switch --flake .#avell --impure
        ./gnome.nix
        ./dwl.nix
    ];
}
