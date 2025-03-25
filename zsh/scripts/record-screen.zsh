#!/bin/zsh
if pgrep -x wf-recorder >/dev/null; then
    notify-send "Saving..." -t 3000
    killall -s SIGINT wf-recorder --wait
    notify-send "Screen recorded." -t 3000
else
    area=$(slurp)
    filename="$HOME/videos/screen-recordings/$(date +"%Y-%m-%dT%H:%M:%S").mp4"
    wf-recorder -g "$area" -f "$filename" &
fi

pkill -RTMIN+1 waybar
