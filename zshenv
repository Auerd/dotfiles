typeset -U path PATH
path=("$HOME/.local/bin" "$path")
export PATH


[[ -f $HOME/.zshenvp ]] && source "$HOME/.zshenvp";

export ZSH_CACHE_DIRECTORY=$HOME/.cache/zsh
[[ -n $XDG_CACHE_HOME ]] && export ZSH_CACHE_DIRECTORY=$XDG_CACHE_HOME/zsh;

if ! [[ -d $ZSH_CACHE_DIRECTORY ]]; then
  [[ -a "$ZSH_CACHE_DIRECTORY" ]] && rm "$ZSH_CACHE_DIRECTORY";
  mkdir "$ZSH_CACHE_DIRECTORY";
fi

export HISTFILE=$ZSH_CACHE_DIRECTORY/zhistory
export ZDOTDIR=$HOME/.config/zsh
[[ -n $XDG_CONFIG_HOME ]] && export ZDOTDIR=$XDG_CONFIG_HOME/zsh;
export EDITOR=$PREFIX/bin/nvim
export GPG_TTY="$(tty)"

[[ -f $ZDOTDIR/.zshenvp ]] && source "$ZDOTDIR/.zshenvp";
