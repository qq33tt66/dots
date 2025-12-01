#!/bin/bash
PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
 if ! command -v pass &> /dev/null; then
    rofi -e "Error: pass (password-store) is not installed"
    exit 1
fi
 if [ ! -d "$PASSWORD_STORE_DIR" ]; then
    rofi -e "Error: Password store not found at $PASSWORD_STORE_DIR"
    exit 1
fi
 password_files=$(find "$PASSWORD_STORE_DIR" -type f -name "*.gpg" | \
    sed "s|$PASSWORD_STORE_DIR/||g" | \
    sed 's/\.gpg$//g' | \
    sort)
 if [ -z "$password_files" ]; then
    rofi -e "No passwords found in password store"
    exit 1
fi
 chosen=$(echo "$password_files" | rofi -dmenu -p "pass:" -i)

if [ -z "$chosen" ]; then
    exit 0
fi
 if pass show -c "$chosen" 2>/dev/null; then
    if command -v notify-send &> /dev/null; then
        notify-send "Password Manager" "Password copied to clipboard (will clear in 45s)" -t 3000
    fi
else
    rofi -e "Error: Failed to copy password"
    exit 1
fi
