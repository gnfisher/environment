function fish_prompt
    set -l last_status $status

    set_color --background 73d0ff 1f2430
    printf ' %s ' (prompt_pwd)
    set_color --background normal 73d0ff
    printf ''

    set_color normal
    fish_git_prompt

    if test $last_status -ne 0
        set_color f28779
        printf ' [%d]' $last_status
        set_color normal
    end

    set_color dfbfff
    printf ' ❯ '
    set_color normal
end
