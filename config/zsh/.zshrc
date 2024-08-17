#!/usr/bin/bash
# vim:fileencoding=utf-8:foldmethod=marker
# sources {{{
#   https://wiki.archlinux.org/title/Zsh
#   https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command}}}
autoload -Uz compinit promptinit add-zsh-hook 

if ! [[ -d $ZSH_CACHE_DIRECTORY ]]; then
  [[ -e "$ZSH_CACHE_DIRECTORY" ]] && rm "$ZSH_CACHE_DIRECTORY";
  mkdir -p "$ZSH_CACHE_DIRECTORY";
fi

compinit -d "$ZSH_CACHE_DIRECTORY/zcompdump-$ZSH_VERSION" 

promptinit 

zstyle ':completion::complete:*' gain-privileges 1 

# History {{{
HISTFILE=$ZSH_CACHE_DIRECTORY/zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
# }}}

# Prompt {{{
WHOAMI=$(whoami)

set_prompt(){ 
  PROMPT='%F{green}%2~%f %(!.#.$) '
  USER_HOST='%F{blue}%n@%m%f' 
  (( COLUMNS-${#HOST}-${#WHOAMI} > "76" )) && PROMPT="$USER_HOST $PROMPT" 
} 

if [[ -f $ZDOTDIR/.prompt ]]; then 
# shellcheck source=/dev/null
  source "$ZDOTDIR/.prompt"; 
else 
  set_prompt 
  add-zsh-hook -Uz precmd set_prompt; 
fi 

if [[ -f $ZDOTDIR/.rprompt ]]; then 
# shellcheck source=/dev/null
  source "$ZDOTDIR/.rprompt"; 
else 
  export RPROMPT=''; 
fi 
# }}}

# Lock tty in timeout 
[[ $(tty) =~ /dev\/tty[1-6] ]] && TMOUT=180

# Aliases {{{
# source: https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command
alias ls="ls --color=auto" 
alias la="ls -A"
alias ll="ls -lA"
alias grep="grep --color=auto"
alias yay="time yay --sudoloop"
alias yayy="yay -Syu --noconfirm"
# sshd in Termux can't listen on 22
# Instead it usually listens 8022
alias sshm="ssh -p 8022"
alias moshm="mosh --ssh='ssh -p 8022'"
# Change owner of file to parent's one
alias chownasp="chown --recursive --reference=.."
if command -v git &> /dev/null &&\
  git -C "$ZDOTDIR" rev-parse
then
  DOTS=$(git -C "$ZDOTDIR" rev-parse --show-toplevel)
  alias dots="git -C \"\$DOTS\""
fi
#}}}

# Commands {{{
mkcdir()
{
  mkdir -p -- "$1" &&
    cd -P -- "$1" || return 1
}
#}}}

# Plugins {{{
pluginsdir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
linkstosrc=(\
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/command-not-found/command-not-found.plugin.zsh \
)
repostosrc=(\
  zsh-users/zsh-syntax-highlighting \
)

# install-repo script {{{
install-repo() {(
  local tmpdir="$PREFIX/tmp/zsh"
  local branch="master"
  
  function usage {
    cat <<EOF
usage: install-repo [-huz] [-t <tempdir>] [-b <branch>] <repo> <worktree>
description: installs repository to <worktree> from https://github.com/<repo>
options:
  -h print this message and exit 0
  -b use branch instead of $branch
  -u update repository if it already exist
  -t use tempdir instead of $tmpdir as temporary directory
  -z install archive instead of cloning git repository
EOF
  }
  
  set -e
  while getopts "b:ht:uz" opt; do
    case "$opt" in
      b) branch="$OPTARG";;
      h) usage; return 0;;
      t) tmpdir="$OPTARG";;
      u) update="true";;
      z) nogit="true";;
      *) usage >&2; return 1;;
    esac
  done
  shift $(( OPTIND - 1 ))
  
  if [[ -z $1 ]] || [[ -z $2 ]]; then
    usage >&2; return 1
  fi
  
  local repo=$1
  local worktree=$2

  local url="https://github.com/$repo"
  local masterarchv="$url/archive/refs/heads/$branch.zip"
  [[ -z $update ]] && [[ -e "$worktree" ]]\
    && echo "Repository $repo was installed" && return 0
  mkdir -p "$tmpdir" 
  mkdir -p "$worktree"
  if command -v git &>/dev/null && [[ -z $nogit ]]; then
    if [[ -z $update ]] || [[ ! -e "$worktree" ]]; then
      git clone --depth=1 "$url" "$worktree"
    else
      git -C "$worktree" pull origin "$branch"
    fi
    return 0
  else
    echo "Trying to get archive from $url..."
    if command -v curl &>/dev/null; then
      curl -# -o "$tmpdir/$branch.zip" -L "$masterarchv"
    elif command -v wget &>/dev/null; then
      wget -O "$tmpdir/$branch.zip" "$masterarchv"
    else
      echo "Neither git, nor wget, nor curl were found. Install one of it"
      return 1
    fi
    echo "Unpacking zip archive..."
    unzip "$tmpdir/$branch.zip" -d "$(dirname "$worktree")" 1>/dev/null
    rm -rf "$worktree"
    mv "$worktree-$branch" "$worktree" 
    return 0
  fi
)}
# }}}

# Install if needed and source {{{
mkdir -p "$pluginsdir"
for link in "${linkstosrc[@]}"; do
  filename=${link##*/}
  filepath="$pluginsdir/$filename"
  if [[ ! -e "$filepath" ]]; then
    if command -v curl &>/dev/null; then
      echo "Getting $filename..."
      curl -# -o "$filepath" -L "$link" || continue
    elif command -v wget &>/dev/null; then
      echo "Getting $filename..."
      wget -O "$filepath" "$link" || continue
    else
      echo "Neither curl nor wget were found. Please install one"
      break
    fi
  fi
  #shellcheck source=/dev/null
  source "$filepath"
done
if \
  command -v git &>/dev/null || \
  command -v curl &>/dev/null || \
  command -v wget &>/dev/null
then
  for repo in "${repostosrc[@]}"; do
    repopath="$pluginsdir/$repo"
    setopt +o nomatch
    if ! ls -d "$repopath"/*.plugin.zsh &>/dev/null; then
      install-repo "$repo" "$repopath" || continue
    fi
    for file in "$repopath"/*.plugin.zsh; do
    #shellcheck source=/dev/null
      source "$file"
    done
  done
else
  echo "Neither git, not curl, nor wget were found. Please install one"
fi
# }}}

# upgrade-plugins script {{{
function upgrade-plugins {
  echo "Trying to get files..."
  for link in "${linkstosrc[@]}"; do
    filename=${link##*/}
    filepath="$pluginsdir/$filename"
    if command -v curl &>/dev/null; then
      echo "Getting $filename..."
      curl -# -o "$filepath" -L "$link"
    elif command -v wget &>/dev/null; then
      echo "Getting $filename..."
      wget -O "$filepath" "$link"
    else
      echo "Neither curl nor wget were found. Please install one"
      return 1
    fi
  done
  if \
    command -v git &>/dev/null || \
    command -v curl &>/dev/null || \
    command -v wget &>/dev/null
  then
    for repo in "${repostosrc[@]}"; do
      repopath="$pluginsdir/$repo"
      install-repo -u "$repo" "$repopath" || continue
    done
  else
    echo "Neither git, not curl, nor wget were found. Please install one"
  fi
  echo "Done! Now start a new shell"
}
# }}}
# }}}

# Prevention of terminal break {{{
function reset_broken_terminal () {
  printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal
# }}}

# Autorehash for pacman {{{
# source: https://wiki.archlinux.org/title/Zsh#On-demand_rehash
if command -v pacman &> /dev/null; then
  if [[ -e $PREFIX/var/cache/zsh/pacman ]] 
  then
    zshcache_time="$(date +%s%N)"
    
    rehash_precmd() {
      local paccache_time
      paccache_time="$(date -r "$PREFIX/var/cache/zsh/pacman" +%s%N)"
      if (( zshcache_time < paccache_time )); then
        rehash
        zshcache_time="$paccache_time"
      fi
    }
    
    add-zsh-hook -Uz precmd rehash_precmd
  fi
fi
# }}}

# Keybinding {{{
# source: https://wiki.archlinux.org/title/Zsh#Key_bindings
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# No, do not format it
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"          beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"           end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"        overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"     backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"        delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"            up-line-or-history
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"          down-line-or-history
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"          backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"         forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"        beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"      end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"     reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# You fall in grace, shfmt
# I don't know how to disable formatting for either code fragment or file with editorconfig
# Tried all but nothing got
# Is this problem with conform?
if ((${+terminfo[smkx]} && ${+terminfo[rmkx]})); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx; }
  function zle_application_mode_stop { echoti rmkx; }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
# }}}

# Clear terminal {{{
function clear-screen-and-scrollback() {
  printf '\x1Bc'
  zle clear-screen
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback
# }}}

# Options {{{
setopt autopushd
setopt correct
export CORRECT_IGNORE="[_|.]*"
export TIMEFMT="
user %U
system %S
total %E(%*E)
cpu %P"
# }}}

# Optional machine-dependent zsh configuration {{{
# shellcheck source=/dev/null
[[ -f $ZDOTDIR/.zshrcp ]] && source "$ZDOTDIR/.zshrcp"
#  }}}
