# Set terminal title to hostname when in SSH session (for WezTerm tab titles)
status is-interactive; or return
if set -q SSH_CONNECTION
    printf "\033]0;%s\007" (hostname)
end
