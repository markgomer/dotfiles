#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/niri/config.kdl"

# Check for exact word 'on' inside animations block
if sed -n '/animations {/,/}/p' "$CONFIG_FILE" | grep -q '\bon\b'; then
    sed -i '/animations {/,/}/s/\bon\b/off/' "$CONFIG_FILE"
    echo "Animations OFF"
else
    sed -i '/animations {/,/}/s/\boff\b/on/' "$CONFIG_FILE"
    echo "Animations ON"
fi
