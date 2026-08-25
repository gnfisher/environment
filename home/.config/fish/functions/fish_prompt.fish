function fish_prompt
    set -l last_status $status

    set_color --bold brblue
    printf '%s' (prompt_pwd)
    set_color normal
    fish_git_prompt

    if test $last_status -ne 0
        set_color brred
        printf ' [%d]' $last_status
        set_color normal
    end

    printf '\n'
    set_color --bold brgreen
    printf '> '
    set_color normal
end
