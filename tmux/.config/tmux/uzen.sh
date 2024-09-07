#!/bin/sh
# Undo zen
tmux set-option -g pane-active-border-style fg=red
tmux set-option -g pane-border-style fg=default
tmux set -g pane-border-lines double
