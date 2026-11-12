#!/bin/sh
# monitor-mode.sh — usage: monitor-mode.sh [0-3]

mode="$1"

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-2"

get_logical_width() {
    niri msg outputs | awk -v out="$1" '
        $0 ~ out { f=1 }
        f && /Logical size:/ { print $3; exit }
    ' | cut -dx -f1
}

get_logical_height() {
    niri msg outputs | awk -v out="$1" '
        $0 ~ out { f=1 }
        f && /Logical size:/ { print $3; exit }
    ' | cut -dx -f2
}

case "$mode" in
    0)
        niri msg output "$INTERNAL" on
        niri msg output "$EXTERNAL" off
        ;;
    1)
        niri msg output "$INTERNAL" off
        niri msg output "$EXTERNAL" on
        ;;
    2)
        niri msg output "$INTERNAL" on
        niri msg output "$EXTERNAL" on
        sleep 0.1
        W=$(get_logical_width "$INTERNAL")
        niri msg output "$INTERNAL" position set 0 0
        niri msg output "$EXTERNAL" position set "$W" 0
        ;;
    3)
        niri msg output "$INTERNAL" on
        niri msg output "$EXTERNAL" on
        sleep 0.1
        W=$(get_logical_width "$EXTERNAL")
        niri msg output "$EXTERNAL" position set 0 0
        niri msg output "$INTERNAL" position set "$W" 0
        ;;
    *)
        echo "Usage: $0 [0-3]" >&2
        echo "  0 = builtin only" >&2
        echo "  1 = external only" >&2
        echo "  2 = extend right" >&2
        echo "  3 = extend left" >&2
        exit 1
        ;;
esac
