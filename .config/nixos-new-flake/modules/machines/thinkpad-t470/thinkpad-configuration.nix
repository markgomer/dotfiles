{ ... }:
{
    flake.nixosModules.ThinkPadConfiguration = { pkgs, config, ... }:
    {
        # import any other modules from here
        imports = [
            /etc/nixos/hardware-configuration.nix
        ];

        boot = {
            kernelPackages = pkgs.linuxPackages_6_18;
            kernelModules = [ ];
            kernelParams = [
                "quiet"
                "splash"
                "boot.shell_on_fail"
                "loglevel=3"
                "rd.systemd.show_status=false"
                "rd.udev.log_level=3"
                "udev.log_priority=3"
                "vt.global_cursor_default=0"
            ];
            loader = {
                limine = {
                    enable = true;
                    # list of absolute path
                    # WARN: image can't be webp!
                    style.wallpapers = [ /home/majunior/Pictures/Wallpapers/crt.png ];

                    # INFO: to randomly rotate through images in a directory

                    # style.wallpapers = map (f: /home/majunior/.cache/noctalia/images/wallpapers/thumbnails + "/${f}")
                    #     (builtins.attrNames (builtins.readDir /home/majunior/.cache/noctalia/images/wallpapers/thumbnails));

                };
                timeout = 1;
                efi.canTouchEfiVariables = true;
            };
            plymouth = {
                enable = true;
                theme = "circuit";
                themePackages = with pkgs; [
                    # By default we would install all themes
                    (adi1090x-plymouth-themes.override {
                        selected_themes = [ "circuit" ];
                    })
                ];
            };
            consoleLogLevel = 0;
            initrd.verbose = false;
        };

        networking = {
            networkmanager.enable = true;
            hostName = "thinkpad";
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
            bluetooth = {
                enable = true;
                powerOnBoot = true;
            };
            graphics = {
                enable = true;
                enable32Bit = true;
            };
        };

        systemd.services.battery-threshold = {
            wantedBy = [ "multi-user.target" ];
            script = ''
                echo 80 > /sys/class/power_supply/BAT1/charge_control_start_threshold
                echo 85 > /sys/class/power_supply/BAT1/charge_control_end_threshold
            '';
            serviceConfig.Type = "oneshot";
        };

        services = {
            xserver.xkb = {
                layout = "br";
                variant = "thinkpad";
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
                openFirewall = true; # open ports for discovery
            };

            pulseaudio.enable = false;
            pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
                wireplumber.enable = true;

                # If you want to use JACK applications, uncomment this
                #jack.enable = true;

                # use the example session manager (no others are packaged yet so this is enabled by default,
                # no need to redefine it in your config for now)
                #media-session.enable = true;
            };

            flatpak.enable = true;

            undervolt = {
                enable = true;
                coreOffset = -95; # 100 fail
                gpuOffset = -90; # 95 fail
                analogioOffset = -85;
                uncoreOffset = -70;
            };

            # for external media
            udisks2.enable = true;
            gvfs.enable = true;

            input-remapper.enable = true;
        };

        security = {
            rtkit.enable = true;
            polkit = {
                enable = true;
                # This lets anyone in the wheel group run the powerscripts without a prompt
                extraConfig = ''
                    polkit.addRule(function(action, subject) {
                        var scripts = [
                            "/home/majunior/dotfiles/.local/bin/powersave.sh",
                            "/home/majunior/dotfiles/.local/bin/balanced.sh",
                            "/home/majunior/dotfiles/.local/bin/performance.sh"
                        ];
                        if (action.id == "org.freedesktop.policykit.exec" &&
                            scripts.indexOf(action.lookup("program")) !== -1 &&
                            subject.isInGroup("wheel")) {
                            return polkit.Result.YES;
                        }
                    });
                '';
            };
        };

        virtualisation.podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };

        stylix = {
            enable = false;
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
            gnome-disks.enable = true;
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
            polkit_gnome
            gnupg
            gnumake

            # CLI Tools
            bluetui
            btop
            fastfetch
            yazi

            # Terminals
            foot

            pcmanfm

            brave
        ];

        users.users.majunior = {
            isNormalUser = true;
            description = "Marco Souza";
            extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
            shell = pkgs.zsh;
            packages = [ ]; # NOTE: let's use home-manager for this part
        };

        # Nix Settings
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "25.11";
    };
}

