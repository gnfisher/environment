# Exit if not interactive
status is-interactive; or exit

# Disable greeting
set -g fish_greeting

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim

# PATH additions
test -d "$HOME/.local/bin"; and fish_add_path "$HOME/.local/bin"

# Homebrew (macOS/Linux) - cached shellenv for faster startup
set -l brew_bin
if test -x "/opt/homebrew/bin/brew"
    set brew_bin "/opt/homebrew/bin/brew"
else if test -x "/home/linuxbrew/.linuxbrew/bin/brew"
    set brew_bin "/home/linuxbrew/.linuxbrew/bin/brew"
end
if test -n "$brew_bin"
    set -l brew_cache "$HOME/.cache/brew-shellenv.fish"
    if not test -d "$HOME/.cache"
        mkdir -p "$HOME/.cache"
    end
    if not test -s "$brew_cache"; or test "$brew_bin" -nt "$brew_cache"
        $brew_bin shellenv | source
        $brew_bin shellenv > "$brew_cache"
    else
        source "$brew_cache"
    end
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

# FZF integration (lazy load)
if test -f ~/.config/fish/functions/fzf_key_bindings.fish
    set -g __fzf_lazy_loaded 0
    function __fzf_lazy_load
        if test $__fzf_lazy_loaded -eq 1
            return
        end
        set -g __fzf_lazy_loaded 1
        source ~/.config/fish/functions/fzf_key_bindings.fish
    end
    function fzf
        __fzf_lazy_load
        command fzf $argv
    end
    function fzf-tmux
        __fzf_lazy_load
        command fzf-tmux $argv
    end
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
    set -l pnpm_cache "$HOME/.cache/pnpm_home.fish"
    if not test -d "$HOME/.cache"
        mkdir -p "$HOME/.cache"
    end
    if test -s "$pnpm_cache"
        set -gx PNPM_HOME (cat "$pnpm_cache")
    else
        set -gx PNPM_HOME (pnpm config get global-dir 2>/dev/null; or echo "$HOME/.local/share/pnpm")
        printf '%s' "$PNPM_HOME" > "$pnpm_cache"
    end
    fish_add_path "$PNPM_HOME"
end

# NVM (lazy load)
set -gx NVM_DIR "$HOME/.nvm"
if test -d "$NVM_DIR"
    function __nvm_load --description "Lazy-load nvm"
        functions -e __nvm_load
        if test -f "$NVM_DIR/nvm.sh"
            bash "$NVM_DIR/nvm.sh" --no-use >/dev/null 2>&1
        end
    end
    function nvm
        __nvm_load
        command nvm $argv
    end
    function node
        __nvm_load
        command node $argv
    end
    function npm
        __nvm_load
        command npm $argv
    end
    function npx
        __nvm_load
        command npx $argv
    end
end
