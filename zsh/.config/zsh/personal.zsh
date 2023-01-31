# fnm
export PATH="/home/annguyenwasd/.local/share/fnm:$PATH"
eval "`fnm env`"
eval "$(fnm env --use-on-cd)"

# {{{ Export
export DOTFILES=$HOME/dotfiles
export LC_CTYPE=en_US.UTF-8
export SPRING_OUTPUT_ANSI_ENABLED=ALWAYS
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/opt/ruby/bin"
export PATH="$PATH:/usr/local/opt/python/libexec/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH="$PATH:/usr/local/opt/openssl@1.1/bin"
export PATH="$PATH:-L/usr/local/opt/openssl@1.1/lib"
export PATH="$PATH:-I/usr/local/opt/openssl@1.1/include"
export PATH="$PATH:/usr/local/opt/openssl@1.1/lib/pkgconfig"
#}}}

# {{{ Alias
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
# }}}

# {{{ Functions
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

function s() {
 echo "Star syncing..."
 mv ~/Downloads/p.patch $DOTFILES/p.patch
 cd $DOTFILES
 git apply p.patch
 rm p.patch
 dd "Sync finished"
}
# }}}
