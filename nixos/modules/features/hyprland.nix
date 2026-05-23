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
            # NOTE: disabled in favor of noctalia plugin
            # pkgs.hyprpolkitagent # or polkit_gnome
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl # laptop brightness
            pkgs.nwg-look # GTK theme configurator
            pkgs.nwg-displays # multiple display configuration
            pkgs.grimblast # screenshots
            pkgs.pavucontrol # audio GUI fallback
            pkgs.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs.playerctl # for using keyboard media keys
            pkgs-unstable.ianny # break reminder program

            # screen tools plugin dependencies
            pkgs.grim
            pkgs.slurp
            pkgs.tesseract
            pkgs.imagemagick
            pkgs.zbar
            pkgs.translate-shell
            pkgs.wl-screenrec
            pkgs.ffmpeg
            pkgs.gifski
            pkgs.jq
        ];
    };
}
