{ pkgs, lib, config, ... }:
{
    options = {
        CosmicModule.enable = lib.mkEnableOption "Enables Cosmic";
    };
    config = lib.mkIf config.CosmicModule.enable {
        services = {
            displayManager = {
                # FIXME: ENABLE AFTER FINISHING TESTS
                cosmic-greeter.enable = true;
            };
            desktopManager = {
                cosmic = {
                    enable = true;
                    xwayland.enable = true;
                };
            };
        };

        # NOTE: for pkexec to work.
        systemd.user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };

        # environment.systemPackages = with pkgs; [ ];
    };
}
