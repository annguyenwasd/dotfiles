#!/bin/sh

echo "#!/bin/sh" > $DOTFILES/feh/.fehbg
echo "feh --no-fehbg --bg-fill '"$1"'" >> $DOTFILES/feh/.fehbg
hellwal -i "$1" &
~/.fehbg &
