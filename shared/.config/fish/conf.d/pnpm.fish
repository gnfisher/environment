# pnpm (cached)
status is-interactive; or return
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
