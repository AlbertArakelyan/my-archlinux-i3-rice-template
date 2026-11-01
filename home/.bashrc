#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="${EDITOR:-nano}"

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend checkwinsize

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Catppuccin Mocha colors for ls / less / man
export LESS_TERMCAP_md=$'\e[1;38;2;203;166;247m'   # bold -> mauve
export LESS_TERMCAP_us=$'\e[4;38;2;137;220;235m'   # underline -> sky
export LESS_TERMCAP_so=$'\e[38;2;30;30;46;48;2;249;226;175m' # standout -> yellow bg
export LESS_TERMCAP_me=$'\e[0m' LESS_TERMCAP_ue=$'\e[0m' LESS_TERMCAP_se=$'\e[0m'
export GROFF_NO_SGR=1

# Fallback prompt if oh-my-posh is missing
PS1='[\u@\h \W]\$ '

# Oh My Posh prompt
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/catppuccin-mocha.omp.json)"
fi
