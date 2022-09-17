# {{{ Sources
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/git.zsh
source $HOME/.config/zsh/personal.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# {{{ Settings
# autocompletion
autoload -Uz compinit && compinit

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# Turn off all beeps
unsetopt BEEP
# }}}

# {{{ Exports
export EDITOR=nvim
export REACT_EDITOR=code
export WORKSPACE_FOLDER=~/workspace
export NVIM_HOME=~/.config/nvim/
export TERM=xterm-256color
#}}}

# {{{ Alias
alias c="code"
alias cc="code ."

alias l="la"
alias ll="ls -a"
alias la="ls -la"

alias ez="nvim ~/.zshrc"
alias ev="nvim ~/.config/nvim/init.lua"

alias sz="source ~/.zshrc && echo \"Sourced.\""

alias ..="cd .."
alias w="cd ~/workspace"
alias d="cd ~/Desktop"
alias dot="cd $DOTFILES && dn && nvim"

alias mk="mkdir -vp"
alias cl="clear"
alias x="exit 0"

alias ys="yarn run start"
alias allcowsay="cowsay -l | tr ' ' \\n | tail -n+5 | xargs -n1 -I@ sh -c 'cowsay -f@ @'"
# }}}

# {{{ Functions
# kill process
function kp() {
  kill -9 $(lsof -t -i:$1)
}

function fw() {
  if [ -z $1 ]
  then
    loc=$WORKSPACE_FOLDER
    else
    loc=$1
  fi

  dir=$(ls -1 $loc | fzf)
  if [ -n $dir ]
  then
    cd $loc/$dir
  else
    echo "No folder selected"
  fi
}

function ff() {
  if [ -z $1 ]
  then
    loc=$WORKSPACE_FOLDER
    else
    loc=$1
  fi

  dir=$(ls -1 $loc | fzf)
  if [ -n $dir ]
  then
    cd $loc/$dir
    nvim
  fi
}

function fff() {
  if [ -z $1 ]
  then
    loc=$WORKSPACE_FOLDER
    else
    loc=$1
  fi

  dir=$(ls -1 $loc | fzf)
  if [ -n $dir ]
  then
    cd $loc/$dir
    dn
    nvim
  fi
}

# set tmux window title as current directoty
function dn() {
  tmux rename-window $(echo ${PWD##*/})
}

# tmux layout
function tl() {
  tmux killp -a
  tmux clock-mode
  tmux splitw
  tmux selectl main-vertical
}

function dd() {
  # osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text" sound name "Submarine"'
    osascript -e "display notification \"${1:=Done!}\" with title \"${2:=${PWD/~\//}}\" sound name \"Submarine\""
}

# }}}
