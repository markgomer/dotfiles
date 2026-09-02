NixConfDir=$HOME/dotfiles/nixos

alias lzg='lazygit'
alias ls='eza'
alias cd='z'

alias edf="cd ~/dotfiles && nvim README.md && cd -"
alias ecf="cd $NixConfDir && nvim flake.nix && cd -" # edit config file
alias obs="cd ~/Documents/Obsidian && nvim _\📋\ Life\ Management\ 📋/_\ \✴️\ Life\ Kanban.md && cd -"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# NixOS aliases
alias nrs-avell="sudo nixos-rebuild switch --impure --flake $NixConfDir#avell"
alias nrs-think="sudo nixos-rebuild switch --impure --flake $NixConfDir#thinkpad"
alias update="cd $NixConfDir && nix flake update"
alias ncg="sudo nix-collect-garbage -d && nix-store --optimize"
alias nlg="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"

# Tmux hotkeys
bindkey -s ^n "pokemux\n"
bindkey -s ^p "pokefetch\n"
bindkey -s ^f "tmux-sessionizer\n"

bindkey '^e' autosuggest-accept
