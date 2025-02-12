function get_pkg_json_scrip() {
  cat ${1:="."}/package.json|jq '.scripts' | sed "1d;$ d"|awk '$1=$1;'|cut -d " " -f 1| sed "s/:$//"|sed "s/\"//g"|fzf --preview "cat ${1:="."}/package.json| jq '.scripts.\"$(echo {})\"'" --preview-window=wrap --header="Select command to run"
}

function yr() {
  local root=$(git rev-parse --show-toplevel)
  cd $root
  yarn workspaces info 2>/dev/null 1>/dev/null
  if [[ $? -eq 1 ]]; then
    # Not workspace
    cmd=$(get_pkg_json_scrip)
    if [[ $? -gt 0 ]]; then
      return 1;
    fi
    yarn $cmd
  else
    # is a yarn workspace
    local workspaces=$(yarn workspaces info|sed '1d'|jq '. |= keys' 2>/dev/null | sed '1d; $d' |sed 's/,//'|sed 's/"//g'|awk '{$1=$1};1')
    workspaces="root \n $workspaces"
    ws=$(echo $workspaces|fzf --header="Select workspace")

    if [[ $? -gt 0 ]]; then
     return 1;
    fi

    local ws=$(echo $ws|xargs)

    local p="."
    if [[ ! "$ws" == "root" ]]; then
      local ws_location=$(yarn workspaces info|sed '1d'|sed '$d'|jq ".\"$(echo $ws)\".location"|sed 's/"//g')
      p="./$ws_location"
    fi
    local cmd=$(get_pkg_json_scrip $p)

    if [[ $? -gt 0 ]]; then
     return 1;
    fi

    if [[ ! "$ws" == "root" ]]; then
      yarn workspace $ws $cmd
    else
      yarn $cmd
    fi
  fi
}

function yrr() {
  ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
  echo $ws_list|xargs -L 1 -I {} yarn workspace {} $1
}

function yl() {
  local yarn_link_path="$HOME/.config/yarn/link"
  ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
  echo $ws_list|xargs -L 1 -I {} rm "$yarn_link_path/{}" # remove linked first
  echo $ws_list|xargs -L 1 -I {} yarn workspace {} link # then link
}

function yll() {
  local sdk_path=${1:="$WORKSPACE_FOLDER/nab-x-sdk/master"}
  local current_dir=$PWD
  cd $sdk_path
  ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
  cd $current_dir
  echo $ws_list|xargs -L 1 -I {} yarn link {}
}
