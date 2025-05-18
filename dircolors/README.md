### Quick Start

dircolors belongs to essential packet `coreutils`. For more details see the [documentation](https://www.gnu.org/software/coreutils/manual/html_node/dircolors-invocation.html).

dircolors themes can be installed for all application that respect the `LS_COLORS` environment variable like GNU core utils

Default using [solarized theme](https://github.com/seebi/dircolors-solarized) `dircolors.ansi-universal`.  See also [nord theme](https://github.com/arcticicestudio/nord-dircolors)

##### Create symlink

Create symlink file to `~/.dircolors` in home directory:

```sh
ln -sfn dircolors/dircolors.ansi-universal ~/.dircolors
```

#### Activation

To use certain theme as default color for all sessions, load the theme with `dircolors` by adding the following snippet to `~/.bashrc`:

```sh
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
```
