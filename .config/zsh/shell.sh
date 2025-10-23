# History control
# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth
# Don't add certain commands to the history file.
export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"
HISTFILE=~/.config/zsh/.histfile
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Set complete path
export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/omarchy/bin:$PATH"
set +h
