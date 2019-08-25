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
* Symlink/Copy configuration file to default config filepath
```sh
ln -sfn config/i3/config ~/.config/i3/config
ln -sfn config/i3status/config ~/.config/i3status/config
mkdir ~/.config/compton && cp -a config/compton/compton.conf ~/.config/compton/compton.conf
mkdir ~/.config/dunst && cp -a ~/config/dunst/dunstrc ~/.config/dunst/dunstrc
```
* Put `i3exit` (for lock, logout, reboot, shutdown)  script to *PATH* to able for calling it from i3
```sh
cp -a config/i3/i3exit ~/bin/
```
* Set wallpapers with approriate filepaths
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
