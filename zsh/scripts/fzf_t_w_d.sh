#!/usr/bin/env sh

# fzf delete tmux window
fzf_t_w_d() {
  tmux killw -t $(cat /tmp/del_tmux_window|cut -d " " -f 1)
  rm /tmp/del_tmux_window
}

fzf_t_w_d
