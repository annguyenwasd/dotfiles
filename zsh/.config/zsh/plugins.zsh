if [[ ! -d  "$HOME/.zsh-vi-mode" ]]; then
  echo "Cloning zsh-vi-mode..."
  git clone https://github.com/scresante/zsh-vi-mode.git -b fixpacman $HOME/.zsh-vi-mode  # fix the esc in tmux delete previous line
fi

if [[ ! -d  "$HOME/.zsh-command-time" ]]; then
  echo "Cloning .zsh-command-time..."
  git clone https://github.com/popstas/zsh-command-time.git $HOME/.zsh-command-time
fi

source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $HOME/.zsh-command-time/command-time.plugin.zsh

# Message to display (set to "" for disable).
ZSH_COMMAND_TIME_MSG="Took: %s"

# Message color.
ZSH_COMMAND_TIME_COLOR="yellow"

# Exclude some commands
ZSH_COMMAND_TIME_EXCLUDE=(nvim)
