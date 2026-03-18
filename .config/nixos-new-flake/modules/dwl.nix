{ pkgs, lib, config, ... }:

{
    options = {
        dwlModule.enable = lib.mkEnableOption "Enables DWL";
    };
    config = lib.mkIf config.dwlModule.enable {

        environment.systemPackages = with pkgs; [
            wayland
            wayland-protocols
            wlroots_0_19
            foot
            git
            wmenu
            wl-clipboard
            grim
            slurp
            swaybg
            firefox
            jetbrains-mono
        ];

    };
}
