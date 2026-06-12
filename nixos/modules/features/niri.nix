{ ... }:
{
    flake.nixosModules.NiriModule = { pkgs, pkgs-unstable, ... }: {
        programs.niri = {
            enable = true;
            package = pkgs-unstable.niri;
            useNautilus = true;
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
            pkgs.alacritty # default terminal
            # NOTE: disabled in favor of noctalia plugin
            # pkgs.hyprpolkitagent # or polkit_gnome
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl # laptop brightness
            pkgs.nwg-look # GTK theme configurator
            pkgs.pavucontrol # audio GUI fallback
            pkgs.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs.playerctl # for using keyboard media keys
            pkgs-unstable.ianny # break reminder program
            pkgs-unstable.xwayland-satellite
            pkgs.swaybg # wallpaper

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
