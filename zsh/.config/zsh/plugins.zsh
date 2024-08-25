function add_plugin(){
  short_url=$1 #username/reponame
  branch=$2
  repo_name=$(echo "$1"|sed "s/.*\///")
  dst="$HOME/"."$repo_name"
  url="https://github.com/$short_url.git"
  if [[ ! -d  $dst ]]; then
    echo "Cloning $short_url"
    if [[ -n $branch ]]; then
      git clone $url -b $branch $dst
    else
      git clone $url $dst
    fi
  fi

  source $dst/$(ls -1 $dst | grep ".plugin.zsh")
}

export ZVM_VI_EDITOR="nvim"
add_plugin "scresante/zsh-vi-mode" "fixpacman"
add_plugin "popstas/zsh-command-time"
add_plugin "mroth/evalcache"

# https://github.com/wincent/wincent/blob/85fc42d9e96d408a/aspects/dotfiles/files/.zshrc
add_plugin "mafredri/zsh-async"

# Message to display (set to "" for disable).
ZSH_COMMAND_TIME_MSG="Took: %s"

# Message color.
ZSH_COMMAND_TIME_COLOR="yellow"

# Exclude some commands
ZSH_COMMAND_TIME_EXCLUDE=(nvim)
