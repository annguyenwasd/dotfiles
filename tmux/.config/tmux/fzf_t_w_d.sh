#!/usr/bin/env sh

# Function: fzf_t_w_d
#
# Description:
#   Deletes a tmux window based on the window number stored in a temporary file.
#   This function reads the window number from `/tmp/del_tmux_window`, kills
#   the specified tmux window, and then removes the temporary file.
#
# Usage:
#   fzf_t_w_d
#
# Behavior:
# 1. Reads the window number from `/tmp/del_tmux_window`.
# 2. Uses `tmux killw -t` to kill the tmux window with the specified number.
# 3. Removes the temporary file `/tmp/del_tmux_window` after the window is deleted.
#
# Dependencies:
#   - `tmux`: Required for killing the tmux window.
#   - `cat`: Required for reading the temporary file.
#   - `cut`: Required for extracting the window number from the file.
#   - `rm`: Required for removing the temporary file.
#
# Notes:
#   - Ensure that `/tmp/del_tmux_window` contains the correct window number before
#     running this function. This file should be created and populated by the
#     `fzf_t_w` function.
#   - The function will not prompt for confirmation before deleting the window.
#
# Example:
#   To delete a tmux window, you would typically call this function as part of
#   the `fzf_t_w` workflow, which will populate the temporary file with the
#   window number to be deleted. The `fzf_t_w_d` function will then read this
#   number, kill the window, and clean up the temporary file.
fzf_t_w_d() {
  tmux killw -t $(cat /tmp/del_tmux_window|cut -d " " -f 1)
  rm /tmp/del_tmux_window
}

fzf_t_w_d
