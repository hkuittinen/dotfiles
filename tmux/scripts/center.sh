#!/bin/sh
# Toggle centering the current pane by padding it with empty panes on both
# sides. Pads are tagged with the pane option @center_pad so they can be
# found again regardless of what else is in the window.
# Width comes from the first argument, then @center_width, then 88.

cur=$(tmux display-message -p '#{pane_id}')
win=$(tmux display-message -p '#{window_id}')

# Off: remove the pads if this window has any.
pads=$(tmux list-panes -t "$win" -F '#{pane_id} #{@center_pad}' | awk '$2 == 1 { print $1 }')
if [ -n "$pads" ]; then
	tmux set-hook -uw -t "$win" after-select-pane
	for p in $pads; do
		tmux kill-pane -t "$p"
	done
	exit
fi

# On: split an empty pad off each side of the current pane.
width=${1:-$(tmux show -gv @center_width 2>/dev/null)}
width=${width:-88}
pane_width=$(tmux display-message -p '#{pane_width}')
# Each pad also costs one column of border.
pad=$(( (pane_width - width) / 2 - 1 ))
if [ "$pad" -lt 10 ]; then
	tmux display-message "center: pane too narrow"
	exit
fi

for side in -b ''; do
	# Pads run a command that never exits. An empty '' pane would close when
	# the creating client exits, and macOS's sleep rejects `infinity`.
	p=$(tmux split-window -hd $side -l "$pad" -t "$cur" -P -F '#{pane_id}' 'exec tail -f /dev/null')
	tmux set -p -t "$p" @center_pad 1
	tmux select-pane -d -t "$p"
done

# Bounce focus back out of a pad (C-h/C-l navigation, mouse clicks).
tmux set-hook -w -t "$win" after-select-pane 'if -F "#{@center_pad}" "select-pane -l"'
