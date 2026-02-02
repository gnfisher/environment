# Prompt: full path + git branch
function __git_prompt
    command -sq git; or return
    set -l branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null); or return
    if test "$branch" = "HEAD"
        set branch (command git rev-parse --short HEAD 2>/dev/null); or return
    end
    set -l dirty ""
    if not command git diff --quiet --ignore-submodules -- 2>/dev/null; or not command git diff --cached --quiet --ignore-submodules -- 2>/dev/null
        set dirty "*"
    end
    echo -n "[⎇ $branch$dirty]"
end

function fish_prompt
    set -l path (string replace -r "^$HOME" "~" (pwd))
    # Orangeish-red path color (works in dark and light themes)
    set_color --bold ff8700
    echo -n $path
    set_color 626262
    echo -n (__git_prompt)
    set_color --bold ff8700
    echo -n '$ '
    set_color normal
end
