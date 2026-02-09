# ============================================================================
# Package Manager Auto-Detection and Script Runner
# ============================================================================
# These functions provide an interactive way to run package.json scripts
# with automatic detection of the package manager (yarn, pnpm, or npm).
# Supports both single projects and monorepo workspaces.
# ============================================================================

# detect_package_manager - Detect which package manager is used in the project
# Usage: detect_package_manager [path]
# Arguments:
#   path - Optional path to project root (defaults to current directory)
# Returns: "pnpm", "yarn", or "npm" based on lock file presence
# Detection order: pnpm-lock.yaml > yarn.lock > package-lock.json
function detect_package_manager() {
  local root=${1:-.}
  if [[ -f "$root/pnpm-lock.yaml" ]]; then
    echo "pnpm"
  elif [[ -f "$root/yarn.lock" ]]; then
    echo "yarn"
  elif [[ -f "$root/package-lock.json" ]]; then
    echo "npm"
  else
    echo "npm"
  fi
}

# get_pkg_json_scrip - Extract and select a script from package.json
# Usage: get_pkg_json_scrip [path]
# Arguments:
#   path - Optional path to directory containing package.json (defaults to ".")
# Behavior:
#   - If ANNGUYENWASD_PROFILE is "work": uses ipt for selection
#   - Otherwise: uses fzf with preview window
# Returns: Selected script name
function get_pkg_json_scrip() {
  if [[ "$ANNGUYENWASD_PROFILE" == "work" ]]; then
    cat ${1:="."}/package.json|jq '.scripts' | sed "1d;$ d"|awk '$1=$1;'|cut -d " " -f 1| sed "s/:$//"|sed "s/\"//g"|ipt -S 10 -a
  else
    cat ${1:="."}/package.json|jq '.scripts' | sed "1d;$ d"|awk '$1=$1;'|cut -d " " -f 1| sed "s/:$//"|sed "s/\"//g"|fzf --preview "cat ${1:="."}/package.json| jq '.scripts.\"$(echo {})\"'" --preview-window=wrap --header="Select command to run"
  fi
}

# yr - Interactive package.json script runner with workspace support
# Usage: yr
# Description:
#   Runs package.json scripts interactively with automatic package manager detection.
#   For monorepo workspaces, allows selection of workspace before script selection.
#   For non-workspace projects, runs scripts directly without workspace keyword.
#   Supports yarn, pnpm, and npm workspaces.
# Behavior:
#   1. Detects package manager (yarn/pnpm/npm)
#   2. Checks if project is a workspace/monorepo
#   3. If workspace: prompts for workspace selection (including "root")
#   4. If not workspace: runs script directly from current directory
#   5. Prompts for script selection from package.json
#   6. Executes the selected script using appropriate package manager command
# Notes:
#   - Ctrl+C at any prompt will cancel the entire operation
#   - Uses ipt for selection if ANNGUYENWASD_PROFILE is "work", otherwise fzf
function yr() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd $root
  
  local pm=$(detect_package_manager "$root")
  
  # Check if workspace
  local is_workspace=1
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 2>/dev/null 1>/dev/null
    is_workspace=$?
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info 2>/dev/null 1>/dev/null
    is_workspace=$?
  else
    # npm workspaces check
    npm query ".workspace" 2>/dev/null 1>/dev/null
    is_workspace=$?
  fi
  
  if [[ $is_workspace -eq 1 ]]; then
    # Not workspace - run directly
    cmd=$(get_pkg_json_scrip) || return 1
    [[ -z "$cmd" ]] && return 1
    $pm run $cmd
  else
    # is a workspace
    local workspaces=""
    if [[ "$pm" == "pnpm" ]]; then
      workspaces=$(pnpm list -r --depth=-1 --json 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
    elif [[ "$pm" == "yarn" ]]; then
      workspaces=$(yarn workspaces info|sed '1d'|jq '. |= keys' 2>/dev/null | sed '1d; $d' |sed 's/,//'|sed 's/"//g'|awk '{$1=$1};1')
    else
      workspaces=$(npm query ".workspace" 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
    fi
    
    workspaces="root \n $workspaces"
    
    if [[ "$ANNGUYENWASD_PROFILE" == "work" ]]; then
      ws=$(echo $workspaces|ipt -a -S 10) || return 1
    else
      ws=$(echo $workspaces|fzf --header="Select workspace") || return 1
    fi

    [[ -z "$ws" ]] && return 1
    local ws=$(echo $ws|xargs)

    local p="."
    if [[ ! "$ws" == "root" ]]; then
      if [[ "$pm" == "pnpm" ]]; then
        local ws_location=$(pnpm list -r --depth=-1 --json 2>/dev/null|jq -r ".[] | select(.name==\"$ws\") | .path" 2>/dev/null|sed "s|$root/||")
        p="./$ws_location"
      elif [[ "$pm" == "yarn" ]]; then
        local ws_location=$(yarn workspaces info|sed '1d'|sed '$d'|jq ".\"$(echo $ws)\".location"|sed 's/"//g')
        p="./$ws_location"
      else
        local ws_location=$(npm query ".workspace" 2>/dev/null|jq -r ".[] | select(.name==\"$ws\") | .path" 2>/dev/null|sed "s|$root/||")
        p="./$ws_location"
      fi
    fi
    
    local cmd=$(get_pkg_json_scrip $p) || return 1
    [[ -z "$cmd" ]] && return 1

    if [[ ! "$ws" == "root" ]]; then
      if [[ "$pm" == "pnpm" ]]; then
        pnpm --filter "$ws" run $cmd
      elif [[ "$pm" == "yarn" ]]; then
        yarn workspace $ws $cmd
      else
        npm run $cmd --workspace=$ws
      fi
    else
      $pm run $cmd
    fi
  fi
}

# yrr - Run script across all workspaces or in current directory
# Usage: yrr <script-name>
# Arguments:
#   script-name - Name of the npm script to run
# Description:
#   If in a monorepo workspace: executes the script in all workspaces.
#   If not in a workspace: runs the script directly in current directory.
#   Automatically detects package manager and uses appropriate command.
# Example:
#   yrr build    # Runs "build" script in all workspaces or current dir
#   yrr test     # Runs "test" script in all workspaces or current dir
function yrr() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd $root
  local pm=$(detect_package_manager "$root")
  
  # Check if workspace
  local is_workspace=1
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 2>/dev/null 1>/dev/null
    is_workspace=$?
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info 2>/dev/null 1>/dev/null
    is_workspace=$?
  else
    npm query ".workspace" 2>/dev/null 1>/dev/null
    is_workspace=$?
  fi
  
  if [[ $is_workspace -eq 1 ]]; then
    # Not workspace - run directly
    $pm run $1
  else
    # Is a workspace - run in all workspaces
    local ws_list=""
    if [[ "$pm" == "pnpm" ]]; then
      ws_list=$(pnpm list -r --depth=-1 --json 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
      echo $ws_list|xargs -L 1 -I {} pnpm --filter {} run $1
    elif [[ "$pm" == "yarn" ]]; then
      ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
      echo $ws_list|xargs -L 1 -I {} yarn workspace {} $1
    else
      ws_list=$(npm query ".workspace" 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
      echo $ws_list|xargs -L 1 -I {} npm run $1 --workspace={}
    fi
  fi
}

# yl - Link workspaces or current package for local development
# Usage: yl
# Description:
#   If in a monorepo: links all workspaces for local development.
#   If not in a workspace: links the current package globally.
#   Useful when you want to test changes across workspace dependencies.
#   For yarn: removes existing links first, then creates new ones
#   For pnpm: creates links for all workspaces or current package
#   For npm: links current package globally
# Note: Works with yarn, pnpm, and npm
function yl() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd $root
  local pm=$(detect_package_manager "$root")
  
  # Check if workspace
  local is_workspace=1
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 2>/dev/null 1>/dev/null
    is_workspace=$?
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info 2>/dev/null 1>/dev/null
    is_workspace=$?
  else
    npm query ".workspace" 2>/dev/null 1>/dev/null
    is_workspace=$?
  fi
  
  if [[ $is_workspace -eq 1 ]]; then
    # Not workspace - link current package
    if [[ "$pm" == "yarn" ]]; then
      local yarn_link_path="$HOME/.config/yarn/link"
      local pkg_name=$(cat package.json|jq -r '.name')
      rm -f "$yarn_link_path/$pkg_name" 2>/dev/null # remove link first
      yarn link
    elif [[ "$pm" == "pnpm" ]]; then
      local pkg_name=$(cat package.json|jq -r '.name')
      pnpm unlink --global $pkg_name 2>/dev/null # remove link first
      pnpm link --global
    else
      npm unlink 2>/dev/null # remove link first
      npm link
    fi
  else
    # Is a workspace - link all workspaces
    if [[ "$pm" == "yarn" ]]; then
      local yarn_link_path="$HOME/.config/yarn/link"
      ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
      echo $ws_list|xargs -L 1 -I {} rm -f "$yarn_link_path/{}" 2>/dev/null # remove linked first
      echo $ws_list|xargs -L 1 -I {} yarn workspace {} link # then link
    elif [[ "$pm" == "pnpm" ]]; then
      ws_list=$(pnpm list -r --depth=-1 --json 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
      echo $ws_list|xargs -L 1 -I {} pnpm unlink --global {} 2>/dev/null # remove linked first
      echo $ws_list|xargs -L 1 -I {} pnpm --filter {} link --global
    else
      echo "npm workspace linking not fully supported - use 'npm link' in individual packages"
    fi
  fi
}

# yll - Link external SDK workspaces or package to current project
# Usage: yll [sdk-path]
# Arguments:
#   sdk-path - Optional path to SDK directory (defaults to $WORKSPACE_FOLDER/nab-x-sdk/master)
# Description:
#   If SDK is a workspace: links all workspaces from the SDK into current project.
#   If SDK is not a workspace: links the single package into current project.
#   Useful for local development when working with external dependencies.
#   Detects package manager in the SDK directory and uses appropriate link command.
# Example:
#   yll                              # Links from default SDK path
#   yll ~/projects/my-sdk            # Links from custom SDK path
function yll() {
  local sdk_path=${1:="$WORKSPACE_FOLDER/nab-x-sdk/master"}
  local current_dir=$PWD
  cd $sdk_path
  
  local pm=$(detect_package_manager "$sdk_path")
  
  # Check if SDK is a workspace
  local is_workspace=1
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 2>/dev/null 1>/dev/null
    is_workspace=$?
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info 2>/dev/null 1>/dev/null
    is_workspace=$?
  else
    npm query ".workspace" 2>/dev/null 1>/dev/null
    is_workspace=$?
  fi
  
  if [[ $is_workspace -eq 1 ]]; then
    # Not workspace - link single package
    local pkg_name=$(cat package.json|jq -r '.name')
    cd $current_dir
    if [[ "$pm" == "yarn" ]]; then
      yarn link $pkg_name
    elif [[ "$pm" == "pnpm" ]]; then
      pnpm link --global $pkg_name
    else
      npm link $pkg_name
    fi
  else
    # Is a workspace - link all workspaces
    if [[ "$pm" == "yarn" ]]; then
      ws_list=$(yarn workspaces info|sed '1 d;$ d'|jq 'to_entries[] |.key'|sed 's/"//g'|awk '{$1=$1};1')
      cd $current_dir
      echo $ws_list|xargs -L 1 -I {} yarn link {}
    elif [[ "$pm" == "pnpm" ]]; then
      ws_list=$(pnpm list -r --depth=-1 --json 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
      cd $current_dir
      echo $ws_list|xargs -L 1 -I {} pnpm link --global {}
    else
      ws_list=$(npm query ".workspace" 2>/dev/null|jq -r '.[].name' 2>/dev/null|awk '{$1=$1};1')
      cd $current_dir
      echo $ws_list|xargs -L 1 -I {} npm link {}
    fi
  fi
}
