source $HOME/.config/zsh/shell.zsh
source $HOME/.config/zsh/aliases.sh
source $HOME/.config/zsh/functions.sh
source $HOME/.config/zsh/prompt.sh
source $HOME/.config/zsh/init.sh

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
