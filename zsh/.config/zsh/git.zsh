# {{{ Show Git Info
# Ref: https://salferrarello.com/zsh-git-status-prompt/
# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red
PROMPT='%1~ %F{white}${vcs_info_msg_0_}%f %# '

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

alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git checkout master"
alias gcd="git checkout develop"

alias gf="git fetch"
alias gfp="git fetch --prune"

alias gpdr="git pull origin develop --rebase"
alias gp="git pull;gfp"

alias gbdr="git push origin -d"
alias gpp="git push"
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
 alias gll="git log --pretty=format:%B--- -n$1"
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

function gcoo {
  branch_name=$(git branch -a | fzf)
  branch_name_with_spaces=${branch_name/remotes\/origin\//}
  git checkout $(echo $branch_name_with_spaces | tr -d " ")
}

function gcof {
  git fetch --prune
  git checkout $(git branch -a | fzf)
}

# Ex: gcbb feature/Abc def ghik ---> brach created: feature/abc_def_ghik
function gcbb() {
  git checkout -b $(echo ${@:l} | sed "s/ \{1,\}/-/g" | sed "s/\[.*\]//" | sed "s/{.*}//" | sed "s/(.*)//")
}

function gpu {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  echo "Pushing to ${1:=origin} $branch_name"
  git push -u ${1:=origin} $branch_name
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
# }}}
