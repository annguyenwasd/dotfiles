#!/bin/sh

fehbg="$HOME/.fehbg"
img_path="$1"

# Use sed to replace the path inside feh command
sed -i "s|img_path='.*'|img_path='$img_path'|" "$fehbg"
feh --no-fehbg --bg-fill "$img_path" # Run in on the fly :)
hellwal -i "$img_path"
