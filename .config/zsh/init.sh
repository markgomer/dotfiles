if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v fzf &>/dev/null; then
    if [[ -f /usr/share/bash-completion/completions/fzf ]]; then
        source /usr/share/bash-completion/completions/fzf
    fi
    if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
        source /usr/share/doc/fzf/examples/key-bindings.bash
    fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

pokefetch
