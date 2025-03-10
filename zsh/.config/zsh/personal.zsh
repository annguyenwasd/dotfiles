# fnm
if [[ -d $HOME/.local/share/fnm ]]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
  eval "$(fnm env --use-on-cd)"
fi

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -d /usr/share/fzf ] && source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh

# {{{ Export
export SPRING_OUTPUT_ANSI_ENABLED=ALWAYS
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export NODE_OPTIONS="--dns-result-order=ipv4first"

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/opt/ruby/bin"
export PATH="$PATH:/usr/local/opt/python/libexec/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH="$PATH:/usr/local/opt/openssl@1.1/bin"
export PATH="$PATH:-L/usr/local/opt/openssl@1.1/lib"
export PATH="$PATH:-I/usr/local/opt/openssl@1.1/include"
export PATH="$PATH:/usr/local/opt/openssl@1.1/lib/pkgconfig"
export PATH="$PATH:$HOME/bin/flipper"
export PATH="$PATH:$HOME/bin/"
export PATH="$PATH:$HOME/.local/bin"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

[[ -s "/home/annguyenwasd/.jabba/jabba.sh" ]] && source "/home/annguyenwasd/.jabba/jabba.sh"
#}}}

# {{{ Alias
alias p="pnpm"
alias ydl="youtube-dl -i"
alias lzd="lazydocker"
alias r="ranger"

alias md="mvn spring-boot:run -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005\" -Dspring-boot.run.profiles=local"
alias mc="mvn clean install -DskipTests=true"
alias mr="mvn spring-boot:run -Dspring-boot.run.profiles=local"
alias mcc="mvn clean install -DskipTests=true -s settings.xml;mvn spring-boot:run -Dspring-boot.run.profiles=local -s settings.xml"
alias mccc="mvn clean install -DskipTests=true;mvn spring-boot:run -Dspring-boot.run.profiles=local"
alias mt="mvn test"
alias mtd="mvn -Dmaven.surefire.debug -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005\" -Dspring-boot.run.profiles=local test"
alias pm=pulsemixer
alias xm="xmodmap $HOME/.Xmodmap"
# }}}

# {{{ Functions
function bb {
  echo "Backing up brew file"
  cd $DOTFILES/.non-stow/install/
  rm Brewfile
  brew bundle dump
  echo "Done!"
}

function bg() {
  feh --no-fehbg --recursive --full-screen --action "$HOME/.config/feh/set-bg.sh %F" $WORKSPACE_FOLDER/walls
}

function gif {
  echo "making gif $1"
  ffmpeg -i $1 -s 1366x768 -pix_fmt rgb24 -r 18 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
  echo "Done!"
}

function ws() {
  systemctl start warp-svc.service
  sleep 2
  warp-cli connect
}

function wss() {
  warp-cli disconnect
  systemctl stop warp-svc.service
}

function at() {
  local themes_dir=~/.config/alacritty/themes/themes
  local alacrity_import="$HOME/.config/alacritty/theme.toml"
  local theme_name=$(ls -1 $themes_dir|fzf)
  if [[ -n $theme_name ]]; then
    cp -f $themes_dir/$theme_name $alacrity_import
  fi
}

function get_tmux_bg(){
#!/bin/bash

   # Send escape sequence to query the background color
   printf '\033]11;?\007'

   # Read the response
   read -d $'\a' response

   # Extract the color value
   color=$(echo "$response" | sed -n 's/^.*:\(.*\)$/\1/p')

   echo "Background color: $color"
 }

function r1() {
  xrandr --output DP-0 --rotate left
 }

function r2() {
  xrandr --output DP-0 --rotate normal
 }

function r3() {
  xrandr --output DP-0 --rotate right
 }
# }}}
