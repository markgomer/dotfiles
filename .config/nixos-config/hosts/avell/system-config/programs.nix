{ pkgs, ... }:
{
  programs = {
	  firefox.enable = true;

    git.enable = true;

    nm-applet.indicator = true;

	  thunar = {
      enable = true;
	    plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };
    
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
    };

    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
