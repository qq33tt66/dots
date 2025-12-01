#!/bin/bash
# ~/.config/waybar/scripts/spotify_status.sh

player=$(playerctl -l | grep -E 'spotify|spotify_flatpak|cmus' | head -n1)
[ -z "$player" ] && echo '{}' && exit

status=$(playerctl -p "$player" status 2>/dev/null)
[ -z "$status" ] && echo '{}' && exit

artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
title=$(playerctl -p "$player" metadata title 2>/dev/null)

[ -z "$title" ] && echo '{}' && exit

[ "$status" = "Paused" ] && icon="Paused"
[ "$status" = "Playing" ] && icon="Playing"

# Output compact JSON for Waybar
printf '{"text":"%s  %s - %s","alt":"%s","class":"%s"}\n' \
  "$icon" "$title" "$artist" "$status" "$status"
