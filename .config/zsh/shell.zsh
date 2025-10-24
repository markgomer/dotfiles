# -------------------------------------------------------------

# History control

# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth

# Don't add certain commands to the history file.
export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

HISTFILE=~/.config/zsh/.histfile
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# -------------------------------------------------------------

export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/omarchy/bin:$PATH"
set +h

# -------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/share/ohmyzsh"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
[[ -z "${plugins[*]}" ]] && plugins=(fzf)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

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
