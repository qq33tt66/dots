#!/usr/bin/env bash

TODO_FILE="$HOME/.local/share/todos.txt"

mkdir -p "$(dirname "$TODO_FILE")"
touch "$TODO_FILE"

todos="$(nl -s '. ' -w 1 "$TODO_FILE")"
selection="$(echo "$todos" | rofi -dmenu -p "Todo" -i)"

if [[ -z "$selection" ]]; then
    exit 0
fi

if [[ "$selection" =~ ^[0-9]+\. ]]; then
    line_num="$(echo "$selection" | cut -d'.' -f1)"
    sed -i "${line_num}d" "$TODO_FILE"
else
    echo "$selection" >> "$TODO_FILE"
fi
