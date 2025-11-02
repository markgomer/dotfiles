alias lzg='lazygit'

alias edf='nvim ~/dotfiles/README.md' # Edit dotfiles
alias ijust='just -g'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Cleanup orphaned packages
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"

alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Tmux hotkeys
bindkey -s ^n "pokemux\n"
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\ej' "tmux-sessionizer -s 1\n"
bindkey -s '\ek' "tmux-sessionizer -s 2\n"
bindkey -s '\el' "tmux-sessionizer -s 3\n"
