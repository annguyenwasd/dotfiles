#!/bin/sh

# Zen mode
  # Split the current pane horizontally, creating a new left pane
  # -h: horizontal split
  # -b: create the new pane in the background
  # -l 25%: the new pane will occupy 25% of the total width
  # -c '#{pane_current_path}': start the new pane in the same directory as the current pane
  # -d '': create the new pane without running any command (leave it empty)
  # Select the middle pane (which will be the second pane created)
  # Split the current middle pane horizontally
  # -h: horizontal split
  # -l 33%: the new pane will occupy 33% of the remaining width (approximately 25% of total width)
  # -c '#{pane_current_path}': start the new pane in the same directory as the current pane
  # -d '': create the new pane without running any command (leave it empty)
tmux splitp -hbl 25% -c '#{pane_current_path}' -d ''
tmux select-pane -t 2
tmux splitp -hl 33% -c '#{pane_current_path}' -d ''

current_tmux_bg=$(rg "^background" ~/.config/alacritty/theme.toml|cut -d '=' -f 2|sed "s/ //g; s/'//g")

tmux set-option -g pane-active-border-style fg="$current_tmux_bg"
tmux set-option -g pane-border-style fg="$current_tmux_bg"
tmux set -g pane-border-lines single
