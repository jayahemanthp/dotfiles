#
# ~/.bashrc
#
[[ $- != *i* ]] && return

# TOP — ble.sh early, don't attach yet
source /usr/share/blesh/ble.sh --attach=none

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias yay="paru"
alias ff="fastfetch --config /usr/share/fastfetch/presets/examples/27.jsonc"
alias fs="fastfetch --config /usr/share/fastfetch/presets/examples/28.jsonc"
alias pu="paru -Syu"
alias upmirr="sudo reflector --latest 5 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist"
alias moniright="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 \ --output HDMI-1 --mode 1920x1080 --pos 1920x0"
alias monileft="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1920x0 \ --output HDMI-1 --mode 1920x1080 --pos 0x0"
alias svim='sudo -E nvim'

# Fastfetch
ff

# History
shopt -s histappend
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth

# Bash completion
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# fzf
eval "$(fzf --bash)" 2>/dev/null

# Starship — append to PROMPT_COMMAND, don't overwrite
eval "$(starship init bash)"

# History saving — append after starship sets PROMPT_COMMAND
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a; history -n"

# BOTTOM — attach ble.sh after everything is set up
ble-attach
