if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v asdf &>/dev/null; then
    export ASDF_DATA_DIR="$HOME/.local/share/asdf-vm"
    export PATH="$HOME/.local/bin:${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# pokefetch
