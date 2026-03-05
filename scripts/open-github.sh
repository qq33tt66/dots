#!/usr/bin/env bash
cd "$(tmux display-message -p '#{pane_current_path}')"

url=$(git remote get-url origin 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "Not a git repository"
    exit 1
fi

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://$url"
    fi
    # Strip .git suffix if present
    url="${url%.git}"
    xdg-open "$url"
else
    echo "This repository is not hosted on GitHub"
fi
