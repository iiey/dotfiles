#!/usr/bin/env bash
#Declare variables
_current=$(pwd -P)
_tmuxcolors="$HOME/.config/tmux"
_dotfiles=("ackrc" "agignore" "apparix_bash" "ctags" "inputrc" "fzf_cmd" "gitignore_global" "git_template" "gvimrc" "vimrc" "myrc" "tmux.conf")
case $OSTYPE in
  darwin*)
    _bashfile=$HOME/.bash_profile
    ;;
  *)
    _bashfile=$HOME/.bashrc
    ;;
esac

#Helper functions
#Show how to use this installer
function show_usage() {
  echo -e "Usage: $0 [argument] \n"
  echo "Arguments:"
  echo "--help (-h): display this help"
  echo "--install (-i): choose which configuration should be used"
  echo -e "--update (-u): update dotfiles \n"
  exit 0;
}

#Back up existing configuration and link new one to dotfiles
function link_file() {
    source=$1
    target=$2

    #create backup (overwrite last one)
    if [ -f "$HOME/$target" ]; then
        [ ! -d "$_current/backup" ] && mkdir -p $_current/backup
        cp -avL "$HOME/$target" $_current/backup/$source.bak
        echo "Backed up $_current/backup/$source.bak"
    fi

    ln -sfn "$_current/$source" "$HOME/$target" && echo "Created symlink: ~/$target@ --> $_current/$source"

    #rename gitignore
    [ "$source" == "gitignore_global" ] && mv $HOME/$2 $HOME/.gitignore
    #add extra configuration to bashrc
    if [ "$source" == "myrc" ] && ! $(grep -q "source.*$target" $_bashfile); then
        echo "[ -f ~/$target  ] && source ~/$target" >> $_bashfile
    fi
}

#copy tmux themes
function sync_themes() {
    if [ -n "$(type -t tmux)" ] && [ -d "$_tmuxcolors" ]; then
        echo -e "Copying themes to $_tmuxcolors...\n"
        rsync -aiu $_current/tmuxcolors/ $_tmuxcolors
    fi
}


#TODO setup.sh [package] just install specific stuff we need
#Parse parameter
[ $# -eq 0 ] && show_usage && exit 0
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
    for dotfile in ${_dotfiles[@]}; do
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

    #vim plugins will be installed through vimplug in vimrc
    #echo "*** Installing vim plugins..."

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
    unset resp

    read -e -n 1 -p "Update colorschemes? [y/N]: " resp
    case $resp in
        [yY])
            sync_themes;;
        [nN]|"")
            ;;
    esac
fi

#TODO uninstall
#remove source file
#pat="source.*myrc"; if grep "$pat" $_bashfile; then sed -i "/$pat/d" $_bashfile
