# {{{ Alias
alias lg="lazygit"

alias gs="git status"
alias gss="nvim +G +on"

alias gb="git branch"
alias gbd="git branch -d"
alias grn="git branch -m"

alias ga="git add ."
alias gw="git add .;git commit -n -m \"WIP\""
alias gac="ga;gc"

alias gca="git commit -v --amend"
alias gcae="git commit -v --amend --no-edit"
alias gce="git commit -e"

alias gcd="gco develop"

alias gf="git fetch"
alias gfp="git fetch --prune"

alias gpdr="git pull origin develop --rebase"
alias gp="git pull;gfp"

alias gbdr="git push origin -d"
alias gpp="git push"
alias gppt="git push --follow-tags"
alias gpf="git push --force-with-lease"

alias gsh="git stash -u"
alias gsp="git stash pop"
alias gsl="git stash list"

alias gr="git rebase"
alias gri="git rebase -i"
alias gra="git rebase --abort"
alias grc="git rebase --continue"

alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"

alias gd="git diff"
alias gdc="git diff --cached"
alias gdl="git dl"

alias gl="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s  %C(bold blue)<%an>%Creset %Cgreen%ar / %ad%Creset %n %b'"
alias gll="git log --reverse --pretty=format:%B--- -n$1"
alias gla="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glao="git log --all --oneline "
alias glo="git log --oneline"
alias gls="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
# Ref https://til.hashrocket.com/posts/18139f4f20-list-different-commits-between-two-branches
# git log --left-right --graph --cherry-pick --oneline feature...branch
alias gd2="git log --left-right --graph --cherry-pick --oneline "

# }}}

# {{{ Functions

# only get bare path
function get_bare_path(){
  git worktree list| grep "(bare)"|cut -d " " -f 1
}

function fzf_bare_branches() {
  bare_path=$(get_bare_path)
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
  if [[ -n $dir ]]; then
    cd "$bare_path/$dir"
    true
  else
    echo "Aborted by user."
    false
  fi
}

function gc {
  git commit -v -m $@
}

function bare_branch_checkout() {
  branch_name=$1
  is_create_new_branch=${2:=false}
  derived_from=${3:=$(git branch --show-current)}

  if is_bare_repo; then
    dir=$(git worktree list|grep -F "[$branch_name]" | head -n 1 |awk '{ print $1 }')
    if [[ -n $dir ]]; then
      cd $dir
    else
      root=$(git worktree list | grep bare | awk '{ print $1 }')
      dir="$root/$branch_name"
      if [[ $(git branch| grep $branch_name | wc -l) -eq 0 ]]; then
        if $is_create_new_branch; then
          git branch $branch_name $derived_from
        else
          git branch --track $branch_name origin/$branch_name
        fi
      fi
      git worktree add $dir $branch_name
      cd $dir
    fi
  else
    if $is_create_new_branch; then
      git checkout -b $branch_name
    else
      git checkout $branch_name
    fi
  fi
}

# returns either code 1 or branch name string
function select_branch(){
  branch_name=$(git branch -a | sed '/HEAD/ d' | fzf)
  if [[ $? -eq 0 ]]; then
    branch_name=$(echo $branch_name | sed 's/\*//; s/\+//; s/ //' | sed 's#remotes/origin/##' | awk '{ print $1 }')
    echo $branch_name
  else
    return 1
  fi
}

function gcoo {
  branch_name=$(select_branch)
  if [[ -z $branch_name ]]; then
    echo "No branch selected. Aborting..."
  else
    bare_branch_checkout $branch_name
  fi
}

function gco() {
  local branch_name=$1
  bare_branch_checkout $branch_name
}

function _git_branches() {
    local -a branches
    branches=(${(f)"$(git branch --all | grep -v HEAD | sed 's/.* //' | sed 's#remotes/##')"})
    _describe -t branches 'git branches' branches
}

function _gco() {
    _arguments \
        '1: :_git_branches'
}

compdef _gco gco

function gcb() {
  bare_branch_checkout $1 true $2
}

# Ex: gcbb feature/Abc def ghik ---> brach created: feature/abc-def-ghik
function gcbb() {
  branch_name=$(echo ${@:l} | sed -E 's/[^a-zA-Z0-9/]+/-/g; s/-+/-/g')
  bare_branch_checkout $branch_name true
}

function gpu {
  branch_name=$(git branch --show-current)
  echo "Pushing to ${1:=origin} $branch_name"
  git push -u ${1:=origin} $branch_name
}

function gpt {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  echo "Pushing to ${1:=origin} $branch_name"
  git push -u ${1:=origin} $branch_name --follow-tags
}

function gbu {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  git branch -u "${1:=origin}/$branch_name"
}

# Delete branches has upstream deleted
function gdd() {
  git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs git branch -D
}

function gcount {
  echo "Total commits are: $(git log --oneline HEAD...$1 | wc -l)"
  git log --oneline HEAD...$1
}

function gn() {
  echo -n $(git branch --show-current)|pbcopy
}

function gt () {
  tag_name="sync-$(date '+%d-%b-%Y' |awk '{print tolower($0)}')"
  date="$(date '+%d %b %Y')"
  git tag -a "$tag_name" -m "Sync on $date"
}

function tobare() {
  local current_branch_name="$(git branch --show-current)"
  # Remove all but not .git folder
  local list=( $(ls -A1 --color=never |grep --color=never -vE ".git$") )
  mkdir -vp "$current_branch_name"
  for item in $list; do
    mv -v "$item" "$current_branch_name/$item"
  done
  mv -v ./.git/* .
  rmdir -v .git
  git config --local core.bare true
  git wtf
  mv $current_branch_name xxxtmpxxx
  git wt add "./$current_branch_name" $current_branch_name
  mv "./$current_branch_name/.git" xxxtmpxxx/.git
  mv "./$current_branch_name" xxxdelxxx
  mv xxxtmpxxx $current_branch_name
  rmm xxxtmpxxx
  cd "$current_branch_name"
  echo "Done!"
}

# Remove a git branch or branches
# if stands in a bare repo, remove work tree first then remove branch
# if stands in a normal repo, remove branch
# if no param passed, show fzf prompt to select checked out branch(es)
#
# @param $1 string branch name, if pass anhy
function grm() {
  if [[ -z $1 ]]
  then
    branches=$(git branch |grep ^+ | sed "s/+ //"|fzf -m)
    for i in $(echo $branches) ; do
      grm $i
    done
    return
  fi


  if is_bare_repo
  then
    root=$(get_bare_path)
    $(git worktree remove --force $root/$1 2>/dev/null)
  fi
  git branch -D $1
}

# Remove all except master & develop worktree
function git_worktree_clean() {
  local list=( $(git worktree list|cut -ws -f 1|sed '1d;/.*\/master$/d;/.*\/develop$/d') )
  local dir
  for dir in $list; do
    local uniq=$(unique_name)
    local dst="/tmp/$uniq"
    mv "$dir" "$dst"
    rm -rf "$dst" &
    z -x $dir
  done
  git worktree prune
}

function is_branch_exist() {
    if git rev-parse --verify "$1" >/dev/null 2>&1; then
        return 0  # true
    else
        return 1  # false
    fi
}

function gcm() {
  if is_branch_exist master ; then
    gco master
    return 0
  fi

  if is_branch_exist main ; then
    gco main
    return 0
  fi
}

function is_bare_repo() {
    # Check if the core.bare setting is set and equals true
    if [[ $(git config --local --get core.bare 2>/dev/null) == "true" ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}
# }}}
