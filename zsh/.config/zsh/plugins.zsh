if [[ -d  "$HOME/.zsh-vi-mode" ]]; then
  source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
else
  echo "Cloning zsh-vi-mode..."
  # git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
  git clone https://github.com/scresante/zsh-vi-mode.git -b fixpacman $HOME/.zsh-vi-mode  # fix the esc in tmux delete previous line
fi
