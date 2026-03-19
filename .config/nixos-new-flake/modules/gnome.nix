{ pkgs, lib, config, ... }:
{
    options = {
        gnomeModule.enable = lib.mkEnableOption "Enables Gnome";
    };
    config = lib.mkIf config.gnomeModule.enable {
        services = {
            displayManager = {
                gdm.enable = true;
            };
            desktopManager = {
                gnome.enable = true;
            };
            gnome = {
                core-apps.enable = false;
                gnome-software.enable = true;
            };
        };

        environment.systemPackages = with pkgs; [
            gnomeExtensions.pop-shell
        ];
    };
}
