typeset -U path PATH
path=(~/.local/bin $path)
export PATH

ZDOTDIR=$HOME/.config/zsh

if [[ -a "$HOME/.zshenvp" ]]; then
	source .zshenvp;
fi
