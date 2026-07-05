#!/bin/sh
# Reset the current session to exactly three windows: run, edit, terminal.
# The window that was active when this ran is renamed to run and moved first.

# Rename the currently active window to run, remembering its id so a
# pre-existing window also named run can't be confused with it.
cur=$(tmux display-message -p '#{window_id}')
cwd=$(tmux display-message -p '#{pane_current_path}')
tmux rename-window run

# Ensure edit and terminal windows exist.
for w in edit terminal; do
	tmux list-windows -F '#W' | grep -qx "$w" || tmux new-window -d -n "$w" -c "$cwd"
done

# Kill everything else, including any stale duplicate named run.
tmux list-windows -F '#{window_id} #W' | while read -r id w; do
	[ "$id" = "$cur" ] && continue
	case "$w" in
		edit | terminal) ;;
		*) tmux kill-window -t "$id" ;;
	esac
done

# Move run (still the current window) to the first position.
tmux swap-window -t "$(tmux list-windows -F '#{window_index}' | head -n1)"
