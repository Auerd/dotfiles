autoload -Uz compinit promptinit add-zsh-hook 

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
  source "$ZDOTDIR/.prompt"; 
else 
  set_prompt 
  add-zsh-hook -Uz precmd set_prompt; 
fi 

if [[ -f $ZDOTDIR/.rprompt ]]; then 
  source "$ZDOTDIR/.rprompt"; 
else 
  RPROMPT=''; 
fi 



# Lock tty in timeout 
[[ $(tty) =~ /dev\/tty[1-6] ]] && TMOUT=180



# Aliases 
# source: https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command
DOTS_DIR=$(git -C "$ZDOTDIR" rev-parse --show-toplevel)
alias ls="ls --color=auto" 
alias la="ls -A"
alias ll="ls -lA"
alias grep="grep --color=auto"
alias yay="yay --sudoloop"
alias yayy="yay -Syu --noconfirm"
alias upg="yayy && sudo flatpak update -y"
alias dots="git -C \"$DOTS_DIR\""


# Commands
mkcdir()
{
  mkdir -p -- "$1" &&
    cd -P -- "$1" || return 1
}

GPG_TTY="$(/bin/tty)"
export GPG_TTY

# Plugins
source "$ZDOTDIR/plugins/antigen.zsh"

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
	git 
	command-not-found
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-autosuggestions
EOBUNDLES
antigen apply

ZSH_AUTOSUGGEST_STRATEGY=()



# Prevention of terminal break
function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal



# Autorehash for pacman
if [[ -x $(command -v pacman) ]]; then
	if ! [[ -e $PREFIX/var/cache/zsh/pacman ]] 
	then
    printf "Warning you've not enabled zsh pacman hook yet.\n
		Please, copy ~/.config/scripts/zsh.hook to current pacman's hooks directory"
	else
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

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
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



# Optional machine-dependent zsh configuration
[[ -f $ZDOTDIR/.zshrcp ]] && source "$ZDOTDIR/.zshrcp"
