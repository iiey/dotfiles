#!/bin/bash

# set an initial value
FORCE=false
CONKY_DIR=$HOME/sources/dotfiles/conky

# read the options, exit if parsing error
# 'p' or 'path' has required arg
# 'f' or 'force' has no arg, acting as flag.
OPTS=$(getopt -o p:f --long path:,force -n 'startConky.sh' -- "$@") || exit 1
eval set -- "$OPTS"

while true ; do
    case "$1" in
        -p|--path)
            case "$2" in
                    "")     shift 2 ;;
                    *)      CONKY_DIR=$2;               shift 2 ;;
            esac ;;
        -f|--force)         FORCE=true;                 shift ;;
        --)                 shift;                      break ;;
        *)                  echo "Internal error!" ;    exit 1 ;;
    esac
done

if $FORCE; then killall conky; fi

if [ "$(pgrep -c conky)" -gt 1 ]; then
    echo "conky's already running"
else
    #in case one still alive
    killall conky >/dev/null 2>&1
    conky --config="$CONKY_DIR"/conkyrc_default --daemonize --quiet &&
    conky --config="$CONKY_DIR"/conkyrc_wordclock --daemonize --quiet &&
    echo "conkys started"
fi
