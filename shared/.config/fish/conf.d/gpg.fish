# GPG agent
status is-interactive; or return
if command -q gpgconf
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent 2>/dev/null
end
