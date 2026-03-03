{ config, pkgs, ... }:

{
    boot = {
        kernelPackages = pkgs.linuxPackages_6_18;
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
                # Customizing Limine: Place a 'background.png'
                # in /boot/limine/wallpapers or
                # use 'config' attribute to define colors/fonts.
                # Limine looks for 'limine.conf' which NixOS generates.
            };
            timeout = 1;
            efi.canTouchEfiVariables = true;
        };
        plymouth = {
            enable = true;
        };
        consoleLogLevel = 0;
        initrd.verbose = false;
    };

    networking = {
        networkmanager.enable = true;
        hostName = "avell";
        # Open ports in the firewall.
        firewall = {
            enable = true;
            allowedTCPPorts = [
                53317 # LocalSend
                631 # CUPS
            ];
            allowedUDPPorts = [];
        };
        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    time.timeZone = "America/Sao_Paulo";

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

    console.keyMap = "br-abnt2";

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false; #WARN: incompatible with 1050
            open = false; #WARN: GTX 1050 Ti (Pascal) prefers proprietary over 'open' kernel modules
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            prime.offload.enable = false; #WARN: GTX 1050 Ti is not compatible!
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

        printing = {
            enable = true;
            drivers = [
                pkgs.gutenprint
            ];
        };
        # guess I need this to print???
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true; # This opens the ports for discovery
        };

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

    stylix = {
        enable = true;
        polarity = "dark";
        targets.qt.enable = true;
        # https://tinted-theming.github.io/tinted-gallery/
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        # stylix.image = ./wallpaper.png;
        fonts = {
            serif = {
                package = pkgs.nerd-fonts.caskaydia-cove;
                name = "CaskaydiaCove Nerd Font";
            };
            sansSerif = {
                package = pkgs.nerd-fonts.caskaydia-cove;
                name = "CaskaydiaCove Nerd Font";
            };
            monospace = {
                package = pkgs.nerd-fonts.jetbrains-mono;
                name = "JetBrains Mono Nerd Font";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
            sizes = {
                applications = 10;
                terminal = 11;
                desktop = 10;
                popups = 10;
            };
        };
    };

    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [
                "kitty.desktop"
            ];
        };
    };

    programs = {
        zsh.enable = true;
        starship.enable = true;
        ns-usbloader.enable = true;
        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };
        nix-ld.enable = true; # Run Homebrew/external binaries
        appimage = {
            enable = true;
            binfmt = true;
        };
    };


    environment.systemPackages = with pkgs; [
        # Essentials
        gcc
        unzip
        curl
        tree
        linuxKernel.packages.linux_6_18.cpupower
        pciutils
        xdg-user-dirs
        neovim

        # CLI Tools
        bluetui
        btop
        fastfetch
        yazi

        # file browser
        nautilus

        # Terminals
        ghostty
        kitty
    ];

    users.users.majunior = {
        isNormalUser = true;
        description = "Marco Aurélio S.S.Jr.";
        extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
        shell = pkgs.zsh;
        packages = with pkgs; [ ]; # NOTE: let's use home-manager for this part
    };


    # Nix Settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";
}

