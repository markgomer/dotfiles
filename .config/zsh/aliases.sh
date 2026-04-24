ConfigDir=$HOME/dotfiles/.config/nixos-new-flake

alias lzg='lazygit'
alias ls='eza'
alias cd='z'

alias edf='nvim ~/dotfiles/README.md' # Edit dotfiles
alias ijust='just -g'
alias box='distrobox enter archbox'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# NixOS aliases
alias nrs-avell="sudo nixos-rebuild switch --impure --flake $ConfigDir#avell"
alias nrs-think="sudo nixos-rebuild switch --impure --flake $ConfigDir#thinkpad"
alias update="cd $ConfigDir && nix flake update"
alias ncg="sudo nix-collect-garbage -d && nix-store --optimize"
alias ecf="nvim $ConfigDir/flake.nix"; # edit config file
alias nlg="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"

# Cleanup orphaned packages
# alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
#
# alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# Recent installed packages
# alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Tmux hotkeys
bindkey -s ^n "pokemux\n"
bindkey -s ^f "tmux-sessionizer\n"



