# Environment variables (interactive-only)
status is-interactive; or return

# Local private environment variables; keep secrets out of stowed dotfiles.
set -l splunk_token_env "$HOME/.config/environment/splunk-token.fish"
if test -r "$splunk_token_env"
    source "$splunk_token_env"
end

set -l private_env "$HOME/.config/environment/private.fish"
if test -r "$private_env"
    source "$private_env"
end
