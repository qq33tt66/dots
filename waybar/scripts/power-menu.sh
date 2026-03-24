#!/bin/bash

options="Poweroff\nReboot\nSuspend"

chosen=$(echo -e "$options" | rofi -dmenu)

case "$chosen" in
"Poweroff") systemctl poweroff ;;
"Reboot") systemctl reboot ;;
"Suspend") systemctl suspend && swaylock --image ~/Pictures/wallpapers/blur.png ;;
esac
