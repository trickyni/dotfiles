case $- in
*i*) ;;
*) return ;;
esac

#   bash history stuff
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s extglob
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alertrm "$1" && echo "Removed file: $1"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#--------------
#   completion stuff

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# case-insensitive completion
bind -s 'set completion-ignore-case on' >/dev/null
#--------------

echo -e -n "\x1b[\x35 q" # changes to blinking bar

#   paths
export PATH="$HOME/.cargo/bin:$PATH"
#
#   pager
export MANPAGER='nvim +Man!'
export PAGER=less
export LESS="-R"

#   editor
export EDITOR=nvim
alias e='${EDITOR:-vim}'

#   file manager
export XDG_FILE_MANAGER=nemo

#   eza
export EZA_ICONS_AUTO=always
alias ls='eza -1 --group-directories-first'
alias ll='eza -laohb --no-time --no-permissions --group-directories-first'

#   FZF
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/fzf-config
eval "$(fzf --bash)"

#   starship
eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

#   homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
alias homescum='homeshick cd dotfiles && git add . && git commit -m "0" && git push && echo -e "\033[93mhome successfully scummed\033[0m"'
alias hometrack='homeshick track dotfiles'

#   zoxide
eval "$(zoxide init bash)"

#   taskwarrior completions
source ~/.task/task_completions.sh
alias t='task'
alias tt='task pri.not:x'

#   yazi
alias y='yazi'
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" || exit
  rm -f -- "$tmp"
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# -------------------------------------------------------------------------------------------
# Eternal bash history.
# https://stackoverflow.com/a/19533853
#export HISTFILESIZE=
#export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# wayland
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export ELECTRON_OZONE_PLATFORM_HINT=x11
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export ELECTRON_OZONE_PLATFORM_HINT=wayland
alias obsidian='obsidian --ozone-platform=wayland'

#----ALIASES
#   core
alias bk='cd ..'
alias reload='source ~/.bashrc && echo "ka-clunk~"'
alias bashr='e ~/.bashrc'
alias rm='rm -i'
alias untar='sudo tar -xvzf'

#   security
alias lockdown='rfkill block all'
alias lockdown-lift='sudo rfkill unblock all'

#   renames/config loads
alias nmtui='NEWT_COLORS=$(<~/.config/nmtui/desert-witch.theme) nmtui'
alias dust='dust -r'
alias quickshell='swaymsg exec quickshell'
alias enkidu='ncdu --color off'
alias grep='grep --color=auto'
alias cat='bat --theme "ansi" --style="header,grid"'
alias rsync='rsync --info=progress2'
#   Arch linux
if grep arch /etc/os-release >/dev/null; then
  alias invoke='sudo pacman -S'
  alias banish='sudo pacman -R'
  alias commune='sudo pacman -Syu'
fi

#   docker
alias whale='sudo docker compose'
alias whaleup='sudo docker compose up -d'
alias whaledown='sudo docker compose down'
alias whaleseesaw='sudo docker compose down && sudo docker compose up -d'

#   git
alias gitscum='git add . && git commit -m "0" && git push && echo -e "\033[93mgit successfully scummed\033[0m"'

#   yt-dlp
alias ytdlp='yt-dlp \
-f "best[height<=1080]"  \
-o "~/Downloads/[%(upload_date>%Y-%m-%d)s] %(title)s - %(uploader)s"  \
--embed-metadata --embed-chapters --no-write-info-json --embed-thumbnail \
--sponsorblock-remove sponsor --sponsorblock-mark selfpromo,interaction \
--cookies-from-browser firefox \
--remote-components ejs:github'

alias ytmp3='yt-dlp \
-f ba \
--extract-audio --audio-format flac --audio-quality 0 \
-o "~/Downloads/%(uploader)s - %(title)s" \
--embed-metadata --embed-chapters --no-write-info-json --embed-thumbnail \
--cookies-from-browser firefox'

alias lavat='lavat -s 7 -c blue -k yellow'

alias termdown='termdown -f doh'

alias meiscan="scanimage --device 'hpaio:/net/hp_laserjet_m1536dnf_mfp?ip=192.168.0.9&queue=false' --format=png --resolution 300 --mode Color -p -o"

function timer() {
  termdown "$1"
  notify-send -w "Timer" "${2:-BEEP}" &
}
