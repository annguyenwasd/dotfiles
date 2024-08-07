#
# Start profiling (uncomment when necessary)
#
# See: https://stackoverflow.com/a/4351664/2103996

# Per-command profiling:

# zmodload zsh/datetime
# setopt promptsubst
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2> startlog.$$
# setopt xtrace prompt_subst

# Per-function profiling:

# zmodload zsh/zprof

# {{{ Settings
# autocompletion
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
zmodload -F zsh/stat b:zstat
setopt AUTO_CD
setopt NOTIFY
setopt prompt_subst

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

# {{{ Sources
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/git.zsh
source $HOME/.config/zsh/vcs-info.zsh
source $HOME/.config/zsh/personal.zsh
source $HOME/.config/zsh/yr.zsh
source $HOME/.config/zellij/mappings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -d /usr/share/fzf ] && source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh
# }}}

# {{{ Exports
export EDITOR=nvim
export REACT_EDITOR=code
export WORKSPACE_FOLDER=~/workspace
export NVIM_HOME=~/.config/nvim/
export TERM=xterm-256color
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
#}}}

# {{{ Alias
alias grep="grep --color"
alias ls="ls --color -L"

alias ll="ls -a"
alias la="ls -la --color -L"

alias ez="nvim ~/.zshrc"
alias ev="nvim ~/.config/nvim/init.lua"

alias sz="source ~/.zshrc && echo \"Sourced.\""

alias w="cd $WORKSPACE_FOLDER"
alias d="cd ~/Desktop"
alias dot="cd $DOTFILES && [ ! $TMUX = '' ] && dn; [ ! $ZELLIJ = '' ] && dn; nvim"

alias mk="mkdir -vp"
alias cl="clear"
alias x="exit 0"

alias ys="yarn run start"
alias yd="yarn run dev"
alias yt="yarn test"
alias yb="yarn run build"
alias yl="yarn list"
alias yw="yarn why"
alias allcowsay="cowsay -l | tr ' ' \\n | tail -n+5 | xargs -n1 -I@ sh -c 'cowsay -f@ @'"
# }}}

# {{{ Functions
# kill process
function kp() {
  kill -9 $(lsof -t -i:$1)
}

function fw() {
  loc=${1:=$WORKSPACE_FOLDER}
  is_changed_tmux_window_name=${2:=false}
  is_open_nvim=${3:=false}
  before="$PWD"

  dir=$(ls -d --color=never $loc/*/ | sed 's#/$##' | sed "s#$loc/##" | fzf --ansi --preview "ls -lA $loc/{}")

  if [ ! -z $dir ]; then
    cd $loc"/"$dir

    if [ -n $TMUX ] && $is_changed_tmux_window_name; then
      dn
    fi

    if [ -n $ZELLIJ ] && $is_changed_tmux_window_name; then
      dn
    fi

    if is_bare_repo; then
      gcoo
      if [ $? -eq 1 ]
      then
        cd $before
      fi
    fi

    if $is_open_nvim; then
      nvim
    fi

  else
    echo "No folder selected"
  fi
}

function ff() {
  fw ${1:=$WORKSPACE_FOLDER} false true
}

function fff() {
  fw ${1:=$WORKSPACE_FOLDER} true true
}

# set tmux window title as current directoty
function dn() {
    window_name=$(echo ${PWD##*/})
    if is_bare_repo; then
        bare_path=$(get_bare_path) # only get bare path
        window_name=${bare_path:t}
    fi

  if [ $TMUX ]; then
    tmux rename-window $window_name
  fi
  
  if [ $ZELLIJ ]; then
   zellij action rename-tab $window_name
  fi

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

function install_rmm_dep() {
  if [ $ANNGUYENWASD_PROFILE = "work" ]; then
    nvmm
    if ! type trash > /dev/null; then
      npm i -g trash-cli
    fi

    if ! type empty-trash > /dev/null; then
      npm i -g empty-trash-cli
    fi

  fi
}

# Fastest way to remove node_modules -> Non-block install new packages
# by `npm install` or `yarn install`
function rmm () {
  install_rmm_dep
  if [[ "$1" = "-p" ]]; then
    find . -name "${2:=node_modules}" -type d -prune -exec echo '{}' ";"
  else
    if [ $ANNGUYENWASD_PROFILE = "work" ]; then
      nvmm
      find . -name "${1:=node_modules}" -type d -prune -exec trash '{}' + &
      
      empty-trash 2> /dev/null &
    else
      # Step 1: move all node_modules folder (recursively) to node_modules_rm
      find . -name "${1:=node_modules}" -type d -prune -exec mv '{}' '{}_rm' ";"
      # Step 2: Remove all node_modules_rm folders
      find . -name "${1:=node_modules}_rm" -type d -prune -exec rm -rf '{}' + &
    fi
  fi
}

function stow_all() {
  ls -A1 $DOTFILES|sed "/non-stow/ d; /.git/ d; /README/ d" | xargs stow
  if [ $? -eq 0 ]; then
    dd "Stow all folders successfully"
  fi
}

# }}}

_command_time_preexec() {
  # check excluded
  if [ -n "$ZSH_COMMAND_TIME_EXCLUDE" ]; then
    cmd="$1"
    for exc ($ZSH_COMMAND_TIME_EXCLUDE) do;
      if [ "$(echo $cmd | grep -c "$exc")" -gt 0 ]; then
        # echo "command excluded: $exc"
        return
      fi
    done
  fi

  timer=${timer:-$SECONDS}
  ZSH_COMMAND_TIME_MSG=${ZSH_COMMAND_TIME_MSG-"Time: %s"}
  ZSH_COMMAND_TIME_COLOR=${ZSH_COMMAND_TIME_COLOR-"white"}
  export ZSH_COMMAND_TIME=""
}

_command_time_precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    if [ -n "$TTY" ] && [ $timer_show -ge ${ZSH_COMMAND_TIME_MIN_SECONDS:-3} ]; then
      export ZSH_COMMAND_TIME="$timer_show"
      if [ ! -z ${ZSH_COMMAND_TIME_MSG} ]; then
        zsh_command_time
      fi
    fi
    unset timer
  fi
}

zsh_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    timer_show=$(printf '%dh:%02dm:%02ds\n' $(($ZSH_COMMAND_TIME/3600)) $(($ZSH_COMMAND_TIME%3600/60)) $(($ZSH_COMMAND_TIME%60)))
    print -P "%F{$ZSH_COMMAND_TIME_COLOR}$(printf "${ZSH_COMMAND_TIME_MSG}\n" "$timer_show")%f"
  fi
}

precmd_functions+=(_command_time_precmd)
preexec_functions+=(_command_time_preexec)
#
# End profiling (uncomment when necessary)
#

# Per-command profiling:

# unsetopt xtrace
# exec 2>&3 3>&-

# Per-function profiling:

# zprof
