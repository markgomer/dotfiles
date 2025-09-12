#!/usr/bin/env bash

# Theme Manager Script
# Apply a common theme to multiple applications by creating symlinks

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$HOME/dotfiles/themes"
CONFIG_DIR="$HOME/.config"

# Define application configurations as an associative array
# Format: ["config_file"]="target_directory/target_name"
declare -A CONFIGS=(
    ["alacritty.toml"]="alacritty/theme.toml"
    ["backgrounds"]="backgrounds"
    ["btop.theme"]="btop/themes/theme.conf"
    ["chromium.theme"]="chromium/theme.conf"
    ["hyprland.conf"]="hypr/decorations.conf"
    ["hyprlock.conf"]="hypr/hyprlock.conf"
    ["icons.theme"]="icons/theme.conf"
    ["mako.ini"]="mako/config"
    ["neovim.lua"]="nvim/lua/theme.lua"
    ["swayosd.css"]="swayosd/style.css"
    ["rofi.rasi"]="rofi/config.rasi"
    ["waybar.css"]="waybar/style.css"
)

# Function to print colored messages
print_msg() {
    local color=$1
    local msg=$2
    echo -e "${color}${msg}${NC}"
}

# Function to print usage
usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] THEME_NAME

Apply a theme to multiple applications by creating symlinks.

OPTIONS:
    -h, --help      Show this help message
    -l, --list      List available themes
    -s, --status    Show current theme links status
    -r, --remove    Remove all theme symlinks
    -d, --dry-run   Show what would be done without making changes

ARGUMENTS:
    THEME_NAME      Name of the theme to apply (directory name in $DOTFILES_DIR)

EXAMPLES:
    $(basename "$0") dark           # Apply the 'dark' theme
    $(basename "$0") --list         # List all available themes
    $(basename "$0") --status       # Check current symlink status
    $(basename "$0") --remove       # Remove all theme symlinks

EOF
}

# Function to list available themes
list_themes() {
    print_msg "$BLUE" "Available themes in $DOTFILES_DIR:"
    if [[ -d "$DOTFILES_DIR" ]]; then
        for theme in "$DOTFILES_DIR"/*; do
            if [[ -d "$theme" ]]; then
                print_msg "$GREEN" "  • $(basename "$theme")"
            fi
        done
    else
        print_msg "$RED" "Theme directory not found: $DOTFILES_DIR"
        return 1
    fi
}

# Function to check if a theme exists
theme_exists() {
    local theme=$1
    [[ -d "$DOTFILES_DIR/$theme" ]]
}

# Function to create a symlink with backup
create_symlink() {
    local source=$1
    local target=$2
    local dry_run=${3:-false}

    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            print_msg "$YELLOW" "  [DRY RUN] Would create directory: $target_dir"
        else
            mkdir -p "$target_dir"
            print_msg "$GREEN" "  Created directory: $target_dir"
        fi
    fi

    # Check if target exists and is not a symlink
    if [[ -e "$target" && ! -L "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        if [[ "$dry_run" == "true" ]]; then
            print_msg "$YELLOW" "  [DRY RUN] Would backup: $target → $backup"
        else
            mv "$target" "$backup"
            print_msg "$YELLOW" "  Backed up: $target → $backup"
        fi
    fi

    # Remove existing symlink if it exists
    if [[ -L "$target" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            print_msg "$YELLOW" "  [DRY RUN] Would remove existing symlink: $target"
        else
            rm "$target"
        fi
    fi

    # Create new symlink
    if [[ "$dry_run" == "true" ]]; then
        print_msg "$BLUE" "  [DRY RUN] Would link: $source <- $target"
    else
        ln -s "$source" "$target"
        print_msg "$GREEN" "  Linked: $(basename "$source") <- $target"
    fi
}

# Function to apply a theme
apply_theme() {
    local theme=$1
    local dry_run=${2:-false}

    if ! theme_exists "$theme"; then
        print_msg "$RED" "Error: Theme '$theme' not found in $DOTFILES_DIR"
        return 1
    fi

    print_msg "$BLUE" "Applying theme: $theme"
    local theme_dir="$DOTFILES_DIR/$theme"

    # Iterate through all configured applications
    for config_file in "${!CONFIGS[@]}"; do
        local source_file="$theme_dir/$config_file"
        local target_path="$CONFIG_DIR/${CONFIGS[$config_file]}"

        if [[ -e "$source_file" ]]; then
            create_symlink "$source_file" "$target_path" "$dry_run"
        else
            print_msg "$YELLOW" "  Skipping: $config_file (not found in theme)"
        fi
    done

    if [[ "$dry_run" != "true" ]]; then
        print_msg "$GREEN" "\nTheme '$theme' applied successfully!"
        print_msg "$BLUE" "You may need to restart applications for changes to take effect."
    else
        print_msg "$YELLOW" "\n[DRY RUN] No changes were made."
    fi
}

# Function to show status of current symlinks
show_status() {
    print_msg "$BLUE" "Current theme symlink status:\n"

    for config_file in "${!CONFIGS[@]}"; do
        local target_path="$CONFIG_DIR/${CONFIGS[$config_file]}"

        if [[ -L "$target_path" ]]; then
            local link_target=$(readlink "$target_path")
            if [[ "$link_target" == *"$DOTFILES_DIR"* ]]; then
                local theme_name=$(echo "$link_target" | sed "s|.*$DOTFILES_DIR/||" | cut -d'/' -f1)
                print_msg "$GREEN" "  ✓ $config_file → theme: $theme_name"
            else
                print_msg "$YELLOW" "  ⚠ $config_file → external link: $link_target"
            fi
        elif [[ -e "$target_path" ]]; then
            print_msg "$YELLOW" "  ⚠ $config_file → regular file (not a symlink)"
        else
            print_msg "$RED" "  ✗ $config_file → not found"
        fi
    done
}

# Function to remove all theme symlinks
remove_symlinks() {
    local dry_run=${1:-false}

    print_msg "$BLUE" "Removing theme symlinks...\n"

    for config_file in "${!CONFIGS[@]}"; do
        local target_path="$CONFIG_DIR/${CONFIGS[$config_file]}"

        if [[ -L "$target_path" ]]; then
            local link_target=$(readlink "$target_path")
            if [[ "$link_target" == *"$DOTFILES_DIR"* ]]; then
                if [[ "$dry_run" == "true" ]]; then
                    print_msg "$YELLOW" "  [DRY RUN] Would remove: $target_path"
                else
                    rm "$target_path"
                    print_msg "$GREEN" "  Removed: $target_path"
                fi
            else
                print_msg "$YELLOW" "  Skipping non-theme link: $target_path"
            fi
        fi
    done

    if [[ "$dry_run" != "true" ]]; then
        print_msg "$GREEN" "\nTheme symlinks removed."
    else
        print_msg "$YELLOW" "\n[DRY RUN] No changes were made."
    fi
}

# Main function
main() {
    local dry_run=false
    local action=""
    local theme=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -l|--list)
                action="list"
                shift
                ;;
            -s|--status)
                action="status"
                shift
                ;;
            -r|--remove)
                action="remove"
                shift
                ;;
            -d|--dry-run)
                dry_run=true
                shift
                ;;
            -*)
                print_msg "$RED" "Unknown option: $1"
                usage
                exit 1
                ;;
            *)
                theme="$1"
                shift
                ;;
        esac
    done

    # Execute action
    case "$action" in
        list)
            list_themes
            ;;
        status)
            show_status
            ;;
        remove)
            remove_symlinks "$dry_run"
            ;;
        "")
            if [[ -z "$theme" ]]; then
                print_msg "$RED" "Error: No theme name provided"
                usage
                exit 1
            fi
            apply_theme "$theme" "$dry_run"
            ;;
    esac
}

# Run main function
main "$@"
