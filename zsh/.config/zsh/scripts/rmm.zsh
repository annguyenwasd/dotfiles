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
_rmm() {
    local -a directories
    directories=($(ls -pa|grep "/" | sed "/\.\// d; s/\///"))

    _arguments \
        '-h[Show help message]' \
        '--help[Show help message]' \
        '-p[Preview directories to be removed]' \
        '1: :->first_arg' \
        '*: :->dir_names'

    case $state in
        first_arg)
            if [[ $words[CURRENT-1] == -p ]]; then
                _describe 'directory' directories
            else
                _alternative \
                    'directories:directory:($directories)' \
                    'options:option:(-p -h --help)'
            fi
            ;;
        dir_names)
            _describe 'directory' directories
            ;;
    esac
}

compdef _rmm rmm

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
      local dirname=${2:=node_modules}
      if [[ $dirname == "node_modules" ]]; then
        find . -name "$dirname" -type d -prune | sed "s/\.\///"
      else
        find . -name "$dirname" -type d -prune | grep -v "node_modules" | sed "s/\.\///"
      fi
      ;;

    *)
      # Default case: Perform deletion
      local dirname=${1:=node_modules}
      local list=( )
      if [[ $dirname == "node_modules" ]]; then
        list=( $(find . -name "$dirname" -type d -prune | sed "s/\.\///") )
      else
        list=( $(find . -name "$dirname" -type d -prune | grep -v "node_modules" | sed "s/\.\///") )
      fi
      for dir in $list; do
        local new_name=$(unique_name)
        mv -f "$dir" "$trash_dir_path/$new_name"
      done
      rm -rf "$trash_dir_path" &
      ;;
  esac
}
