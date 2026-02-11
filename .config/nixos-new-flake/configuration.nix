{ config, pkgs, ... }:

{
    # Ensure this exists via nixos-generate-config.
    # This requires using the flag --impure when building.
    # I choose this to resist the urge to edit this file.
    imports = [ /etc/nixos/hardware-configuration.nix ];

    # --- 1. BOOTLOADER & VISUALS (Limine + Plymouth) ---
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        kernelModules = ["nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia"];
        kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "loglevel=3"
            "rd.systemd.show_status=false"
            "rd.udev.log_level=3"
            "udev.log_priority=3"
            "vt.global_cursor_default=0"
            "nvidia-drm.modeset=1"
        ];
        extraModprobeConfig = ''
            options nvidia_modeset vblank_sem_control=0 nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
        '';
        loader = {
            limine = {
                enable = true;
                # Customizing Limine: Place a 'background.png' in /boot/ or use 'config' attribute
                # to define colors/fonts. Limine looks for 'limine.conf' which NixOS generates.
            };
            timeout = 1;
            efi.canTouchEfiVariables = true;
        };
        plymouth = {
            enable = true;
            theme = "breeze";
        };
        consoleLogLevel = 0;
        initrd.verbose = false;
    };

    # Enable networking
    networking = {
        networkmanager.enable = true;
        hostName = "avell";
        # Open ports in the firewall.
        firewall.allowedTCPPorts = [ 53317 ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # networking.firewall.enable = false;

        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    # Select internationalisation properties.
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "pt_BR.UTF-8";
            LC_IDENTIFICATION = "pt_BR.UTF-8";
            LC_MEASUREMENT = "pt_BR.UTF-8";
            LC_MONETARY = "pt_BR.UTF-8";
            LC_NAME = "pt_BR.UTF-8";
            LC_NUMERIC = "pt_BR.UTF-8";
            LC_PAPER = "pt_BR.UTF-8";
            LC_TELEPHONE = "pt_BR.UTF-8";
            LC_TIME = "pt_BR.UTF-8";
        };
    };

    # Configure console keymap
    console.keyMap = "br-abnt2";

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false; # GTX 1050 Ti (Pascal) prefers proprietary over 'open' kernel modules
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };

    services = {
        xserver.videoDrivers = [ "nvidia" ];
        beesd = {
            filesystems = {
                root = {
                    spec = "LABEL=nixos";
                    hashTableSizeMB = 128;
                };
            };
        };
        # --- 3. DESKTOP & GAMING ---
        displayManager.gdm.enable = true;   
        desktopManager.gnome.enable = true; 
        gnome.core-apps.enable = false;

        printing.enable = true;

        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            #jack.enable = true;

            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            #media-session.enable = true;
        };

        flatpak.enable = true;

        undervolt = {
            enable = true;
            coreOffset = -127;
            gpuOffset = -320;
            analogioOffset = -127;
            uncoreOffset = -127;
        };

        udev.extraRules = ''
            SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
        '';

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
    };

    security.rtkit.enable = true;

    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };

    programs = {
        zsh.enable = true;
        starship.enable = true;

        nix-ld.enable = true; # Run Homebrew/external binaries seamlessly

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };
    };

    environment.systemPackages = with pkgs; [
        # Essentials
        unzip
        curl
        tree
        # python314 # for pokemon colorscripts
        linuxKernel.packages.linux_6_18.cpupower
        pciutils
        xdg-user-dirs

        # CLI Tools
        blueberry
        bluetui
        btop
        bat
        distrobox
        eza
        fastfetch
        git
        podman-compose
        tealdeer
        tmux
        yazi
        zoxide

        # lazyvim pack
        neovim
        fd
        lazygit
        ripgrep
        tree-sitter

        # Gnome system level
        gnomeExtensions.pop-shell
        nautilus

        # Theming
        adw-gtk3
        gtk3
        kdePackages.qt5compat
        kdePackages.qt6ct
        adwaita-qt6

        # Terminals
        kitty

        # Games
        lutris
        heroic

        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.caskaydia-mono
    ];

    users.users.majunior = {
        isNormalUser = true;
        description = "Marco Aurélio S.S.Jr";
        extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
        shell = pkgs.zsh;
        packages = with pkgs; [
            pokemon-colorscripts
        ];
    };


    # Nix Settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";
}
