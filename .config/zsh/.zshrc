source /usr/share/cachyos-zsh-config/cachyos-config.zsh
source ~/.config/zsh/rc.sh

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
