### Install
* Use default *Ubuntu* package:
```sh
sudo apt install i3
#others utils
sudo apt install clipit compton dunst feh scrot fonts-font-awesome
#just in case other tools (i3status, dmenu,..) not auto installed
sudo apt install i3-wm i3lock i3status suckless-tools
```
* OR install latest stable release from [repository](https://i3wm.org/docs/repositories.html)
* Update workspace icon dynamically [link](https://github.com/cboddy/i3-workspace-names-daemon)
```sh
pip3 install --user i3-workspace-names-daemon
ln -sfn ~/.local/bin/i3-workspace-names-daemon ~/bin/i3-workspace-names-daemon
```
* Tools:
    * `clipit` clipboard manager (cmdline and gui mode)
    * `compton` a x11 compositor (transparent effects)
    * `dunst` minimal desktop notification for i3
    * `feh` display wallpapers
    * `font-awesome` various icons for programs, tools
    * `scrot` take screenshot

### Config
* Symlink i3 directory or individual files to default config filepaths
```sh
#make sure $PWD ist current git project root directory
ln -sfn $PWD/config/i3/config ~/.config/i3/config
ln -sfn $PWD/config/i3/autostart.sh ~/.config/i3/autostart.sh
ln -sfn $PWD/config/i3status/config ~/.config/i3status/config
mkdir ~/.config/{compton,dunst} && {
    ln -sfn $PWD/config/compton/compton.conf ~/.config/compton/compton.conf
    ln -sfn $PWD/onfig/dunst/dunstrc ~/.config/dunst/dunstrc
}
```

* **Autostart**
    * By start of session our i3 config looks for and loads executable scripts under `~/.config/autostart`
and `~/.config/i3/autostart`. So just create scripts there to auto run daemons or personal stuffs
    * Script example [display.sh](autostart/display.sh): *arrange monitors* and *setup wallpapers* for my dual monitors
* Put `i3vol` (volume adjustment) and `i3exit` (for lock, logout, reboot, shutdown) to *$PATH* to able for calling it from i3
```sh
cp -a config/i3/i3vol ~/bin/
cp -a config/i3/i3exit ~/bin/
```
* Set approriate screenshot destination if neccessary
* Problems with KDE
    * No icons for some applications respectively incorrect colorscheme e.g. dolphin
    * `xdg-open` not work, workaround add in `~/.bashrc`
```sh
if [ "$DESKTOP_SESSION" = "i3" ]; then
    export XDG_CURRENT_DESKTOP=KDE
    export KDE_SESSION_VERSION=5
fi
```
* Others:
    * [userguide](https://i3wm.org/docs/userguide.html#_configuring_i3bar)
    * quick setup [link article](https://geekoverdose.wordpress.com/2017/02/05/i3-window-manager-setup-and-configuration/)
