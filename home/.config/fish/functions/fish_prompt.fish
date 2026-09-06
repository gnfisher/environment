function __environment_theme_refresh
    set -l theme_file $HOME/.local/state/environment-theme/fish.fish
    if test -r $theme_file
        source $theme_file
        return
    end

    set -g __environment_theme_path_background 454758
    set -g __environment_theme_path_foreground ffffff
    set -g __environment_theme_git_background ae8fe7
    set -g __environment_theme_git_foreground 494d64
    set -g __environment_theme_accent dfbfff
    set -g __environment_theme_error f28779
    set -g __environment_theme_muted 707a8c
    set -g __fish_git_prompt_color_branch ae8fe7
    set -g __fish_git_prompt_color_dirtystate f28779
    set -g __fish_git_prompt_color_untrackedfiles f28779
end

function fish_prompt
    set -l last_status $status
    __environment_theme_refresh

    set_color --background $__environment_theme_path_background $__environment_theme_path_foreground
    printf ' %s ' (prompt_pwd)

    set -l git_prompt (fish_git_prompt '%s')
    if test -n "$git_prompt"
        set git_prompt (string replace -ra '\e\[[0-9;]*m' '' -- $git_prompt)

        set_color --background $__environment_theme_git_background $__environment_theme_path_background
        printf ''
        set_color --background $__environment_theme_git_background $__environment_theme_git_foreground
        printf ' %s ' $git_prompt
        set_color --background normal $__environment_theme_git_background
        printf ''
    else
        set_color --background normal $__environment_theme_path_background
        printf ''
    end

    if test $last_status -ne 0
        set_color $__environment_theme_error
        printf ' [%d]' $last_status
        set_color normal
    end

    set_color $__environment_theme_accent
    printf ' ❯ '
    set_color normal
end
