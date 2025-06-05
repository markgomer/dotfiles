{ pkgs, username, ... }:
let
  inherit (import ../variables.nix) keyboardLayout;
in {
  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          # start Hyprland with a TUI login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; 
        };
      };
    };
    
    smartd = {
      enable = false;
      autodetect = true;
    };
    
	  gvfs.enable = true;
	  tumbler.enable = true;

	  pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
    };
	
    #pulseaudio.enable = false; #unstable
	  udev.enable = true;
	  envfs.enable = true;
	  dbus.enable = true;

	  fstrim = {
      enable = true;
      interval = "weekly";
    };
  
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
  
    openssh.enable = true;
    flatpak.enable = true;
	
  	blueman.enable = true;
  	
	  fwupd.enable = true;

	  upower.enable = true;
    
    gnome.gnome-keyring.enable = true;
    
    printing = {
      enable = false;
      # drivers = [
      #   pkgs.hplipWithPlugin
      # ];
    };

    undervolt = {
      enable = true;
      coreOffset = -127;
      gpuOffset = -320;
      analogioOffset = -127;
      uncoreOffset = -127;
    };
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};

  };
}
