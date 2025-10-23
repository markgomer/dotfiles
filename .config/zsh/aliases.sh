alias lzg='lazygit'
alias lzd='lazydocker'

alias edf='nvim ~/dotfiles' # Edit dotfiles
alias eom='nvim ~/.local/share/omarchy' # Edit Omarchy
alias ujust='just -g'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Cleanup orphaned packages
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"

alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Hotkeys
bindkey -s ^f "zellij-picker $HOME/Projects/ \n"
bindkey -s ^n "pokezellij \n"
