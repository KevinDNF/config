#!/bin/sh

xrandr --output LVDS-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP-2 --off --output DP-1 --off --output HDMI-1 --off --output VGA-1 --mode 848x480 --pos 1366x0 --rotate normal

pkill polybar
sleep 1
compton -b
polybar example
feh --bg-fill ~/.config/wallpaper/wallpaper.jpg



