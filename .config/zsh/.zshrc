export PATH=$HOME/.local/scripts:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh
ZSH_THEME="agnosterzak"

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux
plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v

# Configure the prompt with embedded Solarized color codes
PROMPT='%F{32}%n%f%F{166}@%f%F{64}%m:%F{166}%~%f%F{15}$%f '
RPROMPT='%F{15}(%F{166}%D{%H:%M}%F{15})%f'

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias sv='$HOME/dotfiles/.local/scripts/powersave.sh'
alias eq='$HOME/dotfiles/.local/scripts/equilibrado.sh'
alias pw='$HOME/dotfiles/.local/scripts/performance.sh'
alias edf='nvim $HOME/dotfiles/'
alias watch='watch -n 1 grep "MHz" /proc/cpuinfo'


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
