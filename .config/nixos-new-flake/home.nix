{ config, pkgs, ... }:
let
  ConfigDir = "/home/majunior/.config/nixos-new-flake";
in
{
    # Home Manager needs a bit of information about you and the paths it should manage
    home.username = "majunior";
    home.homeDirectory = "/home/majunior";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your environment
    home.packages = [
        # pkgs.hello
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0"; # gnome extensions gtk access
    };

    # home.sessionPath = [
    #   "$HOME/.local/bin"
    # ];

    programs = {
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
                # theme = "robbyrussell"; # or any other theme you like
            };
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
    };

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;
}
