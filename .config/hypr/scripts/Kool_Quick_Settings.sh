#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Rofi menu for KooL Hyprland Quick Settings (SUPER F2)

configs="$HOME/.config/hypr/config"
rofi_theme="$HOME/.config/rofi/config-edit.rasi"
msg=' ⁉️ Choose what to do ⁉️'
iDIR="$HOME/.config/swaync/images"
scriptsDir="$HOME/.config/hypr/scripts"

# Function to display the menu options without numbers
menu() {
  cat <<EOF
Choose Kitty Terminal Theme
Configure Monitors (nwg-displays)
Configure Workspace Rules (nwg-displays)
GTK Settings (nwg-look)
QT Apps Settings (qt6ct)
QT Apps Settings (qt5ct)
Choose Hyprland Animations
Choose Monitor Profiles
Choose Rofi Themes
Search for Keybinds
Toggle Game Mode
Switch Dark-Light Theme
EOF
}

# Main function to handle menu selection
main() {
  choice=$(menu | rofi -i -dmenu -config $rofi_theme -mesg "$msg")

  # Map choices to corresponding files
  case "$choice" in
  "Choose Kitty Terminal Theme") $scriptsDir/Kitty_themes.sh ;;
  "Configure Monitors (nwg-displays)")
    if ! command -v nwg-displays &>/dev/null; then
      notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Install nwg-displays first"
      exit 1
    fi
    nwg-displays
    ;;
  "Configure Workspace Rules (nwg-displays)")
    if ! command -v nwg-displays &>/dev/null; then
      notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Install nwg-displays first"
      exit 1
    fi
    nwg-displays
    ;;
  "GTK Settings (nwg-look)")
    if ! command -v nwg-look &>/dev/null; then
      notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Install nwg-look first"
      exit 1
    fi
    nwg-look
    ;;
  "QT Apps Settings (qt6ct)")
    if ! command -v qt6ct &>/dev/null; then
      notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Install qt6ct first"
      exit 1
    fi
    qt6ct
    ;;
  "QT Apps Settings (qt5ct)")
    if ! command -v qt5ct &>/dev/null; then
      notify-send -i "$iDIR/error.png" "E-R-R-O-R" "Install qt5ct first"
      exit 1
    fi
    qt5ct
    ;;
  "Choose Hyprland Animations") $scriptsDir/Animations.sh ;;
  "Choose Monitor Profiles") $scriptsDir/MonitorProfiles.sh ;;
  "Choose Rofi Themes") $scriptsDir/RofiThemeSelector.sh ;;
  "Search for Keybinds") $scriptsDir/KeyBinds.sh ;;
  "Toggle Game Mode") $scriptsDir/GameMode.sh ;;
  "Switch Dark-Light Theme") $scriptsDir/DarkLight.sh ;;
  *) return ;; # Do nothing for invalid choices
  esac

  # Open the selected file in the terminal with the text editor
  if [ -n "$file" ]; then
    $term -e $edit "$file"
  fi
}

# Check if rofi is already running
if pidof rofi >/dev/null; then
  pkill rofi
fi

main
