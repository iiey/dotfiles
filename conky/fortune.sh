#!/bin/bash
if type fortune > /dev/null 2>&1; then
    #display short fortune if personal dictionary not exists
    #place your dictionaries here or change dir path
    FILE=$HOME/sources/dict/fortunes
    [ -r "$FILE" ] && ARG="$FILE" || ARG="-s"
    #use tux figure if cowsay exists
    fortune "$ARG" | ( command -v cowsay > /dev/null 2>&1 && cowsay -f tux || cat )
fi
