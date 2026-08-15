#!/bin/bash
set -euo pipefail

SESSION_NAME="$1"
SESSION_DIR="$HOME/workspace/$SESSION_NAME"

retc=0

tmux new-session -d -s $SESSION_NAME -c $SESSION_DIR

tmux send-keys -t $SESSION_NAME:1 'dev' C-m
tmux send-keys -t $SESSION_NAME:1 'nvim' C-m

tmux new-window -t $SESSION_NAME:2 -n 'zsh' -c $SESSION_DIR
tmux send-keys -t $SESSION_NAME:2 'dev' C-m
tmux send-keys -t $SESSION_NAME:2 'clear' C-m

tmux detach 2> /dev/null || retc=$?
tmux attach -t $SESSION_NAME
