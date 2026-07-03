#!/bin/sh
# Reset the current session to exactly three windows: run, edit, terminal.
for w in run edit terminal; do
	tmux list-windows -F '#W' | grep -qx "$w" || tmux new-window -d -n "$w" -c ~
done
tmux list-windows -F '#{window_id} #W' | while read -r id w; do
	case "$w" in
		run | edit | terminal) ;;
		*) tmux kill-window -t "$id" ;;
	esac
done
