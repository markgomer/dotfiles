#!/bin/sh
# monitor-mode.sh — usage: monitor-mode.sh [0-3]

mode="$1"

get_logical_width() {
    # $1 = output name substring, e.g. eDP-1 or HDMI-A-2
    niri msg outputs | awk -v out="$1" '
        $0 ~ out { f=1 }
        f && /Logical size:/ { print $3; exit }
    ' | cut -dx -f1
}

case "$mode" in
    0)
        # Builtin monitor only
        niri msg output eDP-1 on
        niri msg output HDMI-A-2 off
        ;;
    1)
        # HDMI monitor only
        niri msg output eDP-1 off
        niri msg output HDMI-A-2 on
        ;;
    2)
        # Extend right: laptop at 0, external at laptop's logical width
        niri msg output eDP-1 on
        niri msg output HDMI-A-2 on
        sleep 0.1
        W=$(get_logical_width eDP-1)
        niri msg output eDP-1 position set 0 0
        niri msg output HDMI-A-2 position set "$W" 0
        ;;
    3)
        # Extend left: external at 0, laptop at external's logical width
        niri msg output eDP-1 on
        niri msg output HDMI-A-2 on
        sleep 0.1
        W=$(get_logical_width HDMI-A-2)
        niri msg output HDMI-A-2 position set 0 0
        niri msg output eDP-1 position set "$W" 0
        ;;
    *)
        echo "Usage: $0 [0-3]" >&2
        echo "  0 = builtin only" >&2
        echo "  1 = HDMI only" >&2
        echo "  2 = extend right" >&2
        echo "  3 = extend left" >&2
        exit 1
        ;;
esac
