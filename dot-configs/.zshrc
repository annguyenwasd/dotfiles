#{{{ ZSH
export ZSH_DISABLE_COMPFIX=true
plugins=(
  themes
  vi-mode
)
ZSH_THEME="awesomepanda"

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
#}}}

# {{{ Exports
export ZSH="/Users/$(whoami)/.oh-my-zsh"
export EDITOR=nvim
export REACT_EDITOR=none
export DOTFILES=${HOME}/dotfiles
# export TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export SPRING_OUTPUT_ANSI_ENABLED=ALWAYS
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

USER_BIN="/usr/local/bin"
BREW="/usr/local/sbin"
NODE="./node_modules/.bin"
YARN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
RUBY="/usr/local/opt/ruby/bin"
PYTHON3="/usr/local/opt/python/libexec/bin"
LLVM="/usr/local/opt/llvm/bin"
OPENSSL="/usr/local/opt/openssl@1.1/bin"

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export JAVA_HOME="/Users/annguyenwasd/.sdkman/candidates/java/11.0.2-open"
export JDK_HOME="/Users/annguyenwasd/.sdkman/candidates/java/11.0.2-open"

export PATH="$USER_BIN:$OPENSSL:$BREW:$NODE:$YARN:$RUBY:$LLVM:$PYTHON3:$MY_BIN:$JAVA_HOME:$JDK_HOME:$PATH"

# prevent duplicate lines in history and skip add recent command to history by adding a space before the command
HISCONTROL=ignoreboth
#}}}

# {{{ Sourcing
source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fuzzy search
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # For syntax hilighting things
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env)" #For FNM: Node version manager
# }}}

#{{{ Settings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^ ' autosuggest-accept
zstyle ':completion:*' menu select
zmodload zsh/complist

# autoload -U promptinit; promptinit
# prompt spaceship
# export SPACESHIP_VI_MODE_SHOW=false
VI_MODE_SET_CURSOR=true # for oh-my-zsh vi-mode plugin
prompt_context() {
  # Custom (Random emoji)
  emojis=("⚡️" "🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🚦" "🌙"
   \ "🐶" "🐥" "🐣" "🐔" "🦄" "🐙" "🦑" "🦕" "🐳" "🐬" "🦍" "🐘" "🦛" "🐕" "🐓" "🦜"
   \ "🦢" "🍄" "🌚" "🌗" "🌑" "☄️" "☀️" "🌤" "⛅️" "🌥" "🌦" "🌧" "⛈ "
   \ "💀" "👻" "☠️" "👽" "👾" "🎭" "🎨" "🔞" "💯" "🔑" "🔫" "🧨" "💣" "☎️" "📦" "🗂"" "📎" "📝)

  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment black default "${emojis[$RAND_EMOJI_N]} "
}

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
# }}}

# {{{ Alias
alias sz="source ~/.zshrc && echo \"Sourced.\""
alias w="cd ~/workspace"
alias d="cd ~/Desktop"
alias mk="mkdir -vp"
alias dot="cd $DOTFILES && nvim"
alias cl="clear"
alias ydl="youtube-dl -i"
alias lg="lazygit"
alias lzd="lazydocker"
alias r="ranger"

# kill process
alias p="netstat -vanp tcp | grep $1"
alias pk="kill -9 $1"
alias x="exit 0"

alias allcs="cowsay -l | tr ' ' \\n | tail -n+5 | xargs -n1 -I@ sh -c 'cowsay -f@ @'"
## npm aliases
alias ni="npm install"
alias cc="npx codeceptjs"

## yarn aliases
alias ys="yarn run start"
alias yys="yarn && yarn run start"
alias yb="yarn run build"
alias ysb="yarn run storybook"

# Projects
alias md="mvn spring-boot:run -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005\" -Dspring-boot.run.profiles=local"
alias mc="mvn clean install -DskipTests=true"
alias mr="mvn spring-boot:run -Dspring-boot.run.profiles=local"
alias mcc="mvn clean install -DskipTests=true -s settings.xml;mvn spring-boot:run -Dspring-boot.run.profiles=local -s settings.xml"
alias mccc="mvn clean install -DskipTests=true;mvn spring-boot:run -Dspring-boot.run.profiles=local"
alias mt="mvn test"
alias mtd="mvn -Dmaven.surefire.debug -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005\" -Dspring-boot.run.profiles=local test"

alias atw="alacritty-theme-switch --config ~/.config/alacritty/alacritty.yml"

# Task
alias t="task"
alias ta="task add"

# }}}

# {{{ FZF
# fo: [FUZZY PATTERN] - Open the selected file with the default editor
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
)

# fcd - cd to selected directory, including hidden directories
fcd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


# fq - kill processes - list only the ones you can kill. Modified the earlier script.
fq() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

fag(){
  ag --nobreak --nonumbers --noheading . | fzf
}


# gco - checkout git branch (including remote branches)
fco() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gcop - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fcop() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fgl - git commit browser
fgl() {
  git log --all --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fsha - get git commit sha
# example usage: git rebase -i `fsha`
fsha() {
  local commits commit
  commits=$(git log --all --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# ftq: kill tmux session
ftq () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
fbi() {
    local token
    token=$(brew search | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew home $token
        fi
    fi
}

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
fbu() {
    local token
    token=$({ brew list --formula & brew list --cask; } | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepage of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew uninstall $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew home $token
        fi
    fi
}

# Select a docker container to start and attach to
function fda() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

function fds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function fdr() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

function at() {
 alacritty-theme-switch --config ~/.config/alacritty/alacritty.yml -s `ls ~/.config/alacritty/themes/ | fzf`
}
# }}}

# {{{ Git
function gc {
	branch_name=$(git rev-parse --abbrev-ref HEAD)
	ticket_name="${branch_name/feature\//}"
	ticket_name="${ticket_name/fixbug\//}"
	ticket_name="${ticket_name/hotfix\//}"
	# git commit -v -m "[${ticket_name}] $@" -e
  git commit -v -m $@
}

# Open files in specific commit
function opencommitfile {
  git diff-tree --name-only -r $1 | sed '1d' | sed 's/doltech\///' | tr '\n' ' ' | xargs nvim 

}

function gpu {
	branch_name=$(git rev-parse --abbrev-ref HEAD)
  echo "Pushing to origin $branch_name"
  git push -u origin $branch_name
}

# https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html
function gcf {
  git commit --fixup --no-verify `fsha`
}

function gria {
  git rebase -i --autosquash `fsha`
}

# Delete branches has upstream deleted
function dgbg() {
  git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs git branch -D
}

function gcount {
  echo "total commits are: $(git log --oneline HEAD...$1 | wc -l)"
  git log --oneline HEAD...$1
}

# https://til.hashrocket.com/posts/18139f4f20-list-different-commits-between-two-branches
# git log --left-right --graph --cherry-pick --oneline feature...branch
alias gd="git log --left-right --graph --cherry-pick --oneline "
alias gac="ga;gc"
alias gca="git commit -v --amend"
alias gcz="git cz"
alias gco="git checkout"
alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gcb="git checkout -b"
alias gba="git branch -vv"
alias gb="gba | grep -v gone"
alias gbg="gba | grep gone"
alias gbl="gb | grep -v origin"
alias gbr="gb | grep origin"
alias gbd="git branch -d"
alias gbdr="git push origin -d"
alias gs="git status"
alias gsh="git stash -u"
alias gsp="git stash pop"
alias gsl="git stash list"
alias gp="git pull;gfp"
alias gf="git fetch"
alias gpp="git push"
alias gpf="git push --force-with-lease"
alias ga="git add ."
alias gl="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s  %C(bold blue)<%an>%Creset %Cgreen%ar / %ad%Creset %n %b'"
alias gla="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glo="git log --oneline --all"
alias gls="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias gr="git rebase"
alias gri="git rebase -i"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias fc="ga; gc \"update\";gpp"
alias fast-commit="fc"
alias gfp="git fetch --prune"
alias grn="git branch -m"

alias tinyhead="git diff --diff-filter=ACM --name-only HEAD | grep \".png\|.jpg\" | xargs tinypng"

git config --global user.name "An Nguyen"
git config --global user.email "an.nguyenwasd@gmail.com"
# }}}

# {{{ Misc
colors () {
    for i in {0..255}
    do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

function cs() {
  cow=(`cowsay -l | tail -n +2 | tr  " "  "\n" | sort -R | head -n 1`)
  cowsay -f $cow "$@"
}

function csfr() {
  cow=(`cowsay -l | tail -n +2 | tr  " "  "\n" | sort -R | head -n 1`)
  if ( -n $1)
  then
    cowsay -f $cow "$1"
  else
    fortune | cowsay -f $cow "$@"
  fi
}

function allcs() {
  mycows=$(cowsay -l | tail -n +2 | tr " " "\n")
  for mycow in $mycows
  do
    # fortune | cowsay -f $mycow
    echo $mycow
    cowsay -f $mycow "whoops"

  done
}

function csf() {
 # fortune | cs
 fortune | cowsay -d -f sodomized $@
}

function bb {
  echo "Backing up brew file"
  cd $DOTFILES/.non-stow/install/
  rm Brewfile
  brew bundle dump
  echo "Done!"
}

function gif {
  echo "making gif $1"
  ffmpeg -i $1 -s 1366x768 -pix_fmt rgb24 -r 18 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
  echo "Done!"
}

function cf () 
{ 
    for x in $@;
    do
        echo $x:;
        cat "$x";
    done;
    unset x
}

#}}}


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true


function gn() {
  git branch | grep "*" | awk '{ print $2 }' | pbcopy
}

# set tmux window title as current directoty
function dn() {
  tmux rename-window $(echo ${PWD##*/})
}

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}


function dd() {
  # osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text" sound name "Submarine"'

    osascript -e "display notification \"${1:=Done!}\" with title \"${2:=${PWD/~\//}}\" sound name \"Submarine\""
}

# tmux layout
function tl() {
  tmux killp -a
  tmux clock-mode
  tmux splitw
  tmux selectl main-vertical
}

WORKSPACE_FOLDER=~/workspace

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

function gw () {
  ga .
  gc -n -m "WIP"
}

alias gll="git log --pretty=format:%B--- -n$1 --no-merges"
export NVIM_HOME=~/.config/nvim/

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/annguyenwasd/.sdkman"
[[ -s "/Users/annguyenwasd/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/annguyenwasd/.sdkman/bin/sdkman-init.sh"
