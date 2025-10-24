#!/bin/bash

set -e

# Configuration
REPO_URL="https://github.com/markgomer/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
ZSH_CONFIG_DIR="$HOME/.config/zsh"
OH_MY_ZSH_DIR="$HOME/.local/share/ohmyzsh"
ZSH_PLUGINS_DIR="/usr/share/zsh/packages"

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


# Install oh-my-zsh to custom location
install_oh_my_zsh() {
    echo "→ Installing oh-my-zsh..."

    if [ -d "$OH_MY_ZSH_DIR" ]; then
        echo "  ✓ oh-my-zsh already installed at $OH_MY_ZSH_DIR"
        return 0
    fi

    # Set custom ZSH location
    export ZSH="$OH_MY_ZSH_DIR"

    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        echo "  ✗ Failed to install oh-my-zsh"
        echo "  → You can install it manually later with:"
        echo "     ZSH=\"$OH_MY_ZSH_DIR\" sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
        return 1
    fi

    echo "  ✓ oh-my-zsh installed to $OH_MY_ZSH_DIR"
    return 0
}

# Install zsh packages
install_packages() {
    echo "→ Installing packages..."

    local packages=(
        "zsh"
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
        "zsh-history-substring-search"
        "fzf"
    )

    # check if they are installed in each package manager
    if command -v apt &> /dev/null; then
        for plugin in "${packages[@]}"; do
            if dpkg -l | grep -q "$plugin"; then
                echo "  ✓ $plugin already installed"
            else
                echo "  → Installing $plugin..."
                sudo apt install -y "$plugin"
            fi
        done
    elif command -v dnf &> /dev/null; then
        for plugin in "${packages[@]}"; do
            if rpm -q "$plugin" &> /dev/null; then
                echo "  ✓ $plugin already installed"
            else
                echo "  → Installing $plugin..."
                sudo dnf install -y "$plugin"
            fi
        done
    elif command -v pacman &> /dev/null; then
        for plugin in "${packages[@]}"; do
            if pacman -Q "$plugin" &> /dev/null; then
                echo "  ✓ $plugin already installed"
            else
                echo "  → Installing $plugin..."
                sudo pacman -S --noconfirm "$plugin"
            fi
        done
    elif command -v brew &> /dev/null; then
        for plugin in "${packages[@]}"; do
            if brew list "$plugin" &> /dev/null; then
                echo "  ✓ $plugin already installed"
            else
                echo "  → Installing $plugin..."
                brew install "$plugin"
            fi
        done
    else
        echo "  ⚠ Could not detect package manager"
        echo "  → Please install these packages manually:"
        for plugin in "${packages[@]}"; do
            echo "     - $plugin"
        done
        return 1
    fi

    echo "  ✓ All packages installed"
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

# Main installation flow
main() {
    echo "=== Zsh Installation Script ==="
    echo

    # clone_dotfiles
    # echo

    link_zsh_config
    echo

    configure_zdotdir
    echo

    install_packages
    echo

    install_oh_my_zsh
    echo

    install_starship
    echo

    set_default_shell
    echo

    echo "=== Installation Complete! ==="
    echo
    echo "Oh My Zsh installed at: $OH_MY_ZSH_DIR"
    echo "Zsh config linked from: $DOTFILES_DIR/.config/zsh"
    echo
    echo "Please log out and log back in (or restart) for changes to take effect."
}

# Run main function
main
