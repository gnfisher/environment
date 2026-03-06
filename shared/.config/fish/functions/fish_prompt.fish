# Prompt defined in conf.d/prompt.fish
# This file intentionally left minimal to avoid conflicts.
function fish_prompt
    set -l dir (basename (pwd))
    if test (pwd) = $HOME
        set dir "~"
    end

    set_color --bold
    echo -n "$dir"
    __grb_git_ref_segment
    set_color --bold
    echo -n "\$ "
    set_color normal
end
