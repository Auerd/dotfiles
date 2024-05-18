# source: https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
typeset -U path PATH
path=("$HOME/.local/bin" "$path")
export PATH

[[ -f $HOME/.zshenvp ]] && source "$HOME/.zshenvp"

export ZSH_CACHE_DIRECTORY=${XDG_CACHE_HOME:-$HOME/.cache}/zsh

export HISTFILE=$ZSH_CACHE_DIRECTORY/zhistory
export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export EDITOR=$PREFIX/bin/nvim
GPG_TTY="$(/bin/tty)" && export GPG_TTY

[[ -f $ZDOTDIR/.zshenvp ]] && source "$ZDOTDIR/.zshenvp"
