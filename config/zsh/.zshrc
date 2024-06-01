#!/usr/bin/bash
# sources: 
#   https://wiki.archlinux.org/title/Zsh
#   https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command
autoload -Uz compinit promptinit add-zsh-hook 

if ! [[ -d $ZSH_CACHE_DIRECTORY ]]; then
  [[ -e "$ZSH_CACHE_DIRECTORY" ]] && rm "$ZSH_CACHE_DIRECTORY";
  mkdir "$ZSH_CACHE_DIRECTORY";
fi

compinit -d "$ZSH_CACHE_DIRECTORY/zcompdump-$ZSH_VERSION" 

promptinit 

zstyle ':completion::complete:*' gain-privileges 1 

WHOAMI=$(whoami)

#Prompt 
set_prompt(){ 
  PROMPT='%F{green}%2~%f %(!.#.$) '
  USER_HOST='%F{blue}%n@%m%f' 
  (( COLUMNS-${#HOST}-${#WHOAMI} >= "76" )) && PROMPT="$USER_HOST $PROMPT" 
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



# Lock tty in timeout 
[[ $(tty) =~ /dev\/tty[1-6] ]] && TMOUT=180



# Aliases 
# source: https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command
alias ls="ls --color=auto" 
alias la="ls -A"
alias ll="ls -lA"
alias grep="grep --color=auto"
alias yay="yay --sudoloop"
alias yayy="time yay -Syu --noconfirm"
if command -v git &> /dev/null; then
  DOTS=$(git -C "$ZDOTDIR" rev-parse --show-toplevel)
  alias dots="git -C \"\$DOTS\""
fi


# Commands
mkcdir()
{
  mkdir -p -- "$1" &&
    cd -P -- "$1" || return 1
}




# Plugins

dir=${PREFIX:-/usr}/share/zsh/shareo
if ! [ -f "$dir/antigen.zsh" ]; then
  dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh
  if ! [ -f "$dir/antigen.zsh" ]; then
    echo "Installing antigen.zsh plugin to XDG_DATA_HOME directory." 
    echo "$(tput bold)Warning!$(tput sgr0) This procedure will be executed only once!"
    echo "If you want to update antigen.zsh regulary, then install it via your package manager"
    mkdir -p "$dir"
    if command -v curl &> /dev/null; then
      curl -sL git.io/antigen > "$dir/antigen.zsh"
    elif command -v wget &> /dev/null; then
      wget -qO git.io/antigen > "$dir/antigen.zsh"
    else
      echo "Please install antigen plugin, curl or wget from your package manager"
      dir="" 
    fi
  fi
fi

if [ -n "$dir" ]; then
# shellcheck source=/dev/null
  source "$dir/antigen.zsh"
  antigen use oh-my-zsh
  antigen bundles <<EOBUNDLES
    git 
    command-not-found
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
EOBUNDLES
  antigen apply
fi

export ZSH_AUTOSUGGEST_STRATEGY=()



# Prevention of terminal break
function reset_broken_terminal () {
  printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal



# Autorehash for pacman
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



# Keybinding
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

if ((${+terminfo[smkx]} && ${+terminfo[rmkx]})); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx; }
  function zle_application_mode_stop { echoti rmkx; }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



# Clear terminal
function clear-screen-and-scrollback() {
  printf '\x1Bc'
  zle clear-screen
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback




# Options
setopt autopushd
setopt correct

# Correction setup
export CORRECT_IGNORE="[_|.]*"
export TIMEFMT="%U user %S system %P cpu %*E total"


# Optional machine-dependent zsh configuration
# shellcheck source=/dev/null
[[ -f $ZDOTDIR/.zshrcp ]] && source "$ZDOTDIR/.zshrcp"
