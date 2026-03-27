{ ... }:
{
    flake.nixosModules.HyprModule = { pkgs, pkgs-unstable, ... }: {
        programs.hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
        };

        services = {
            power-profiles-daemon.enable = true;
            upower.enable = true; # Battery status
            gnome.gnome-keyring.enable = true;
            logind = {
                settings = {
                    Login = {
                        HandleLidSwitchDocked = "ignore";
                        HandleLidSwitchExternalPower = "ignore";
                        HandleLidSwitch = "ignore";
                    };
                };
            };
        };

        environment.systemPackages = [
            pkgs-unstable.noctalia-shell # legendary shell
            pkgs.kitty # we might get cooked without this
            pkgs.hyprpolkitagent # or polkit_gnome
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl # laptop brightness
            pkgs.nwg-look # GTK theme configurator
            pkgs.nwg-displays # multiple display configuration
            pkgs.grimblast # screenshots
            pkgs.pavucontrol # audio GUI fallback
            pkgs.wayland-pipewire-idle-inhibit
            pkgs.playerctl # for using keyboard media keys
        ];
    };
}
