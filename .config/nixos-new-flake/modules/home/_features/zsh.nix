{ config, ... }:
let
    dotPath = "/home/majunior/dotfiles/.config";
in
{
    programs = {
        zsh = {
            enable = true;
            dotDir = "${config.home.homeDirectory}/.config/zsh";
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
            };
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
    };

    home.file = {
        ".config/zsh/aliases.sh".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/zsh/aliases.sh";

        ".config/zsh/functions.sh".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/zsh/functions.sh";

        ".config/zsh/init.sh".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/zsh/init.sh";
    };
}
