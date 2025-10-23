# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

source /home/majunior/.config/zsh/cachyos-config.zsh
source /home/majunior/.config/zsh/shell.sh
source /home/majunior/.config/zsh/aliases.sh
source /home/majunior/.config/zsh/functions.sh
source /home/majunior/.config/zsh/prompt.sh
source /home/majunior/.config/zsh/init.sh

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
