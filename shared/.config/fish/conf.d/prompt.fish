# Prompt: full path + git branch
status is-interactive; or return
function __git_prompt
    set -l git_prompt (fish_git_prompt "%s")
    if test -n "$git_prompt"
        echo -n "[$git_prompt]"
    end
end

function fish_prompt
    set -l path (string replace -r "^$HOME" "~" (pwd))
    set_color --bold cyan
    echo -n $path
    set_color brblack
    echo -n (__git_prompt)
    set_color --bold cyan
    echo -n '$ '
    set_color normal
end
