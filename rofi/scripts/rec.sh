#!/bin/bash

PID_FILE="/tmp/wf-recorder.pid"
STATUS_FILE="/tmp/wf-recorder-status"
OUTPUT_DIR="$HOME/Videos/Recordings"
RECORDER_CMD="wf-recorder --audio=alsa_output.pci-0000_03_00.1.hdmi-stereo.monitor -r 120 -c h264_vaapi -d /dev/dri/renderD128 -p qp=18 -f"

mkdir -p "$OUTPUT_DIR"

notify_user() {
  notify-send -t 3000 "WF Recorder" "$1"
}

start_recording() {
  if [ -f "$PID_FILE" ]; then
    RECORDER_PID=$(cat "$PID_FILE")
    if kill -0 "$RECORDER_PID" 2>/dev/null; then
      notify_user "Recording is already active."
      return 1
    else
      rm -f "$PID_FILE" "$STATUS_FILE"
    fi
  fi
  REGION=$(slurp)
  [ -z "$REGION" ] && {
    notify_user "Recording cancelled: No region selected."
    return 1
  }
  FILENAME="$OUTPUT_DIR/$(date +'%Y-%m-%d_%H-%M-%S').mp4"
  notify_user "Starting recording of region: $REGION"
  $RECORDER_CMD "$FILENAME" --geometry="$REGION" >/dev/null 2>&1 &
  echo $! >"$PID_FILE"
  touch "$STATUS_FILE"
  notify_user "Recording started: $FILENAME"
}

start_fullscreen_recording() {
  if [ -f "$PID_FILE" ]; then
    RECORDER_PID=$(cat "$PID_FILE")
    if kill -0 "$RECORDER_PID" 2>/dev/null; then
      notify_user "Recording is already active."
      return 1
    else
      rm -f "$PID_FILE" "$STATUS_FILE"
    fi
  fi
  FILENAME="$OUTPUT_DIR/$(date +'%Y-%m-%d_%H-%M-%S').mp4"
  notify_user "Starting fullscreen recording"
  $RECORDER_CMD "$FILENAME" >/dev/null 2>&1 &
  echo $! >"$PID_FILE"
  touch "$STATUS_FILE"
  notify_user "Recording started: $FILENAME"
}

stop_recording() {
  [ ! -f "$PID_FILE" ] && {
    notify_user "No active recording found."
    return 1
  }
  RECORDER_PID=$(cat "$PID_FILE")
  if ! kill -0 "$RECORDER_PID" 2>/dev/null; then
    rm -f "$PID_FILE" "$STATUS_FILE"
    notify_user "No active recording found."
    return 1
  fi
  kill -SIGINT "$RECORDER_PID" 2>/dev/null
  rm -f "$PID_FILE" "$STATUS_FILE"
  notify_user "Recording stopped and saved to $OUTPUT_DIR"
}

if [ -f "$PID_FILE" ]; then
  RECORDER_PID=$(cat "$PID_FILE")
  if kill -0 "$RECORDER_PID" 2>/dev/null; then
    OPTIONS="Stop"
    PROMPT="[REC] wf-recorder"
  else
    rm -f "$PID_FILE" "$STATUS_FILE"
    OPTIONS="Start Region\nStart Fullscreen"
    PROMPT="wf-recorder"
  fi
else
  OPTIONS="Start Region\nStart Fullscreen"
  PROMPT="wf-recorder"
fi

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "$PROMPT" -i)

case "$CHOICE" in
"Start Region") start_recording ;;
"Start Fullscreen") start_fullscreen_recording ;;
Stop) stop_recording ;;
*) exit 0 ;;
esac
