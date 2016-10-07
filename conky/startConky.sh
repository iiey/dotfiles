#!/bin/bash
process_num=$(ps -ef | grep conky | grep -v "grep" | wc -l)
if [ "$process_num" -gt 1 ]; then
    echo "Conky's already running"
else
    {
    conky --config=$HOME/sources/dotfiles/conky/conkyrc_default &
    conky --config=$HOME/sources/dotfiles/conky/conkyrc_wordclock &
    } &>/dev/null
    echo "Conkys started"
fi
