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
    # Load user completions
    if [[ -d ~/.local/share/bash-completion/completions ]]; then
        for f in ~/.local/share/bash-completion/completions/*; do
            [[ -f "$f" ]] && . "$f"
        done
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

# Homebrew (macOS/Linux) - cached shellenv for faster startup
__brew_bin=""
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    __brew_bin="/opt/homebrew/bin/brew"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    __brew_bin="/home/linuxbrew/.linuxbrew/bin/brew"
fi
if [[ -n "$__brew_bin" ]]; then
    __brew_cache="${HOME}/.cache/brew-shellenv.sh"
    [[ -d "${HOME}/.cache" ]] || mkdir -p "${HOME}/.cache"
    if [[ ! -s "$__brew_cache" || "$__brew_bin" -nt "$__brew_cache" ]]; then
        "$__brew_bin" shellenv > "$__brew_cache"
    fi
    . "$__brew_cache"
fi
unset __brew_bin __brew_cache

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

# FZF integration (lazy load)
if [[ -f ~/.fzf.bash ]]; then
    __fzf_lazy_loaded=0
    __fzf_lazy_load() {
        [[ $__fzf_lazy_loaded -eq 1 ]] && return
        __fzf_lazy_loaded=1
        source ~/.fzf.bash
    }
    fzf() { __fzf_lazy_load; command fzf "$@"; }
    fzf-tmux() { __fzf_lazy_load; command fzf-tmux "$@"; }
fi

# Prompt: full path + git branch
__git_prompt() {
    command -v git >/dev/null 2>&1 || return
    local branch dirty
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    if [[ "$branch" == "HEAD" ]]; then
        branch=$(git rev-parse --short HEAD 2>/dev/null) || return
    fi
    if ! git diff --quiet --ignore-submodules -- 2>/dev/null || \
       ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
        dirty="*"
    fi
    printf '[⎇ %s%s]' "$branch" "$dirty"
}

PS1='\[\e[1;36m\]\w'
PS1+='\[\e[90m\]$(__git_prompt)'
PS1+='\[\e[1;36m\]\$ \[\e[0m\]'

# Set terminal title to hostname when in SSH session (for WezTerm tab titles)
if [[ -n "$SSH_CONNECTION" ]]; then
    echo -ne "\033]0;$(hostname)\007"
fi

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
alias copilot='copilot --disable-builtin-mcp=github'

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
    __pnpm_cache="${HOME}/.cache/pnpm_home"
    [[ -d "${HOME}/.cache" ]] || mkdir -p "${HOME}/.cache"
    if [[ -s "$__pnpm_cache" ]]; then
        export PNPM_HOME="$(<"$__pnpm_cache")"
    else
        export PNPM_HOME="$(pnpm config get global-dir 2>/dev/null || echo "$HOME/.local/share/pnpm")"
        printf '%s' "$PNPM_HOME" > "$__pnpm_cache"
    fi
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi
unset __pnpm_cache

export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR" && -z "$(type -t nvm)" ]]; then
    __nvm_lazy_load() {
        unset -f nvm node npm npx __nvm_lazy_load
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    }
    nvm() { __nvm_lazy_load; nvm "$@"; }
    node() { __nvm_lazy_load; node "$@"; }
    npm() { __nvm_lazy_load; npm "$@"; }
    npx() { __nvm_lazy_load; npx "$@"; }
fi
