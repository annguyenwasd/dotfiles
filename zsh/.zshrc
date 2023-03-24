# {{{ Sources
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/git.zsh
source $HOME/.config/zsh/personal.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# {{{ Settings
# autocompletion
autoload -Uz compinit && compinit
setopt AUTO_CD
setopt NOTIFY

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
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
#}}}

# {{{ Alias
alias c="code"
alias cc="code ."
alias nviu="nvim -u NONE"
alias grep="grep --color"
alias ls="ls --color"

alias ls="ls -G"
alias ll="ls -a"
alias la="ls -la"
alias l="la"

alias ez="nvim ~/.zshrc"
alias ev="nvim ~/.config/nvim/init.lua"

alias sz="source ~/.zshrc && echo \"Sourced.\""

alias w="cd ~/workspace"
alias d="cd ~/Desktop"
alias dot="cd $DOTFILES && if [ -n $TMUX ] ;then dn; fi && nvim"

alias mk="mkdir -vp"
alias cl="clear"
alias x="exit 0"

alias ys="yarn run start"
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

fzf_bare_branches() {
  bare_path=$(git worktree list| grep "(bare)"|cut -d " " -f 1) # only get bare path
# /Users/user-name/workspace/your-bare-path             (bare)
# /Users/user-name/workspace/your-bare-path/branch-name dbae018f [some-branch-name]
#
# git worktree list              -> list worktree
# |sed '/(bare)/ d'              -> remove line with (bare)
# |sort                          -> sort alphabet order
# |xargs -L 1                    -> execute 1 line each (needed for cut command)
# | cut -d " " -f 1,3            -> get frist and third column only (/Users/user-name/workspace/your-bare-path/branch-name [some-branch-name])
# |sed -E "s/^(.*) (.*)/\2 \1/g; -> swap position between branch name and folder ([some-branch-name] /Users/user-name/workspace/your-bare-path/branch-name)
# s/\[//; s/\]//;                -> then remove [] from branch name (some-branch-name /Users/user-name/workspace/your-bare-path/branch-name)
# s#$bare_path##"                -> remove base path (some-branch-name /branch-name)
# | column -t                    -> display as column (because xargs remove the spaces as column)
# |fzf                           -> pipe to fzf
  selectd_line=$(git worktree list|sed '/(bare)/ d'|sort|xargs -L 1 | cut -d " " -f 1,3 |sed -E "s/^(.*) (.*)/\2 \1/g; s/\[//; s/\]//; s#$bare_path##"| column -t|fzf)
  dir=$(echo $selectd_line|xargs -L 1 |cut -d " " -f 2)
  if [ ! -z $dir ]; then
    cd "$bare_path/$dir"
  else
    echo "Aborted"
  fi
}

function fw() {
  loc=${1:-$WORKSPACE_FOLDER}
  dir=$(ls -lA $loc|grep ^d|xargs -L 1|cut -d " " -f 9 | fzf --preview "ls -lA $loc/{}")
  if [ ! -z $dir ]
  then
    cd $loc/$dir
    if $(git config --local --get core.bare) -eq true; then
      fzf_bare_branches
    fi
  else
    echo "No folder selected"
  fi
}

function ff() {
  loc=${1:-$WORKSPACE_FOLDER}
  dir=$(ls -lA $loc|grep ^d|xargs -L 1|cut -d " " -f 9 | fzf --preview "ls -lA $loc/{}")
  if [ ! -z $dir ]
  then
    cd $loc/$dir
    if $(git config --local --get core.bare) -eq true; then
      fzf_bare_branches
    fi
    nvim
  fi
}

function fff() {
  loc=${1:-$WORKSPACE_FOLDER}
  dir=$(ls -lA $loc|grep ^d|xargs -L 1|cut -d " " -f 9 | fzf --preview "ls -lA $loc/{}")
  if [ ! -z $dir ]
  then
    cd $loc/$dir
    dn

    if is_bare_repo; then
      fzf_bare_branches
    fi
      nvim
  fi
}

# set tmux window title as current directoty
function dn() {
  if [ -n $TMUX ]; then
    window_name=$(echo ${PWD##*/})
    if is_bare_repo; then
        bare_path=$(git worktree list| grep "(bare)"|cut -d " " -f 1) # only get bare path
        window_name=${bare_path:t}
    fi
    tmux rename-window $window_name
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

# Fastest way to remove node_modules -> Non-block install new packages
# by `npm install` or `yarn install`
rmm () {
  if [[ "$1" = "-p" ]]; then
    find . -name "${2:=node_modules}" -type d -prune -exec echo '{}' ";"
  else
    # Step 1: move all node_modules folder (recursively) to node_modules_rm
    find . -name "${1:=node_modules}" -type d -prune -exec mv '{}' '{}_rm' ";"
    # Step 2: Remove all node_modules_rm folders
    find . -name "${1:=node_modules}_rm" -type d -prune -exec rm -rf '{}' + &
  fi
}

stow_all() {
  ls -A1 $DOTFILES|sed "/non-stow/ d; /.git/ d; /README/ d" | xargs stow
  if [ $? -eq 0 ]; then
    dd "Stow all folders successfully"
  fi
}
# }}}
