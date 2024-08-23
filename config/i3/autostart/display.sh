#!/bin/bash
#script to set monitors and wallpapers in i3 using feh
#first file will set on screen 0, second on screen1, and so on

#use only for i3wm session
[ "$DESKTOP_SESSION" != "i3" ] && exit

#1. arrange personal dual monitors appropriately
#num_monitors=$(xrandr --query | grep ' connected' | wc -l)
#xrandr --output DP-0 --primary --output DVI-D-0 --left-of DP-0

#2. setup background wallpapers
if  command -v feh >/dev/null 2>&1; then
    feh --bg-fill ~/Pictures/wallpapers/solarsystem.jpg \
                  ~/Pictures/wallpapers/planet.jpg
fi
