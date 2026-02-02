# Dynamic terminal title for Ghostty/WezTerm tabs
function fish_title
    set -l dir (basename $PWD)
    if set -q CODESPACES
        echo "☁️ "(string split - $CODESPACE_NAME)[1]":$dir"
    else if set -q SSH_CONNECTION
        echo (hostname -s)":$dir"
    else
        echo $dir
    end
end
