#!/bin/bash

set -e

echo "Welcome to the i3 installation!"

prompt_yes_no() {
    while true; do
        read -n1 -r -p "$1 (y/n): " yn
        echo
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        *) echo "Please answer yes or y, or no or n." ;;
        esac
    done
}

install_i3() {
    # install related packages
    if prompt_yes_no "1) Install i3 and related packages?"; then
        sudo apt update
        sudo apt install -y i3 clipit compton dunst feh scrot fonts-font-awesome i3-wm i3lock i3status suckless-tools
    fi

    # install i3-workspace-names-daemon
    # allow dynamically changing workspace names based on the currently focused window
    if prompt_yes_no "2) Install i3-workspace-names-daemon?"; then
        pip3 install --user i3-workspace-names-daemon
        echo "Make sure ~/.local/bin is in PATH!"
    fi

    # configure i3
    if prompt_yes_no "3) Configure i3?"; then
        PROJ_DIR=$(git rev-parse --show-toplevel)
        mkdir -p ~/.config/{i3,i3status,compton,dunst}
        ln -sfn "$PROJ_DIR"/config/i3/config ~/.config/i3/config
        ln -sfn "$PROJ_DIR"/config/i3/autostart.sh ~/.config/i3/autostart.sh
        ln -sfn "$PROJ_DIR"/config/i3status/config ~/.config/i3status/config
        ln -sfn "$PROJ_DIR"/config/compton/compton.conf ~/.config/compton/compton.conf
        ln -sfn "$PROJ_DIR"/config/dunst/dunstrc ~/.config/dunst/dunstrc
    fi

    # copy i3vol and i3exit scripts
    if prompt_yes_no "4) Copy i3vol and i3exit scripts to ~/.local/bin?"; then
        cp -a config/i3/i3vol ~/.local/bin/
        cp -a config/i3/i3exit ~/.local/bin/
    fi

    # configure for KDE compatibility
    if prompt_yes_no "5) Modify ~/.bashrc for KDE compatibility?"; then
        # shellcheck disable=SC2016
        echo '
### start i3-config
# Make i3 compatible with KDE applications
if [ "$DESKTOP_SESSION" = "i3" ]; then
    export XDG_CURRENT_DESKTOP=KDE
    export KDE_SESSION_VERSION=5
fi
### end i3-config
' >>~/.bashrc
    fi

    echo "Installation and configuration complete!"
    echo "Please review the following manual steps:"
    echo "1. Set appropriate screenshot destination."
    echo "2. Create autostart scripts in ~/.config/autostart or ~/.config/i3/autostart if needed."
    echo "3. Restart your session or run 'source ~/.bashrc' to apply changes."
    echo "4. Refer to https://i3wm.org/docs/userguide.html for more configuration options."
}

uninstall_i3() {
    echo "Starting i3 uninstallation process..."

    echo "Uninstalling i3 and related packages..."
    sudo apt remove -y i3 clipit compton dunst feh scrot i3-wm i3lock i3status suckless-tools
    sudo apt autoremove -y

    echo "Uninstalling i3-workspace-names-daemon..."
    pip3 uninstall -y i3-workspace-names-daemon

    echo "Removing i3 configuration files..."
    rm -vf ~/.config/i3/{config,autostart.sh}
    rm -vf ~/.config/i3status/config
    rm -vf ~/.config/compton/compton.conf
    rm -vf ~/.config/dunst/dunstrc

    echo "Removing i3vol and i3exit scripts..."
    rm -vf ~/.local/bin/i3{vol,exit}

    echo "Remove i3 config in ~/.bashrc"
    sed -i '/### start i3-config/,/### end i3-config/d' ~/.bashrc

    echo "Uninstallation complete!"
    echo "You may need to restart your session for all changes to take effect."
}

if [ "$1" = "-u" ]; then
    uninstall_i3
else
    install_i3
fi
