alias lzg='lazygit'

alias edf='nvim ~/dotfiles/README.md' # Edit dotfiles
alias ijust='just -g'
alias box='distrobox enter archbox'

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
