{ config, pkgs, ... }:

{
    imports = [ /etc/nixos/hardware-configuration.nix ]; # Ensure this exists via nixos-generate-config

    # --- 1. BOOTLOADER & VISUALS (Limine + Plymouth) ---
    boot.loader.limine = {
        enable = true;
        # Customizing Limine: Place a 'background.png' in /boot/ or use 'config' attribute
        # to define colors/fonts. Limine looks for 'limine.conf' which NixOS generates.
    };

    boot.plymouth = {
        enable = true;
        theme = "breeze"; # One of the smoothest for GNOME transitions
    };

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

    # services.beesd.instances.root = {
    #     spec = "/"; # Deduplicate the root partition
    # };

    # --- 3. DESKTOP & GAMING ---
    # services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Gaming & Binaries
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
    
    programs.nix-ld.enable = true; # Run Homebrew/external binaries seamlessly

    environment.systemPackages = with pkgs; [
        blueberry
        gnome-extension-manager
        lutris
        heroic
        distrobox
        podman-compose
        input-remapper
        git
        kitty
        neovim
        tmux
        bat
        eza
        fd
        lazygit
        ripgrep

        # for 25.05 onwards
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.caskaydia-mono
    ];

    # --- 4. NETWORKING & CONTAINERS ---
    networking.hostName = "avell";
    networking.firewalld.enable = true;

    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
    };

    # --- 5. USER & SHELL ---
    users.users.majunior = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
        shell = pkgs.zsh;
        packages = with pkgs; [
        ];
    };

    programs = {
        zsh = {
            enable = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            enableCompletion = true;
            shellAliases = {
                nix-switch = "sudo nixos-rebuild switch --impure --flake .";
                update = "cd ~/.config/nixos-new-flake && nix flake update && sudo nixos-rebuild switch --impure --flake .";
                nix-gc = "sudo nix-collect-garbage -d && nix-store --optimize";
                bees-status = "sudo journalctl -u beesd@root.service -f";
                ecf = "nvim ~/.config/nixos-new-flake/flake.nix";
            };
            ohMyZsh = {
                enable = false;
                plugins = ["git"];
                theme = "agnoster"; 
            };
        }
    };

    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
        path = [ pkgs.flatpak ];
        script = ''
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
    };
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

    # Nix Settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
}
