#!/bin/bash

set -e

REPO_URL="https://github.com/markgomer/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

# Clone or update the dotfiles repository
clone_dotfiles() {
    if [ -d "$DOTFILES_DIR" ]; then
        echo "✓ Dotfiles directory already exists at $DOTFILES_DIR"
        read -p "Do you want to pull latest changes? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cd "$DOTFILES_DIR"
            git pull
        fi
    else
        echo "→ Cloning dotfiles repository..."
        git clone "$REPO_URL" "$DOTFILES_DIR"
        echo "✓ Repository cloned successfully"
    fi
}

# Link folders from source to target, backing up conflicts
link_config_folders() {
    local source_dir="$DOTFILES_DIR/.config"

    echo "→ Linking config folders..."
    mkdir -p "$CONFIG_DIR"

    if [ ! -d "$source_dir" ]; then
        echo "  ⚠ No .config directory found in dotfiles"
        return
    fi

    for folder in "$source_dir"/*; do
        if [ -d "$folder" ]; then
            local folder_name=$(basename "$folder")
            local target="$CONFIG_DIR/$folder_name"

            if [ -e "$target" ] && [ ! -L "$target" ]; then
                echo "  ⚠ Backing up existing $folder_name to ${folder_name}.bak"
                mv "$target" "${target}.bak"
            elif [ -L "$target" ]; then
                echo "  ✓ $folder_name already linked"
                continue
            fi

            ln -sf "$folder" "$target"
            echo "  ✓ Linked $folder_name"
        fi
    done
}

# Link files from source to target, backing up conflicts
link_bin_files() {
    local source_dir="$DOTFILES_DIR/.local/bin"

    echo "→ Linking bin files..."
    mkdir -p "$BIN_DIR"

    if [ ! -d "$source_dir" ]; then
        echo "  ⚠ No .local/bin directory found in dotfiles"
        return
    fi

    for file in "$source_dir"/*; do
        if [ -f "$file" ]; then
            local file_name=$(basename "$file")
            local target="$BIN_DIR/$file_name"

            if [ -e "$target" ] && [ ! -L "$target" ]; then
                echo "  ⚠ Backing up existing $file_name to ${file_name}.bak"
                mv "$target" "${target}.bak"
            elif [ -L "$target" ]; then
                echo "  ✓ $file_name already linked"
                continue
            fi

            ln -sf "$file" "$target"
            echo "  ✓ Linked $file_name"
        fi
    done
}

# Install zsh using the appropriate package manager
install_zsh() {
    echo "→ Checking for zsh..."

    if command -v zsh &> /dev/null; then
        echo "  ✓ zsh already installed"
        return
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
        exit 1
    fi

    echo "  ✓ zsh installed"
}

# Install oh-my-zsh
install_oh_my_zsh() {
    echo "→ Installing oh-my-zsh..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "  ✓ oh-my-zsh already installed"
        return
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "  ✓ oh-my-zsh installed"
}

# Install starship prompt
install_starship() {
    echo "→ Installing starship..."

    if command -v starship &> /dev/null; then
        echo "  ✓ starship already installed"
        return
    fi

    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo "  ✓ starship installed"
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
        return
    fi

    if [ -f "$zshenv_file" ]; then
        echo "  ⚠ Backing up existing $zshenv_file to ${zshenv_file}.bak"
        sudo cp "$zshenv_file" "${zshenv_file}.bak"
    fi

    echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a "$zshenv_file" > /dev/null
    echo "  ✓ ZDOTDIR set to ~/.config/zsh in $zshenv_file"
}

# Set zsh as the default shell
set_default_shell() {
    echo "→ Setting zsh as default shell..."

    if [ "$SHELL" = "$(which zsh)" ]; then
        echo "  ✓ zsh already default shell"
        return
    fi

    chsh -s "$(which zsh)"
    echo "  ✓ Default shell changed to zsh"
}

# Main installation flow
main() {
    echo "=== Dotfiles Installation Script ==="
    echo

    clone_dotfiles
    echo

    link_config_folders
    echo

    link_bin_files
    echo

    install_zsh
    install_oh_my_zsh

    echo

    install_starship
    echo

    configure_zdotdir
    set_default_shell

    echo "=== Installation Complete! ==="

    echo
    echo "Make sure $BIN_DIR is in your PATH."
    echo "Please log out and log back in (or restart) for zsh to be your default shell."
    echo "Your zsh config should be in ~/.config/zsh/.zshrc"
}

main
