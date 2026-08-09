#!/usr/bin/env bash
# usage: bind this script to a single key
# first press: select region and start recording
# second press: stop + convert to gif

PIDFILE="/tmp/gsr-region.pid"
OUT="$HOME/Videos/gsr-$(date +%Y%m%d-%H%M%S)"

if [ -f "$PIDFILE" ]; then
    # Stop recording
    kill -SIGINT "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    notify-send "gpu-screen-recorder" "Stopped. Converting to gif..."

    LATEST=$(ls -t "$HOME"/Videos/gsr-*.mp4 | head -n1)
    GIFOUT="${LATEST%.mp4}.gif"

    ffmpeg -y -i "$LATEST" -vf "fps=15,scale=960:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" "$GIFOUT"
    notify-send "gpu-screen-recorder" "GIF ready: $GIFOUT"
else
    # Select region with slurp: outputs "X,Y WxH"
    REGION=$(slurp -f "%x,%y %wx%h")
    [ -z "$REGION" ] && exit 1

    POS=$(echo "$REGION" | cut -d' ' -f1)
    SIZE=$(echo "$REGION" | cut -d' ' -f2)
    X=$(echo "$POS" | cut -d',' -f1)
    Y=$(echo "$POS" | cut -d',' -f2)
    W=$(echo "$SIZE" | cut -d'x' -f1)
    H=$(echo "$SIZE" | cut -d'x' -f2)

    gpu-screen-recorder -w "${W}x${H}+$X+$Y" -f 60 -a default_output -o "$OUT.mp4" &
    echo $! > "$PIDFILE"
    notify-send "gpu-screen-recorder" "Recording region..."
fi
