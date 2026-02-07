{ config, pkgs, ... }:

{
    imports = [ /etc/nixos/hardware-configuration.nix ]; # Ensure this exists via nixos-generate-config

    # --- 1. BOOTLOADER & VISUALS (Limine + Plymouth) ---
    boot.loader.limine = {
        enable = true;
        # Customizing Limine: Place a 'background.png' in /boot/ or use 'config' attribute
        # to define colors/fonts. Limine looks for 'limine.conf' which NixOS generates.
    };
    boot.loader.timeout = 1;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.plymouth = {
        enable = true;
        theme = "breeze"; # One of the smoothest for GNOME transitions
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Silent Boot Parameters
    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
    boot.kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "vt.global_cursor_default=0"
    ];

    # --- 2. HARDWARE & PERFORMANCE (NVIDIA + BTRFS) ---
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        open = false; # GTX 1050 Ti (Pascal) prefers proprietary over 'open' kernel modules
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
            offload = {
                enable = false;
                enableOffloadCmd = false;
            };
            # Run 'lspci | grep VGA' to confirm these IDs
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };

    services.beesd = {
        filesystems = {
            root = {
                spec = "LABEL=nixos";
                hashTableSizeMB = 1024;
                verbosity = "crit";
                extraOptions = [ "--loadavg-target" "5.0" ];
            };
        };
    };

    # --- 3. DESKTOP & GAMING ---
    # services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;


    # --- 4. NETWORKING & CONTAINERS ---
    networking.hostName = "avell";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
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

    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };

    # Configure console keymap
    console.keyMap = "br-abnt2";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
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

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    services.flatpak.enable = true;

    services.undervolt = {
        enable = true;
        coreOffset = -127;
        gpuOffset = -320;
        analogioOffset = -127;
        uncoreOffset = -127;
    };
    # Thing for NS-USBLoader
    services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
    '';
    services.keyd = {
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
        gcc
        gnumake
        python313
        nodejs_24
        unzip
        linuxKernel.packages.linux_6_18.cpupower

        blueberry
        bluetui
        btop
        fastfetch
        lazygit
        ripgrep
        yazi
        git
        neovim
        tmux
        bat
        eza
        fd
        distrobox
        podman-compose
        mise

        gnome-extension-manager
        gnomeExtensions.pop-shell

        kitty

        lutris
        heroic

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
        ];
    };


    # Nix Settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";
}
