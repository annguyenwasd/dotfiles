#!/usr/bin/env sh

# fzf tmux window
fzf_t_w() {
  selected_window=$(tmux lsw|sed '/active/ d'|cut -d " " -f 1,2|sed 's/://'|fzf --header="Select Tmux window: CTRL-D to delete window" --bind 'ctrl-d:execute(echo {} > /tmp/del_tmux_window)+execute(sh ~/scripts/fzf_t_w_d.sh)+clear-query+reload(tmux lsw|sed "/active/ d"|cut -d " " -f 1,2|sed "s/://")') # list all tmux window except the active one - because tmux open a new window to select other windows
  window_no=$(echo $selected_window|cut -d " " -f 1)
  tmux selectw -t $window_no
}

fzf_t_w
