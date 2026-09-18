#!/usr/bin/env bash
card=alsa_card.pci-0000_00_1f.3
active=$(pactl list cards | awk -v c="$card" '$0 ~ "Name: "c {f=1} f && /Active Profile:/ {print $3; exit}')

if [[ "$active" == *hdmi* ]]; then
  pactl set-card-profile "$card" output:analog-stereo+input:analog-stereo
else
  pactl set-card-profile "$card" output:hdmi-stereo+input:analog-stereo
fi
