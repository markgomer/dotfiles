#!/bin/bash

set -e

# Configuration
REPO_URL="https://github.com/markgomer/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
ZSH_CONFIG_DIR="$HOME/.config/zsh"

# Clone or update the dotfiles repository
clone_dotfiles() {
    echo "→ Checking dotfiles repository..."

    if [ -d "$DOTFILES_DIR" ]; then
        echo "  ✓ Dotfiles directory already exists at $DOTFILES_DIR"
        read -p "  Do you want to pull latest changes? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cd "$DOTFILES_DIR"
            git pull
            echo "  ✓ Updated dotfiles"
        fi
        return 0
    fi

    echo "  → Cloning dotfiles repository..."
    if ! git clone "$REPO_URL" "$DOTFILES_DIR"; then
        echo "  ✗ Failed to clone dotfiles repository"
        return 1
    fi
    echo "  ✓ Repository cloned successfully"
    return 0
}

# Link zsh config from dotfiles
link_zsh_config() {
    local source_dir="$DOTFILES_DIR/.config/zsh"

    echo "→ Linking zsh config..."

    if [ ! -d "$source_dir" ]; then
        echo "  ✗ zsh config not found in dotfiles at $source_dir"
        return 1
    fi

    mkdir -p "$HOME/.config"

    if [ -e "$ZSH_CONFIG_DIR" ] && [ ! -L "$ZSH_CONFIG_DIR" ]; then
        echo "  ⚠ Backing up existing zsh config to ${ZSH_CONFIG_DIR}.bak"
        mv "$ZSH_CONFIG_DIR" "${ZSH_CONFIG_DIR}.bak"
    elif [ -L "$ZSH_CONFIG_DIR" ]; then
        echo "  ✓ zsh config already linked"
        return 0
    fi

    ln -sf "$source_dir" "$ZSH_CONFIG_DIR"
    echo "  ✓ Linked zsh config from dotfiles"
    return 0
}


# Install zsh using the appropriate package manager
install_zsh() {
    echo "→ Checking for zsh..."

    if command -v zsh &> /dev/null; then
        echo "  ✓ zsh already installed"
        return 0
    fi

    echo "  ⚠ zsh not found. Installing..."

    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y zsh
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y zsh
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm zsh
    elif command -v brew &> /dev/null; then
        brew install zsh
    else
        echo "  ✗ Could not detect package manager. Please install zsh manually."
        return 1
    fi

    echo "  ✓ zsh installed"
    return 0
}

# Install oh-my-zsh
install_oh_my_zsh() {
    echo "→ Installing oh-my-zsh..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "  ✓ oh-my-zsh already installed"
        return 0
    fi

    # Set ZSH to install in home directory
    export ZSH="$HOME/.oh-my-zsh"

    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        echo "  ✗ Failed to install oh-my-zsh"
        echo "  → You can install it manually later with:"
        echo "     sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
        return 1
    fi

    echo "  ✓ oh-my-zsh installed"
    return 0
}

# Install starship prompt
install_starship() {
    echo "→ Installing starship..."

    if command -v starship &> /dev/null; then
        echo "  ✓ starship already installed"
        return 0
    fi

    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo "  ✓ starship installed"
    return 0
}

# Configure ZDOTDIR system-wide
configure_zdotdir() {
    local zshenv_file="/etc/zsh/zshenv"

    echo "→ Configuring ZDOTDIR..."

    if [ ! -d "/etc/zsh" ]; then
        sudo mkdir -p /etc/zsh
    fi

    if [ -f "$zshenv_file" ] && grep -q "ZDOTDIR" "$zshenv_file"; then
        echo "  ✓ ZDOTDIR already configured"
        return 0
    fi

    if [ -f "$zshenv_file" ]; then
        echo "  ⚠ Backing up existing $zshenv_file to ${zshenv_file}.bak"
        sudo cp "$zshenv_file" "${zshenv_file}.bak"
    fi

    echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a "$zshenv_file" > /dev/null
    echo "  ✓ ZDOTDIR set to ~/.config/zsh in $zshenv_file"
    return 0
}

# Set zsh as the default shell
set_default_shell() {
    echo "→ Setting zsh as default shell..."

    local zsh_path=$(which zsh)

    # Check if current shell is already any zsh (handles different paths)
    if [[ "$SHELL" == *"zsh"* ]] && [ "$SHELL" = "$zsh_path" ]; then
        echo "  ✓ zsh already default shell"
        return 0
    fi

    # Check if zsh is in /etc/shells
    if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
        echo "  ⚠ zsh not found in /etc/shells, adding it..."
        if ! echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null; then
            echo "  ✗ Failed to add zsh to /etc/shells"
            return 1
        fi
        echo "  ✓ Added $zsh_path to /etc/shells"
    fi

    if ! chsh -s "$zsh_path" 2>&1 | grep -v "Shell not changed"; then
        echo "  ✗ Failed to change default shell"
        echo "  → You can change it manually later with:"
        echo "     chsh -s $zsh_path"
        return 1
    fi

    echo "  ✓ Default shell changed to zsh"
    return 0
}

# Display usage information
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Install and configure zsh with oh-my-zsh and starship.

OPTIONS:
    --zsh-only          Install only zsh
    --oh-my-zsh-only    Install only oh-my-zsh
    --starship-only     Install only starship
    --configure-only    Only configure ZDOTDIR
    --set-shell-only    Only set zsh as default shell
    --skip-dotfiles     Skip cloning and linking dotfiles
    -h, --help          Show this help message

If no options are provided, all components will be installed.

EOF
}

# Main installation flow
main() {
    local install_all=true
    local skip_dotfiles=false
    local components=()

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --zsh-only)
                install_all=false
                components+=("zsh")
                shift
                ;;
            --oh-my-zsh-only)
                install_all=false
                components+=("oh-my-zsh")
                shift
                ;;
            --starship-only)
                install_all=false
                components+=("starship")
                shift
                ;;
            --configure-only)
                install_all=false
                components+=("configure")
                shift
                ;;
            --set-shell-only)
                install_all=false
                components+=("set-shell")
                shift
                ;;
            --skip-dotfiles)
                skip_dotfiles=true
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done

    echo "=== Zsh Installation Script ==="
    echo

    # Clone dotfiles first if not skipped
    if [ "$skip_dotfiles" = false ]; then
        clone_dotfiles
        echo
    fi

    # Install all or specific components
    if [ "$install_all" = true ]; then
        install_zsh
        echo
        install_oh_my_zsh
        echo
        install_starship
        echo
        configure_zdotdir
        echo
        set_default_shell
        echo
        if [ "$skip_dotfiles" = false ]; then
            link_zsh_config
            echo
        fi
    else
        for component in "${components[@]}"; do
            case $component in
                zsh)
                    install_zsh
                    echo
                    ;;
                oh-my-zsh)
                    install_oh_my_zsh
                    echo
                    ;;
                starship)
                    install_starship
                    echo
                    ;;
                configure)
                    configure_zdotdir
                    echo
                    ;;
                set-shell)
                    set_default_shell
                    echo
                    ;;
            esac
        done
    fi

    echo "=== Installation Complete! ==="
    echo
    echo "Please log out and log back in (or restart) for changes to take effect."
    if [ "$skip_dotfiles" = false ]; then
        echo "Your zsh config has been linked from: $DOTFILES_DIR/.config/zsh"
    fi
}

# Run main function with all arguments
main "$@"
