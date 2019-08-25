#!/bin/bash
#not use flag '-executable' of find because it's platform specific
#look at this two locations for scripts to run
list_script=$(find ~/.config/{,i3}/autostart/ -type f)
for script in $list_script; do
    [ -x $script ] && $script &
done
