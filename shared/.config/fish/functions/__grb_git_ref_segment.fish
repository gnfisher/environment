function __grb_git_ref_segment
    command -sq git; or return
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return

    set -l branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null); or return
    set -l ref
    if test "$branch" = main -o "$branch" = master
        set ref $branch
    else
        set ref (command git rev-parse --short HEAD 2>/dev/null); or return
    end

    if not command git diff --quiet --ignore-submodules -- 2>/dev/null
        set_color --bold red
    else if not command git diff --cached --quiet --ignore-submodules -- 2>/dev/null
        set_color --bold yellow
    else
        set_color --bold green
    end
    echo -n " $ref"
end
