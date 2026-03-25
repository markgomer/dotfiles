{ ... }:
{
    flake.nixosModules.HyprModule = { pkgs, pkgs-unstable, ... }: {
        programs.hyprland = {
            enable = true;
            withUWSM = false;
            xwayland.enable = true;
        };

        services = {
            upower.enable = true; # Battery status
            gnome.gnome-keyring.enable = true;
        };

        environment.systemPackages = [
            pkgs-unstable.noctalia-shell
            pkgs.kitty                 # we might get cooked without this
            pkgs.hyprpolkitagent       # or polkit_gnome
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl         # for laptop brightness
            pkgs.nwg-look              # GTK theme configurator
            pkgs.nwg-displays
            pkgs.grim
            pkgs.slurp            # screenshots
            pkgs.pavucontrol           # audio GUI fallback
            pkgs.upower
        ];
    };
}
