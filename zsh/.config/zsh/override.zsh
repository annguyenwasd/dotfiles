export EDITOR=vim

function select_branch(){
  local branch_name=$(git branch -a | sed '/HEAD/ d'|ipt -a -S 10)

  branch_name=$(echo $branch_name | sed 's/\*//; s/\+//; s/ //; s/"//g' | sed 's#remotes/origin/##' | awk '{ print $1 }')
  echo $branch_name

}

function gcoo {
  local branch_name=$(select_branch)
  if [[ -z $branch_name ]]; then
    echo "No branch selected. Aborting..."
  else
    bare_branch_checkout $branch_name
  fi
}

function set_iterm_tab_title() {
 echo -ne "\e]1;$1\a"
}

function dn() {
  # Extract the base name of the current working directory
  #
  # ${PWD} is a special shell variable that holds the path of the current
  # working directory. For example, if you are in:
  #   /home/user/projects/myapp
  # then ${PWD} contains the string '/home/user/projects/myapp'.
  #
  # The syntax ${PWD##*/} is a parameter expansion technique:
  # - '##' indicates that we want to remove the longest match of the pattern.
  # - '*/' is the pattern which matches any characters followed by a '/'.
  #
  # By using ${PWD##*/}, we are effectively removing everything before
  # and including the last '/' in the path. The result is the base name
  # of the current directory.
  #
  # For example, if ${PWD} is '/home/user/projects/myapp', then:
  #   ${PWD##*/} results in 'myapp', which is the name of the current directory.
  #
  # Assign this base name to the variable 'window_name'.
  local window_name=$(echo ${PWD##*/})
  if is_bare_repo; then
    local bare_path=$(get_bare_path) # only get bare path
    window_name="${bare_path:t}"
  fi

  set_iterm_tab_title "$window_name"
}

function fw() {
  local loc=${1:=$WORKSPACE_FOLDER}
  local is_changed_tmux_window_name=${2:=false}
  local is_open_vim=${3:=false}
  local is_open_vscode=${4:=false}
  local before="$PWD"
  local dir=$(find $WORKSPACE_FOLDER -type d -maxdepth 1|tail -n +2|xargs basename|ipt -a -S 10)

  cd $loc"/"$dir

  if is_bare_repo; then
    clear
    gcoo
    if [ $? -eq 1 ]
    then
      cd $before
    fi
  fi

  dn
  clear

  if $is_open_vscode; then
    code .
    return 0
  fi

  if $is_open_vim; then
    vim .
  fi
}

function ff() {
  fw ${1:=$WORKSPACE_FOLDER} false true
}

alias nvim=vim
alias ev="nvim ~/.vimrc"
alias dotc="cd $DOTFILES && code ."

function nn {
  fw $WORKSPACE_FOLDER false false true
}

if [[ ! -f ~/.iterm2_shell_integration.zsh ]]; then
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
else
  source ~/.iterm2_shell_integration.zsh
fi

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $(git branch --show-current 2> /dev/null)
}

dn # for first enter/open new tab/pane
add-zsh-hook chpwd dn
add-zsh-hook preexec dn

reverse_history_search() {
  history 1 | tail -r |ipt -a -S 10
}

zle -N  reverse_history_search
bindkey '^R' reverse_history_search

