# ============================================================================
# Package Manager Auto-Detection and Script Runner
# ============================================================================
# Interactive package.json script runner with automatic package manager
# detection (yarn, pnpm, npm). Supports single projects and monorepo workspaces.
# ============================================================================

if ! command -v jq &>/dev/null; then
  echo "yr.zsh: jq is required but not installed. Please install it (e.g. sudo pacman -S jq / brew install jq)" >&2
fi

# detect_package_manager - Detect which package manager is used in the project
# Returns: "pnpm", "yarn", or "npm"
# Checks package.json "packageManager" field first, falls back to lock files
function detect_package_manager() {
  local root=${1:-.}
  # Fast path: check packageManager field (e.g. "pnpm@9.1.0")
  if [[ -f "$root/package.json" ]]; then
    local pm_field
    pm_field=$(jq -r '.packageManager // empty' "$root/package.json" 2>/dev/null)
    if [[ -n "$pm_field" ]]; then
      echo "${pm_field%%@*}"
      return
    fi
  fi
  # Fallback: check lock files
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

# _is_workspace - Check if project is a monorepo workspace
# Returns: 0 if workspace, 1 if not
# Checks package.json "workspaces" field first (instant), falls back to PM commands
function _is_workspace() {
  local pm=$1
  # Fast path: check package.json for workspaces field
  if jq -e '.workspaces // empty' package.json &>/dev/null; then
    return 0
  fi
  # Fallback: check workspace config files
  if [[ "$pm" == "pnpm" ]]; then
    [[ -f "pnpm-workspace.yaml" ]]
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info 2>/dev/null 1>/dev/null
  else
    npm query ".workspace" 2>/dev/null 1>/dev/null
  fi
}

# _get_workspaces - Get list of workspace names
function _get_workspaces() {
  local pm=$1
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 --json 2>/dev/null | jq -r '.[].name' 2>/dev/null | awk '{$1=$1};1'
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info | sed '1d' | jq '. |= keys' 2>/dev/null | sed '1d; $d' | sed 's/,//' | sed 's/"//g' | awk '{$1=$1};1'
  else
    npm query ".workspace" 2>/dev/null | jq -r '.[].name' 2>/dev/null | awk '{$1=$1};1'
  fi
}

# _get_ws_location - Get filesystem path for a workspace by name
function _get_ws_location() {
  local pm=$1 ws=$2 root=$3
  if [[ "$pm" == "pnpm" ]]; then
    pnpm list -r --depth=-1 --json 2>/dev/null | jq -r ".[] | select(.name==\"$ws\") | .path" 2>/dev/null | sed "s|$root/||"
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspaces info | sed '1d' | sed '$d' | jq ".\"$ws\".location" | sed 's/"//g'
  else
    npm query ".workspace" 2>/dev/null | jq -r ".[] | select(.name==\"$ws\") | .path" 2>/dev/null | sed "s|$root/||"
  fi
}

# _select_script - Extract scripts from package.json and let user pick one via fzf
function _select_script() {
  local dir=${1:-.}
  local pkg="$dir/package.json"
  [[ ! -f "$pkg" ]] && echo "No package.json found in $dir" >&2 && return 1

  local scripts
  scripts=$(jq -r '.scripts // {} | keys[]' "$pkg" 2>/dev/null)
  [[ -z "$scripts" ]] && echo "No scripts found in $pkg" >&2 && return 1

  if [[ "$ANNGUYENWASD_PROFILE" == "work" ]]; then
    echo "$scripts" | ipt -S 10 -a
  else
    echo "$scripts" | fzf \
      --preview "jq -r '.scripts.\"{}\"' \"$pkg\"" \
      --preview-window=wrap \
      --header="Select script to run"
  fi
}

# _fuzzy_select - Generic fzf/ipt selector
function _fuzzy_select() {
  local header=$1
  if [[ "$ANNGUYENWASD_PROFILE" == "work" ]]; then
    ipt -a -S 10
  else
    fzf --header="$header"
  fi
}

# sr - Interactive package.json script runner with workspace support
# Usage: sr
# For normal repos: shows scripts, pick one, runs it.
# For workspaces: pick workspace first (including "root"), then pick script.
function sr() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd "$root"

  local pm=$(detect_package_manager "$root")

  if ! _is_workspace "$pm"; then
    # Normal repo - just pick a script and run it
    local cmd
    cmd=$(_select_script) || return 1
    [[ -z "$cmd" ]] && return 1
    $pm run "$cmd"
    return
  fi

  # Workspace - pick workspace first
  local workspaces
  workspaces=$(_get_workspaces "$pm")
  [[ -z "$workspaces" ]] && echo "No workspaces found" >&2 && return 1

  local ws
  ws=$(printf "root\n%s" "$workspaces" | _fuzzy_select "Select workspace") || return 1
  [[ -z "$ws" ]] && return 1
  ws=$(echo "$ws" | xargs)

  local script_dir="."
  if [[ "$ws" != "root" ]]; then
    local ws_location
    ws_location=$(_get_ws_location "$pm" "$ws" "$root")
    script_dir="./$ws_location"
  fi

  local cmd
  cmd=$(_select_script "$script_dir") || return 1
  [[ -z "$cmd" ]] && return 1

  if [[ "$ws" == "root" ]]; then
    $pm run "$cmd"
  elif [[ "$pm" == "pnpm" ]]; then
    pnpm --filter "$ws" run "$cmd"
  elif [[ "$pm" == "yarn" ]]; then
    yarn workspace "$ws" "$cmd"
  else
    npm run "$cmd" --workspace="$ws"
  fi
}

# srr - Run script across all workspaces or in current directory
# Usage: srr <script-name>
# Example: srr build, srr test
function srr() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd "$root"
  local pm=$(detect_package_manager "$root")

  if ! _is_workspace "$pm"; then
    $pm run "$1"
    return
  fi

  local ws_list
  ws_list=$(_get_workspaces "$pm")

  if [[ "$pm" == "pnpm" ]]; then
    echo "$ws_list" | xargs -L 1 -I {} pnpm --filter {} run "$1"
  elif [[ "$pm" == "yarn" ]]; then
    echo "$ws_list" | xargs -L 1 -I {} yarn workspace {} "$1"
  else
    echo "$ws_list" | xargs -L 1 -I {} npm run "$1" --workspace={}
  fi
}

# sl - Link workspaces or current package for local development
# Usage: sl
function sl() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
  cd "$root"
  local pm=$(detect_package_manager "$root")

  if ! _is_workspace "$pm"; then
    if [[ "$pm" == "yarn" ]]; then
      local yarn_link_path="$HOME/.config/yarn/link"
      local pkg_name=$(jq -r '.name' package.json)
      rm -f "$yarn_link_path/$pkg_name" 2>/dev/null
      yarn link
    elif [[ "$pm" == "pnpm" ]]; then
      local pkg_name=$(jq -r '.name' package.json)
      pnpm unlink --global "$pkg_name" 2>/dev/null
      pnpm link --global
    else
      npm unlink 2>/dev/null
      npm link
    fi
    return
  fi

  local ws_list
  ws_list=$(_get_workspaces "$pm")

  if [[ "$pm" == "yarn" ]]; then
    local yarn_link_path="$HOME/.config/yarn/link"
    echo "$ws_list" | xargs -L 1 -I {} rm -f "$yarn_link_path/{}" 2>/dev/null
    echo "$ws_list" | xargs -L 1 -I {} yarn workspace {} link
  elif [[ "$pm" == "pnpm" ]]; then
    echo "$ws_list" | xargs -L 1 -I {} pnpm unlink --global {} 2>/dev/null
    echo "$ws_list" | xargs -L 1 -I {} pnpm --filter {} link --global
  else
    echo "npm workspace linking not fully supported - use 'npm link' in individual packages"
  fi
}

# sll - Link external SDK workspaces or package to current project
# Usage: sll [sdk-path]
# Example: sll ~/projects/my-sdk
function sll() {
  local sdk_path=${1:="$WORKSPACE_FOLDER/nab-x-sdk/master"}
  local current_dir=$PWD
  cd "$sdk_path"

  local pm=$(detect_package_manager "$sdk_path")

  if ! _is_workspace "$pm"; then
    local pkg_name=$(jq -r '.name' package.json)
    cd "$current_dir"
    if [[ "$pm" == "yarn" ]]; then
      yarn link "$pkg_name"
    elif [[ "$pm" == "pnpm" ]]; then
      pnpm link --global "$pkg_name"
    else
      npm link "$pkg_name"
    fi
    return
  fi

  local ws_list
  ws_list=$(_get_workspaces "$pm")
  cd "$current_dir"

  if [[ "$pm" == "yarn" ]]; then
    echo "$ws_list" | xargs -L 1 -I {} yarn link {}
  elif [[ "$pm" == "pnpm" ]]; then
    echo "$ws_list" | xargs -L 1 -I {} pnpm link --global {}
  else
    echo "$ws_list" | xargs -L 1 -I {} npm link {}
  fi
}

# ys - Run start script with auto-detected package manager
function ys() {
  local pm=$(detect_package_manager)
  $pm run start
}

# yt - Run test script with auto-detected package manager
function yt() {
  local pm=$(detect_package_manager)
  $pm test "$@"
}

# yb - Run build script with auto-detected package manager
function yb() {
  local pm=$(detect_package_manager)
  $pm run build
}

# yd - Run dev script with auto-detected package manager
function yd() {
  local pm=$(detect_package_manager)
  $pm run dev
}

# yi - Install dependencies with auto-detected package manager
# No args: install all deps. With args: add specific packages.
function yi() {
  local pm=$(detect_package_manager)
  if [[ $# -eq 0 ]]; then
    $pm install
  elif [[ "$pm" == "yarn" ]]; then
    yarn add "$@"
  elif [[ "$pm" == "pnpm" ]]; then
    pnpm add "$@"
  else
    npm install "$@"
  fi
}

# yw - Check why a package is installed with auto-detected package manager
function yw() {
  local pm=$(detect_package_manager)
  if [[ "$pm" == "npm" ]]; then
    npm explain "$@"
  else
    $pm why "$@"
  fi
}
