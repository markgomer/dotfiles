{ ... } :
{
    flake.nixosModules.DisplayManagerModule = { pkgs, pkgs-unstable, ... }:
    let
        # https://github.com/Keyitdev/sddm-astronaut-theme
        myCustomSDDM = pkgs.sddm-astronaut.override {
            embeddedTheme = "pixel_sakura";
            # themeConfig = {
            #     # relative to your flake.
            #     # Supports: png, jpg, jpeg, webp, gif, avi, mp4, mov, mkv, m4v, webm.
            #     Background = "/path/to/your/wallpaper.png"; 
            # };
        };
    in {
        environment.systemPackages = [
            myCustomSDDM
            pkgs.hyprland-qt-support
        ];
        services = {
            displayManager = {
                sddm = {
                    enable = true;
                    wayland.enable = true;
                    theme = "sddm-astronaut-theme";
                    extraPackages = [
                        myCustomSDDM
                        pkgs.kdePackages.qtmultimedia
                        pkgs.hyprland-qt-support
                    ];
                    settings.Theme.ThemeDir = "${myCustomSDDM}/share/sddm/themes";
                };
                ly.enable = false;
                gdm.enable = false;
                sessionPackages = [
                    # pkgs.hyprland
                    pkgs-unstable.niri
                ];
            };
        };
    };
}
