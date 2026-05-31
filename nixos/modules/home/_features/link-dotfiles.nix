{ config, ... } :
let
    dotPath = "/home/majunior/dotfiles/.config";
in
{
    # NOTE: don't link the entire zsh folder, it will conflict with the
    # home manager managed files. Done in zsh.nix.
    home.file = {
        ".config/nvim".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/nvim";

        ".config/alacritty".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/alacritty";

        ".config/btop".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/btop";

        ".config/fastfetch".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/fastfetch";

        ".config/foot".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/foot";

        ".config/input-remapper-2".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/input-remapper-2";

        ".config/io.github.zefr0x.ianny".source =
            config.lib.file.mkOutOfStoreSymlink
                "${dotPath}/io.github.zefr0x.ianny";

        ".config/niri".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/niri";

        ".config/tmux".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/tmux";

        ".config/yazi".source =
            config.lib.file.mkOutOfStoreSymlink "${dotPath}/yazi";
    };
}
