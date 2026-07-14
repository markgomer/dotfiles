source $HOME/.config/zsh/functions.sh
source $HOME/.config/zsh/aliases.sh

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# at ./functions.sh
setup_path
