#!/usr/bin/env bash

#Helper functions
#Show how to use this installer
function show_usage() {
  echo -e "Usage: $0 [argument] \n"
  echo "Arguments:"
  echo "--help (-h): display this help message"
  echo "--install (-i): choose which configuration should be used"
  echo -e "--update (-u): update dotfiles \n"
  exit 0;
}

#Back up existing configuration and link new one to dotfiles
function link_file() {
    if [ -w "$HOME/.$1" ]; then
        #TODO unlink if symlink
        #TODO source .myrc in bash_file
        cp -aL "$HOME/.$1" "$HOME/.$1.bak" && echo "Moved original: .$1 --> .$1.bak"
        ln -sfn "$CURRENT/$1" "$HOME/.$1" && echo "Created symlink: ~/.$1@ --> $CURRENT/$S1"
    else
        echo "$HOME/.$1 is not writeable" && exit 1;
    fi 
}


#Parse parameter
for param in "$@"; do
  shift
  case "$param" in
    "--help")       set -- "$@" "-h" ;;
    "--install")    set -- "$@" "-i" ;;
    "--update")     set -- "$@" "-n" ;;
    *)              set -- "$@" "$param"
  esac
done

OPTIND=1
while getopts "hiu" opt; do
  case "$opt" in
  h) show_usage; exit 0 ;;
  i) install=true ;;
  u) update=true ;;
  ?) show_usage >&2; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)


#Init Info
CURRENT=$(pwd -P)
DOTFILES=("ackrc" "apparix_bash" "bashrc" "ctags" "gvimrc" "inputrc" "myrc" "tmux.conf" "vimrc")
case $OSTYPE in
  darwin*)
    BASH_FILE=$HOME/.bash_profile
    ;;
  *)
    BASH_FILE=$HOME/.bashrc
    ;;
esac


#Install
if $install; then
    echo "Installing dotfiles..."
    for dotfile in DOTFILES; do
        read -e -n 1 -r -p "Would you like to setup $dotfile? [y/N]" resp
        case $resp in
            [yY])
                link_file $dotfile;;
            [nN]|"")
                break;;
        esac
    done

    #TODO interate through basic, extended and enhanced modules
    echo "Installing vim plugins..."
    read -e -n 1 -r -p "Would you like to get vimplugins submodules? [y/N]" resp
    case $resp in
        [yY])
            git submodule init && git submodule update --remote;;
        [nN]|"")
            break;;
    esac

    echo "Installing vim colorschemes..."
    vimcolors="$HOME/.vim/colors"
    [ ! -d "$vimcolors" ] && mkdir -p "$vimcolors"
    rsync -avz $CURRENT/vimcolors/ $vimcolors

    echo "Installing tmux colorschemes..."
    [ -n "$(type -t tmux)" ] && rsync -avz $CURRENT/tmuxcolors/ $HOME/.config/tmux

    #TODO add conky, dircolors, git-hooks
fi

#Update
if $update; then
    echo "Updating dotfiles..."
    git pull
    #TODO update only previously installed submodules
    echo "Updating submodules..."
    git submodule init && git submodule update --remote
fi

#TODO uninstall
#TODO option to remove certain vimplugin submodule
