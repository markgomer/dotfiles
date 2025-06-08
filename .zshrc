# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set directory to store zinit and plugins
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
# if [ ! -d "$ZINIT_HOME" ]; then
#    mkdir -p "$(dirname $ZINIT_HOME)"
#    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# fi

# source "${ZINIT_HOME}/zinit.zsh"
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Zsh plugins
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux

# Ctrl-e to accept autocompletion
bindkey -e
# Ctrl-f to tmux-sessionizer
bindkey -s ^f "tmux-sessionizer\n"

# Load completions
autoload -Uz compinit && compinit
# zinit cdreplay -q

source <(fzf --zsh)

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory

# Style completion
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

EDITOR=lvim

PATH="$PATH":"$HOME/.local/scripts/"
export PATH=~/.local/bin:$PATH
export PATH=/home/majunior/.cargo/bin:$PATH

export PATH="/home/majunior/.asdf/shims:$PATH"

# Aliases
alias ls="exa -la --icons"
alias cat="bat --style=auto"

# Shell integrations
eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh
