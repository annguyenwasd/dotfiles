#!/usr/bin/env sh

# Function: fzf_t_w
# Description: Allows you to select and switch to a tmux window using `fzf`.
#
# This function presents an interactive interface for selecting a tmux window
# excluding the currently active one. It also provides an option to delete
# a selected window using `CTRL-D`.
#
# Usage:
#   Simply call the function: fzf_t_w
#
# Behavior:
# 1. Lists all tmux windows except the currently active one.
# 2. Displays the list using `fzf`, allowing interactive selection.
# 3. `CTRL-D` option to delete the selected window.
# 4. Switches to the selected tmux window.
#
# Dependencies:
# - tmux
# - fzf
# - sed
# - cut
# - sh (for executing the deletion script)

fzf_t_w() {
  # Get the selected window using fzf
  selected_window=$(tmux lsw | sed '/active/ d' | cut -d " " -f 1,2 | sed 's/://' | \
    fzf --header="Select Tmux window: CTRL-D to delete window" \
        --bind 'ctrl-d:execute(echo {} > /tmp/del_tmux_window)+execute(sh $HOME/.config/tmux/fzf_t_w_d.sh)+clear-query+reload(tmux lsw|sed "/active/ d"|cut -d " " -f 1,2|sed "s/://")')

  # Extract the window number from the selected window
  window_no=$(echo $selected_window | cut -d " " -f 1)

  # Switch to the selected tmux window
  tmux selectw -t $window_no
}
fzf_t_w() {
  selected_window=$(tmux lsw|sed '/active/ d'|cut -d " " -f 1,2|sed 's/://'|fzf --header="Select Tmux window: CTRL-D to delete window" --bind 'ctrl-d:execute(echo {} > /tmp/del_tmux_window)+execute(sh ~/scripts/fzf_t_w_d.sh)+clear-query+reload(tmux lsw|sed "/active/ d"|cut -d " " -f 1,2|sed "s/://")') # list all tmux window except the active one - because tmux open a new window to select other windows
  window_no=$(echo $selected_window|cut -d " " -f 1)
  tmux selectw -t $window_no
}

fzf_t_w
