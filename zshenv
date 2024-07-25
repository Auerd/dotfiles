export PATH="$HOME/.local/bin:$PATH"

# shellcheck source=/dev/null
[[ -f $HOME/.zshenvp ]] && source "$HOME/.zshenvp"

export ZSH_CACHE_DIRECTORY=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
export GOPATH=${XDG_CACHE_HOME:-$HOME/.cache}/go
export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export EDITOR=${PREFIX:-/usr}/bin/nvim
GPG_TTY="$("${PREFIX:-/usr}"/bin/tty)" && export GPG_TTY

# shellcheck source=/dev/null
[[ -f $ZDOTDIR/.zshenvp ]] && source "$ZDOTDIR/.zshenvp"
