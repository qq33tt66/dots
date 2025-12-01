#!/bin/bash

# Single script to change wallpaper using rofi + hyprpaper
# Configuration
WALLPAPER_DIR="$HOME/Pictures/wall/"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Use rofi to select wallpaper - show only filenames for cleaner display
SELECTED_FILE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\n" | sort | rofi -dmenu -i -p "Select Wallpaper" -matching fuzzy)

# Check if a file was selected
if [ -z "$SELECTED_FILE" ]; then
    exit 0
fi

# Get full path
WALLPAPER_PATH="$WALLPAPER_DIR$SELECTED_FILE"

# Verify file exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    notify-send "Error" "Wallpaper file not found" -u critical
    exit 1
fi

# Get all monitors (fallback if jq not available)
if command -v jq &> /dev/null; then
    MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
else
    MONITORS=$(hyprctl monitors | grep -oP '(?<=Monitor ).*(?= \()' | awk '{print $1}')
fi

# If still no monitors, use default
if [ -z "$MONITORS" ]; then
    MONITORS="HDMI-A-1"
fi

# Update hyprpaper.conf
cat > "$HYPRPAPER_CONF" << EOL

preload = $WALLPAPER_PATH
EOL

# Add wallpaper line for each monitor
for MONITOR in $MONITORS; do
    echo "wallpaper = $MONITOR,$WALLPAPER_PATH" >> "$HYPRPAPER_CONF"
done

# Add ipc setting
cat >> "$HYPRPAPER_CONF" << EOL
ipc = true

EOL

# Reload hyprpaper
hyprctl hyprpaper unload all 2>/dev/null
hyprctl hyprpaper preload "$WALLPAPER_PATH"

# Set wallpaper for each monitor
for MONITOR in $MONITORS; do
    hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER_PATH"
done

# Send notification
notify-send "Wallpaper Changed" "$(basename "$WALLPAPER_PATH")" -i "$WALLPAPER_PATH" 2>/dev/null || echo "Wallpaper changed to: $WALLPAPER_PATH"
