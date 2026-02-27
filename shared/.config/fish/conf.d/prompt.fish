status is-interactive; or return

function __grb_git_prompt
    command -sq git; or return
    set -l branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null); or return
    if test "$branch" = HEAD
        set branch (command git rev-parse --short HEAD 2>/dev/null); or return
    end

    set -l now (date +%s)
    set -l last (command git log --pretty=format:'%at' -1 2>/dev/null); or return
    set -l mins (math "($now - $last) / 60")

    echo -n "($branch|"
    if test $mins -gt 30
        set_color red
    else if test $mins -gt 10
        set_color yellow
    else
        set_color green
    end
    echo -n "$mins"m
    set_color normal
    echo -n ")"
end

function fish_prompt
    set -l host (hostname -s)
    set -l dir (basename (pwd))
    if test (pwd) = $HOME
        set dir "~"
    end

    echo -n "$host:$dir"
    __grb_git_prompt
    echo -n " $USER\$ "
end
