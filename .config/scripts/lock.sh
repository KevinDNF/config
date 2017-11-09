#! bin/bash

scrot 'lock.png' -e 'mv $f ~/.config/wallpaper/'
convert ~/.config/wallpaper/lock.png -blur 30 ~/.config/wallpaper/lock.png

i3lock -t -e -i ~/.config/wallpaper/lock.png

rm -r ~/.config/wallpaper/lock.png
