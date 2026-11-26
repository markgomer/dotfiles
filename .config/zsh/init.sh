source $HOME/.config/zsh/functions.sh
source $HOME/.config/zsh/aliases.sh

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# at ./functions.sh
setup_path

setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS SHARE_HISTORY

mkdir -p ~/.cache/zsh
autoload -Uz compinit && compinit -d ~/.cache/zsh/.zcompdump
zstyle ':completion:*' menu select
