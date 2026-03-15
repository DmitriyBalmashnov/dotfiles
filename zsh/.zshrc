# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable vim mode
bindkey -v 
# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q' # Block cursor
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == "" ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q' # Beam cursor (line)
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle-keymap-select 'beam'
}
zle -N zle-line-init

# Language & Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Proxies
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''

# Paths
export PATH="$HOME/.local/bin/:$PATH"

# Load local settings from .zshrc.local
if [[ -a ~/.zshrc.local ]]; then 
    source ~/.zshrc.local
fi

# Rust / Cargo
. "$HOME/.cargo/env"

# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Standard aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# The "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY     # Don't overwrite, append
setopt SHARE_HISTORY      # Share history between different KiTTY windows
setopt HIST_IGNORE_DUPS   # Don't record same line twice
setopt HIST_IGNORE_SPACE  # Don't record lines starting with space

eval "$(starship init zsh)"
