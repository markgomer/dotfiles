#!/usr/bin/env bash
LAPTOP=$(hyprctl monitors all | awk '/^Monitor/{name=$2} name~/eDP|LVDS|DSI/ && /^Monitor/{print name; exit}')
EXTERNAL=$(hyprctl monitors all | awk '/^Monitor/{name=$2} name!~/eDP|LVDS|DSI/ && /^Monitor/{print name; exit}')

if [ -z "$EXTERNAL" ]; then
    echo "No external monitor found" >&2
    exit 1
fi

hyprctl keyword monitor "$LAPTOP,preferred,auto,1.2"
hyprctl keyword monitor "$EXTERNAL,preferred,auto@right,1"
