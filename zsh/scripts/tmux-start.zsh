#!/bin/zsh
if [[ -v TMUX ]]; then
    echo "You are already attached to a tmux session."
    exit 0
fi

if tmux has-session; then
    echo "tmux server is already running."
    exit 0
fi

tmux new-session -d -s dotfiles -c ~/Projects/dotfiles
tmux new-session -d -s notes -c ~/Notes
tmux new-session -d -s terminal -c ~

if [[ $# -gt 0 ]]; then
    local project_name=$1
    local project_path=~/Projects/$project_name

    if [[ ! -d $project_path ]]; then
        echo "Project '$project_path' does not exist. What to do?"
        echo "[A]ttach"
        echo "[k]ill"
        local response
        read "response?Selection: "
        case $response in
            ""|A|a) tmux attach ;;
            k) tmux kill-server ;;
            *) echo "Unknown response. Killing..." tmux-kill-server ;;
        esac
        exit 0
    fi

    tmux new-session -d -s $project_name -c $project_path
    tmux rename-window -t $project_name run
    tmux new-window -t "$project_name:2" -c $project_path -n edit
    tmux new-window -t "$project_name:3" -c $project_path -n terminal
fi

tmux attach