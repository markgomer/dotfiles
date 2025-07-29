{ pkgs, username, ... }:
let
  inherit (import ../variables.nix) keyboardLayout;
in {
  # Services to start
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
      };
    };
    keyd = {
      enable = true;
      keyboards = {
        # The name is just the name of the configuration file, it does not really matter
        default = {
          ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
          settings = {
            main = {
              capslock = "overload(control,esc)";
              esc = "capslock";
            };
          };
        };
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
    udev = {
      enable = true;
      # Thing for NS-USBLoader
      packages = [
         (pkgs.writeTextFile {
           name = "wally_udev";
           text = ''
             SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666";
            '';
           destination = "/etc/udev/rules.d/99-NS.rules";
         })
      ];
    };

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
	
  	#blueman.enable = true;

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
