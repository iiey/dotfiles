#!/usr/bin/env bash

#Declare variables
CURRENT=$(pwd -P)
TMUXCOLORS="$HOME/.config/tmux"
VIMCOLORS="$HOME/.vim/colors"
DOTFILES=("ackrc" "apparix_bash" "ctags" "inputrc" "gitignore_global" "git_template" "gvimrc" "vimrc" "myrc" "tmux.conf")
case $OSTYPE in
  darwin*)
    BASH_FILE=$HOME/.bash_profile
    ;;
  *)
    BASH_FILE=$HOME/.bashrc
    ;;
esac

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
    SOURCE=$1
    TARGET=$2
    [ -f "$HOME/$TARGET" ] && cp -avL "$HOME/$TARGET" $CURRENT/backup/$SOURCE.bak
    ln -sfn "$CURRENT/$SOURCE" "$HOME/$TARGET" && echo "Created symlink: ~/$TARGET@ --> $CURRENT/$SOURCE"
    #TODO source .myrc in bash_file
}

#copy vim colorschemes and tmux themes
function sync_themes() {
    echo -e "Copying colorschemes to $VIMCOLORS...\n"
    [ ! -d "$VIMCOLORS" ] && mkdir -p "$VIMCOLORS"
    rsync -aiu $CURRENT/vimcolors/ $VIMCOLORS

    if [ -n "$(type -t tmux)" ] && [ -d "$TMUXCOLORS" ]; then
        echo -e "Copying themes to $TMUXCOLORS...\n"
        rsync -aiu $CURRENT/tmuxcolors/ $TMUXCOLORS
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
  ?) show_usage; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)


#Install
if [ $install ]; then
    echo "*** Installing dotfiles..."
    for dotfile in ${DOTFILES[@]}; do
        read -e -n 1 -p "Would you like to setup $dotfile? [y/N/q]: " resp
        case $resp in
            [yY])
                link_file $dotfile .$dotfile;;
            [nN]|"")
                continue;;
            [qQ])
                break;;
        esac
    done
    unset resp

    #TODO interate through basic, extended and enhanced modules
    #TODO specify plugin to download
    echo "*** Installing vim plugins..."
    read -e -n 1 -p "Would you like to get vimplugins submodules? [y/N]: " resp
    case $resp in
        [yY])
            git submodule init && git submodule update --remote;;
            #TODO check vim version, link to bundle or pack
        [nN]|"")
            ;;
    esac

    echo "*** Installing themes..."
    sync_themes

    #TODO add conky, dircolors
    echo "*** Installation finished!"
fi

#Update
if [ $update ]; then
    read -e -n 1 -p "Update dotfiles? [Y/n]: " resp
    case $resp in
        [yY]|"")
            git pull;;
        [nN])
            ;;
    esac

    #TODO update only previously installed submodules
    read -e -n 1 -p "Update submodules? [y/N]: " resp
    case $resp in
        [yY])
            git submodule init && git submodule update --remote;;
        [nN]|"")
            ;;
    esac
fi

#TODO uninstall
#TODO option to remove certain vimplugin submodule
