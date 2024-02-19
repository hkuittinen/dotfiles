#!/bin/zsh

tmux new-session -d -s dotfiles -c ~/Projects/dotfiles
tmux new-session -d -s notes -c ~/Notes
tmux new-session -s terminal -c ~

