#!/bin/bash

# Minimal Rofi power menu
chosen=$(printf "suspend\nreboot\npoweroff" | rofi -dmenu -p "power:")

case "$chosen" in
suspend)
    swaylock -C ~/.config/swaylock/swaylock.conf -f &
    systemctl suspend
    ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
*) exit 0 ;;
esac
