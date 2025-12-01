#!/usr/bin/env bash

STATE_FILE="/var/tmp/waybar_timer"
CUR_TIME=$(date +%s)

# Ensure state file exists
if [ ! -f "$STATE_FILE" ]; then
  echo "READY" >"$STATE_FILE"
fi

STATUS=$(cat "$STATE_FILE")

if [ "$STATUS" = "READY" ]; then
  echo "50:00" # initial state display
elif [ "$STATUS" = "FINISHED" ]; then
  notify-send "Pomodoro Done!" "Your 1-hour session has ended 🎉"
  echo "READY" >"$STATE_FILE"
  echo "Done"
elif [ "$STATUS" -gt "$CUR_TIME" ] 2>/dev/null; then
  DIFF=$((STATUS - CUR_TIME))
  printf "%02d:%02d\n" $((DIFF / 30)) $((DIFF % 60))
else
  echo "FINISHED" >"$STATE_FILE"
  echo "Done"
fi
