# Prompt defined in conf.d/prompt.fish
# This file intentionally left minimal to avoid conflicts.
function fish_prompt
    set -l host (hostname -s)
    set -l dir (basename (pwd))
    if test (pwd) = $HOME
        set dir "~"
    end

    set_color --bold
    echo -n "$host:$dir"
    __grb_git_prompt
    echo -n " $USER\$ "
    set_color normal
end
