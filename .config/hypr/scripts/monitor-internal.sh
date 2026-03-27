#!/usr/bin/env bash
LAPTOP=$(hyprctl monitors all | awk '/^Monitor/{name=$2} name~/eDP|LVDS|DSI/ && /^Monitor/{print name; exit}')
EXTERNAL=$(hyprctl monitors all | awk '/^Monitor/{name=$2} name!~/eDP|LVDS|DSI/ && /^Monitor/{print name; exit}')

hyprctl keyword monitor "$LAPTOP,preferred,auto,1"
[ -n "$EXTERNAL" ] && hyprctl keyword monitor "$EXTERNAL,disable"
