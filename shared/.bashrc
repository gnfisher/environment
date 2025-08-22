# Exit if not interactive
[[ $- != *i* ]] && return

# History settings
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s histappend
shopt -s checkwinsize

# Enable programmable completion
if ! shopt -oq posix; then
    # Try Homebrew first (handles both Intel and Apple Silicon)
    if [[ -n "$HOMEBREW_PREFIX" && -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
        . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# Colors for ls and grep
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    # macOS
    alias ls='ls -G'
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad
fi

# Environment variables
export EDITOR=nvim
export VISUAL=nvim

# PATH additions
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# Homebrew (macOS)
if [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Go environment
if command -v go >/dev/null 2>&1; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
    export GOPROXY="https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
    export GONOPROXY=""
    export GONOSUMDB="github.com/github/*"
fi

# GPG agent
if command -v gpgconf >/dev/null 2>&1; then
    export GPG_TTY=$(tty)
    gpgconf --launch gpg-agent 2>/dev/null
fi

# FZF integration
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Git-aware prompt with colors
git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo "($branch)"
}

# Color codes
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
WHITE='\[\033[0;37m\]'
RESET='\[\033[0m\]'

# Set prompt
PS1="\n${RESET}❯❯❯ ${CYAN}\h${RESET}:${BLUE}\W${RESET}${YELLOW}\$(git_branch)${RESET}\n\$ "

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias o='opencode'
alias lg='lazygit'

# Git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gch='git checkout'
alias gp='git push origin'
alias gr='git pull --rebase origin'
alias gs='git status'

# Helpful
alias dots="cd ~/Development/gnfisher/environment/"

# cd with ls
cd() {
    builtin cd "${@:-$HOME}" && ls
}

# GitHub Codespaces helper (if gh cli is available)
if command -v gh >/dev/null 2>&1; then
    gh-cs() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: gh-cs <codespace-name>"
            return 1
        fi
        gh codespace ssh --codespace "$1"
    }

    # Bash completion for gh-cs
    _gh_cs_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local codespaces=$(gh cs ls --json name -q '.[].name' 2>/dev/null)
        COMPREPLY=($(compgen -W "${codespaces}" -- "${cur}"))
    }
    complete -F _gh_cs_completion gh-cs
fi
