# History control
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=32768
SAVEHIST=32768
setopt appendhistory
setopt incappendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups

# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth

# -------------------------------------------------------------

set +h

autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
zstyle ':completion:*' menu select

# -------------------------------------------------------------

# # Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
#
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
[[ -z "${plugins[*]}" ]] && plugins=(fzf)

typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"

[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char

# terminfo keys only work in application mode
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  zle_application_mode_start() { echoti smkx }
  zle_application_mode_stop() { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# -------------------------------------------------------------

# Use custom `less` colors for `man` pages.
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

# -------------------------------------------------------------

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# -------------------------------------------------------------

export FZF_BASE=/usr/share/fzf

# -------------------------------------------------------------
