# output example: 679-764-994-561-683-256-584-774
unique_name() {
    local numbers=()

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS: Use `jot` to generate random numbers
        for _ in {1..8}; do
            local num=$(jot -r 1 999)
            numbers+=($num)
        done
    else
        # Linux: Use `shuf` to generate random numbers
        for _ in {1..8}; do
            local num=$(shuf -i 1-999 -n 1)
            numbers+=($num)
        done
    fi

    # Join numbers with '-' character
    echo ${(j:-:)numbers}
}

# Fastest way to remove node_modules -> Non-block install new packages
# by `npm install` or `yarn install`
function rmm () {
  # Variables
  local trash_dir_name=$(unique_name)
  local trash_dir_path="/tmp/trash/$trash_dir_name"
  mkdir -p "$trash_dir_path"

  case "$1" in
    -h|--help)
      # Help section
      echo "Usage: rmm [OPTION] [PATTERN]"
      echo "Remove directories matching the specified pattern or 'node_modules' by default."
      echo
      echo "OPTIONS:"
      echo "  -p         Preview the directories that would be removed without actually removing them."
      echo "  -h, --help Show this help message."
      echo
      echo "PATTERN:"
      echo "  Specify a pattern to match directories for removal."
      echo "  Default is 'node_modules'."
      return
      ;;

    -p)
      # Preview directories
      find . -name "${2:=node_modules}" -type d -prune -exec echo '{}' ";"
      ;;

    *)
      # Default case: Perform deletion
      local list=( $(find . -name "${1:=node_modules}" -type d -prune | sed "s/\.\///") )
      for dir in $list; do
        local new_name=$(unique_name)
        mv -f "$dir" "$trash_dir_path/$new_name"
      done
      rm -rf "$trash_dir_path" &
      ;;
  esac
}
