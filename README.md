## Auerd's dotfiles
### Why (does this exist)?

I work on multiple linux systems (including Android) and often try new. That's why I need:
* **Syncronization**
* **Bootstrapping**
* **Saving**

That's what this repo and scripts in it do

### What (does it contain)?
Currently I have saved configurations of:
* [neovim](https://github.com/neovim/neovim)
* [i3wm](https://github.com/i3/i3)
* [kitty](https://github.com/kovidgoyal/kitty)
* [alacritty](https://github.com/alacritty/alacritty)
* [zsh](https://github.com/zsh-users/zsh)
* [polybar](https://github.com/polybar/polybar)
* [rofi](https://github.com/davatorium/rofi)
* [termux](https://github.com/termux/termux-app)

### How (to use this)?
By design you can copy every folder and use it. For example, if you copy `config/alacritty` folder to your [`$XDG_CONFIG_HOME`](https://specifications.freedesktop.org/basedir-spec/latest/index.html#variables) it shall work. However, some applications, for instance zsh, cannot be moved (`$HOME/.zshenv` and `$ZDOTDIR`). 

More traditional way is bootstrap. It just links all files to right places in you `$HOME` directory. Thankfully to it you can receive updates with one command
Script understands XDG specification and saves set XDG userspace variables to separate `.zshenvp` file. The variables shall be set in next zsh instances.

Before you run startup script you may also want to install needed fonts system-wide. The only font you need is [JetBrainsMono NF](https://github.com/ryanoasis/nerd-fonts).
Anyway script will offer to download fonts for user, if needed aren't found. Installation without needed fonts is discouraged.

Commands you need to execute in *nix:
```bash
$ cd
$ git clone --depth 1 https://github.com/Auerd/dotfiles
$ dotfiles/setup/user/main
```

> [!NOTE]
> $ means there you must run command after it as regular non-root user
>
> Do not paste this character

Same but inline:
```bash
cd && git clone --depth 1 https://github.com/Auerd/dotfiles && dotfiles/setup/user/main
```
Try to install `zsh` package and run:
```
$ zsh
```
It will start to install plugins
You may also want to change default shell to zsh. Install `shadow` package by you package manager, if needed, and run:
```
$ chsh -s /bin/zsh
```
