function fish_right_prompt
    __environment_theme_refresh

    if set -q CMD_DURATION; and test $CMD_DURATION -ge 5000
        set_color $__environment_theme_muted
        printf '%ss  ' (math -s1 "$CMD_DURATION / 1000")
    end

    set_color $__environment_theme_accent
    date '+%a %b %d %H:%M:%S %z'
    set_color normal
end
