export XDG_DATA_DIRS="${XDG_DATA_DIRS}:/var/lib/flatpak/exports/share:/home/majunior/.local/share/flatpak/exports/share"
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/scripts:/usr/local/bin:$PATH

source $ZSH/oh-my-zsh.sh
ZSH_THEME="agnosterzak"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

HISTFILE=~/.config/zsh/.histfile
HISTSIZE=5000
SAVEHIST=10000
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


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
