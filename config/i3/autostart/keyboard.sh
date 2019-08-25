#!/bin/bash

sleep 1
#set keyboard layout and toggle key
exec_always setxkbmap -layout eu,de -option 'grp:alt_space_toggle'
#apply keys modification
#xmodmap ~/.Xmodmap
