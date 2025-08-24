if command -v mise &> /dev/null; then
  eval "$(mise activate bash)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

if command -v fzf &> /dev/null; then
  if [[ -f /usr/share/bash-completion/completions/fzf ]]; then
    source /usr/share/bash-completion/completions/fzf
  fi
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
  fi
fi

# get the zellij session name
export ZELLIJ_POKEMON_NAME=$(zellij list-sessions | \grep '(current)' | sed -r "s/\x1b\[[0-9;]*m//g" | awk '{print $1}')

if command -v fastfetch &> /dev/null; then
  if [ -n "$ZELLIJ_POKEMON_NAME" ]; then
    pokemon-colorscripts --no-title -n "$ZELLIJ_POKEMON_NAME" | fastfetch --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
  else
    # show a random pokemon instead
    pokemon-colorscripts --no-title -r | fastfetch --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
  fi
fi
