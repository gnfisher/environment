# Prefer fish_user_paths for persistent path additions
status is-interactive; or return
if test -d "$HOME/.local/bin"
    fish_add_path -m "$HOME/.local/bin"
end
if test -d "$HOME/.bun"
    set -gx BUN_INSTALL "$HOME/.bun"
    fish_add_path -m "$BUN_INSTALL/bin"
end
if command -q go
    set -gx GOPATH "$HOME/go"
    fish_add_path -m "$GOPATH/bin"
end
