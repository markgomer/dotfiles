{ config, pkgs, lib, ... }:
{
    home = {
        username = "majunior";
        homeDirectory = "/home/majunior";
        packages = with pkgs; [
            clang-tools
            asdf-vm
            git
            pokemon-colorscripts
            tealdeer
            tmux
            eza
            zoxide

            distrobox
            podman-compose

            # lazyvim pack
            fd
            lazygit
            ripgrep
            tree-sitter
            nixd

            # Games
            lutris
        ];

        sessionVariables = {
            EDITOR = "nvim";
            TERM = "kitty";
            # gnome extensions gtk access
            GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0"; 
        };

        # currently managing it through ZSH
        # sessionPath = [
        #   "$HOME/.local/bin"
        # ];

        # WARN: This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage when a new
        # Home Manager release introduces backwards incompatible changes.
        stateVersion = "25.11"; # Please read the comment before changing.
    };

    programs = {
        # Let Home Manager install and manage itself
        home-manager.enable = true;

        zsh = {
            enable = true;
            dotDir = "/home/majunior/.config/zsh";
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            enableCompletion = true;
            initContent = ''
                source $HOME/.config/zsh/aliases.sh
                source $HOME/.config/zsh/functions.sh
                source $HOME/.config/zsh/init.sh
                '';
            oh-my-zsh = {
                enable = true;
                plugins = [
                    "history-substring-search"
                ];
                # theme = "robbyrussell";
            };
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
    };

    # NOTE: Workaround for theming KDE applications with stylix
    # xdg.configFile.kdeglobals.source =
    # let
    #     themePackage = builtins.head (
    #         builtins.filter (
    #         p: builtins.match ".*stylix-kde-theme.*" (builtins.baseNameOf p) != null
    #         ) config.home.packages
    #     );
    #     colorSchemeSlug = lib.concatStrings (
    #         lib.filter lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
    #     );
    # in
    #     "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";
}
