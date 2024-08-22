# [conky](https://github.com/brndnmtthws/conky)

A minimal system monitor for X.

## prerequisites
* `fortune.sh` requires `fortune` and `cowsay` to be installed and a fortune database file:
```sh
git clone https://gist.github.com/iiey/44766203a8981510f9c32e9cb613f119 ~/src/fortunes
# see README.md for details
```

Could be commented out in `conkyrc_default` if not needed.

* `weather.sh` needs a location code for AccuWeather API.
  Search for your code here: [accuWeatherCode](https://gist.github.com/iiey/a2c4c7f4e9fe3d5a822211f06f6aeef2)
  Commented out if not needed.

* `conky_default` show GPU information, which requires `nvidia-smi` or `rocm-smi` to be installed.
  Commented both out or use one depnding on your GPU.

## installation

Copy this directory to `~/.config/` and create a symlink  of conkyrc_default to `~/.config/conky/conky.conf`:
```bash
rsync -avz conky ~/.config/
ln -s ~/.config/conky/conkyrc_default ~/.config/conky/conky.conf

# start
# if no config argument '-c' is provided, conky will look for ~/.config/conky/conky.conf
conky --quiet &
```

## configuration
* Description about [config settings](https://conky.sourceforge.net/config_settings.html)
* Explain [basic window config](https://github.com/brndnmtthws/conky/wiki/Window-Configuration)

### network interface

- This setting can be used for traditional naming convention: `eth0, eth1..`, etc
    - Old linux distribution names them based on the order they were detected by the system
    - Issue: in system with multiple inets, they can be changed between reboots
```lua
# simple setting
${color grey}IP:$color ${addr eth0}
${color grey}Up:$color ${upspeed eth0} ${color grey} - Down:$color ${downspeed eth0}
```

- Predictable network interface names, e.g. `enp0s3, enp0s8..`
    - `en` for ethernet, `wl` for wireless, `lo` for loopback,..
    - `pX` for PCI bus number X
    - `sY` for slot number Y
```lua
# dynamic setting to find out the active network interface
# 1. find out the one network interface used to reach public address '1.1.1.1' (additional awk syntax to eliminate linebreak of output)
# 2. get the IP address of this active interface
${color grey}Interface:$color ${exec ip route get 1.1.1.1 | awk 'BEGIN {ORS="";} {print $5}'}
${color grey}IP:$color ${exec ip addr show $(ip route get 1.1.1.1 | awk '{print $5}') | grep 'inet ' | awk '{print $2}' | cut -d/ -f1}
${color grey}Up:$color ${upspeed $(ip route get 1.1.1.1 | awk '{print $5}')} ${color grey} - Down:$color ${downspeed $(ip route get 1.1.1.1 | awk '{print $5}')}
```

### `own_window_type`
* See description in config settings
* TLDR: use `normal` for gnome and `override` for i3 to make conky window not floating on the foreground
