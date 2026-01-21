# Homebrew (macOS/Linux) - cached shellenv for faster startup
status is-interactive; or return
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
