#!/bin/bash

# Monitor power events and switch to laptop screen
hyprctl keyword monitor "eDP-1,preferred,0x0,1"
hyprctl keyword monitor "HDMI-A-1,disable"
sleep 1
loginctl lock-session
