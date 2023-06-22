# {{{ Show Git Info
# Ref: https://salferrarello.com/zsh-git-status-prompt/
# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
add-zsh-hook precmd add_bare_string

function is_bare_repo() {
  git config --local --get core.bare >/dev/null 2>&1
  if [ $? -eq 0 ]; then

    if $(git config --local --get core.bare) -eq true; then
      true
      return
    fi
  fi

  false
}

function add_bare_string() {
  bare_status=""
  dir_path="%1~"
  if is_bare_repo; then
        bare_status="[bare]"
        bare_path=$(git worktree list| grep "(bare)"|cut -d " " -f 1) # only get bare path
        dir_path="${bare_path:t}/${PWD/$bare_path\//}"
  fi

  PROMPT='$dir_path %F{yellow}$bare_status%F{white}${vcs_info_msg_0_}%f %# '
}


# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red
PROMPT='%1~ %F{yellow}$bare_status%F{white}${vcs_info_msg_0_}%f %# '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
# }}}

# {{{ Alias
alias lg="lazygit"

alias gs="git status"

alias gb="git branch"
alias gbd="git branch -d"
alias grn="git branch -m"

alias ga="git add ."
alias gw="git add .;git commit -n -m \"WIP\""
alias gac="ga;gc"

alias gca="git commit -v --amend"
alias gcae="git commit -v --amend --no-edit"
alias gce="git commit -e"

alias gcm="gco master"
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
function gc {
  git commit -v -m $@
}

function bare_branch_checkout() {
  branch_name=$1
  is_create_new_branch=${2:=false}
  derived_from=${3:=$(git branch --show-current)}

  if is_bare_repo; then
    dir=$(git worktree list|grep $branch_name | head -n 1 |awk '{ print $1 }')
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

# Get a branch name from fzf, remove remotes/origin/
# if a bare repository
#
# else
#   just checkout
function gcoo {
  # list all branch
  # remove HEAd
  # put in fzf
  # get rid of * branch_name or + branch_name
  # get rid of space
  branch_name=$(git branch -a | sed '/HEAD/ d' | fzf | sed 's/\*//; s/\+//; s/ //' | sed 's#remotes/origin/##' | awk '{ print $1 }')

  bare_branch_checkout $branch_name
}

function gco() {
  branch_name=$1
  bare_branch_checkout $branch_name
}

function gcb() {
  bare_branch_checkout $1 true $2
}

# Ex: gcbb feature/Abc def ghik ---> brach created: feature/abc_def_ghik
function gcbb() {
 branch_name=$(echo ${@:l} | sed "s/ \{1,\}/-/g" | sed "s/\[.*\]//" | sed "s/{.*}//" | sed "s/(.*)//")
 bare_branch_checkout $branch_name true
}

function gpu {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
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
  git branch | grep "*" | awk '{ print $2 }' | pbcopy
}

function gt () {
  tag_name="sync-$(date '+%d-%b-%Y' |awk '{print tolower($0)}')"
  date="$(date '+%d %b %Y')"
  git tag -a "$tag_name" -m "Sync on $date"
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

function tobare() {
  # Remove all but not .git folder
  ls -A1 | sed "/.git$/ d"|xargs rm -rf
  mv ./.git/* .
  rm -rf .git
  git config --local core.bare true
  git wtf
  gcb ${1:=master}

}

# Remove all except master & develop worktree
function git_worktree_clean() {
  git worktree list|cut -ws -f 1|sed '1d;/.*\/master$/d;/.*\/develop$/d'|xargs -n 1 git worktree remove -f
}

# }}}
