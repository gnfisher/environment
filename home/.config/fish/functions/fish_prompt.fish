function fish_prompt
    set -l last_status $status
    set -l path_background 454758
    set -l git_background AE8FE7
    set -l git_foreground 494D64

    set_color --background $path_background FFFFFF
    printf ' %s ' (prompt_pwd)

    set -l git_prompt (fish_git_prompt '%s')
    if test -n "$git_prompt"
        set git_prompt (string replace -ra '\e\[[0-9;]*m' '' -- $git_prompt)

        set_color --background $git_background $path_background
        printf ''
        set_color --background $git_background $git_foreground
        printf ' %s ' $git_prompt
        set_color --background normal $git_background
        printf ''
    else
        set_color --background normal $path_background
        printf ''
    end

    if test $last_status -ne 0
        set_color f28779
        printf ' [%d]' $last_status
        set_color normal
    end

    set_color dfbfff
    printf ' ❯ '
    set_color normal
end
