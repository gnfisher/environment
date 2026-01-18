# Exit if not interactive
status is-interactive; or exit

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim

# PATH additions
test -d "$HOME/.local/bin"; and fish_add_path "$HOME/.local/bin"

# Homebrew (macOS)
if test -d "/opt/homebrew/bin"
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

# Go environment
if command -q go
    set -gx GOPATH "$HOME/go"
    fish_add_path "$GOPATH/bin"
    set -gx GOPROXY "https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
    set -gx GONOPROXY ""
    set -gx GONOSUMDB "github.com/github/*"
end

# GPG agent
if command -q gpgconf
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent 2>/dev/null
end

# FZF integration
if test -f ~/.config/fish/functions/fzf_key_bindings.fish
    source ~/.config/fish/functions/fzf_key_bindings.fish
end

# Colors for ls (macOS)
set -gx CLICOLOR 1
set -gx LSCOLORS ExFxCxDxBxegedabagacad

# Set terminal title to hostname when in SSH session (for WezTerm tab titles)
if set -q SSH_CONNECTION
    printf "\033]0;%s\007" (hostname)
end

# Aliases
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias rg='rg --hidden'
alias grep='grep --color=auto'

# Helpful
alias dots='cd ~/Development/gnfisher/environment/'
alias dev='cd ~/Development'

# bun
if test -d "$HOME/.bun"
    set -gx BUN_INSTALL "$HOME/.bun"
    fish_add_path "$BUN_INSTALL/bin"
end

# pnpm
if command -q pnpm
    set -gx PNPM_HOME (pnpm config get global-dir 2>/dev/null; or echo "$HOME/.local/share/pnpm")
    fish_add_path "$PNPM_HOME"
end

# NVM (using bass or nvm.fish if available)
set -gx NVM_DIR "$HOME/.nvm"
