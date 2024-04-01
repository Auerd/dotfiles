typeset -U path PATH
path=(~/.local/bin $path)
export PATH

export ZDOTDIR=$HOME/.config/zsh

[[ -f "$HOME/.zshenvp" ]] && source .zshenvp
