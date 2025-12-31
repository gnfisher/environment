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

# Tab completion settings
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'  # Shift-Tab to go backwards
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

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

# Ripgrep with hidden files but respect gitignore
alias rg='rg --hidden'

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

# Color codes
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

# Git-aware prompt with colors
git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo $branch
}

# Function to get git SHA without colors
git_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

# Function to set prompt dynamically
set_prompt() {
    local git_info=""
    local sha
    sha=$(git_sha)

    if [[ -n "$sha" ]]; then
        git_info="${WHITE}(${RED}${sha}${WHITE})${RESET}"
    fi

    PS1="${GREEN}\u@\h${RESET} ${YELLOW}\$PWD${RESET}\$ "
}

# Set PROMPT_COMMAND to update prompt before each command
PROMPT_COMMAND=set_prompt

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'

# Helpful
alias dots='cd ~/Development/gnfisher/environment/'
alias dev='cd ~/Development'
# alias copilot='copilot --allow-all-tools'

# cd with ls
cd() {
    builtin cd "${@:-$HOME}" && ls
}

# Clone git repo into ~/Development/$org/$repo
gh-clone() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: gh-clone <git-repo-url>"
        echo "Examples:"
        echo "  gh-clone git@github.com:user/repo.git"
        echo "  gh-clone https://github.com/user/repo.git"
        return 1
    fi

    local repo_url="$1"
    local repo_path
    local org
    local repo_name

    # Extract org/repo from SSH format: git@github.com:org/repo.git
    if [[ "$repo_url" =~ ^git@[^:]+:([^/]+)/([^/]+)(\.git)?$ ]]; then
        org="${BASH_REMATCH[1]}"
        repo_name="${BASH_REMATCH[2]}"
        # Remove .git suffix if present
        repo_name="${repo_name%.git}"
    # Extract org/repo from HTTPS format: https://github.com/org/repo.git
    elif [[ "$repo_url" =~ ^https://[^/]+/([^/]+)/([^/]+)(\.git)?$ ]]; then
        org="${BASH_REMATCH[1]}"
        repo_name="${BASH_REMATCH[2]}"
        # Remove .git suffix if present
        repo_name="${repo_name%.git}"
    else
        echo "Error: Unable to parse repository URL format"
        echo "Supported formats:"
        echo "  SSH: git@github.com:org/repo.git"
        echo "  HTTPS: https://github.com/org/repo.git"
        return 1
    fi

    repo_path="$HOME/Development/$org/$repo_name"

    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$repo_path")"

    # Clone the repository
    echo "Cloning $repo_url into $repo_path"
    if git clone "$repo_url" "$repo_path"; then
        echo "Successfully cloned to $repo_path"
        cd "$repo_path"
    else
        echo "Failed to clone repository"
        return 1
    fi
}

# bun
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# pnpm
if command -v pnpm >/dev/null 2>&1; then
    export PNPM_HOME="$(pnpm config get global-dir 2>/dev/null || echo "$HOME/.local/share/pnpm")"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi

export NVM_DIR="$HOME/.nvm"
if [[ -e "$NVM_DIR/nvm.sh" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
