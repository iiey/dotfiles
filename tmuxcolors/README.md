### DESCRIPTION:
Themes are generated from vim plugin [tmuxline](https://github.com/edkolev/tmuxline.vim#usage).
See also section tmuxline in "vimrc"

#### NOTE:
These themes contain special characters so `powerline symbols font` needs to be installed:

```sh
sudo apt install fonts-powerline
```

#### INSTALL:
1. Copy these themes to `$HOME/.config/tmux/`
2. Add command in `.tmux.conf` and reload:

```sh
if-shell "test -f $HOME/.config/tmux/THEME_NAME" "source $HOME/.config/tmux/THEME_NAME"
```
