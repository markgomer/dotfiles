{ inputs, ... }:
{
    flake.nixosModules.majuniorHome = { pkgs-unstable, ... }: {
        imports = [
            inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
            extraSpecialArgs = {
                inherit pkgs-unstable;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.majunior = { pkgs, pkgs-unstable, ... }: {
                imports = [
                    ../_features/zsh.nix
                    ../_features/link-dotfiles.nix
                ];

                home = {
                    username = "majunior";
                    homeDirectory = "/home/majunior";
                    packages = [
                        pkgs-unstable.asdf-vm
                        pkgs.git
                        pkgs.pokemon-colorscripts
                        pkgs.tealdeer
                        pkgs.tmux
                        pkgs.eza
                        pkgs.zoxide

                        pkgs.distrobox
                        pkgs.podman-compose

                        # lazyvim pack
                        pkgs.clang-tools # neovim LSP
                        pkgs.fd
                        pkgs.lazygit
                        pkgs.ripgrep
                        pkgs.tree-sitter
                        pkgs.nixd
                        pkgs.nixfmt
                        pkgs.statix

                        pkgs-unstable.zed-editor

                        pkgs.lutris

                        pkgs.nwg-look
                    ];

                    sessionVariables = {
                        EDITOR = "nvim";
                        TERM = "foot";
                        # gnome extensions gtk access
                        GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";

                        # (hack to optimize noctalia-shell)
                        TZ = "America/Sao_Paulo";
                    };

                    stateVersion = "26.05";
                };

                programs.home-manager.enable = true;
            };
        };
    };
}
