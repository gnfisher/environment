function fish_right_prompt
    if set -q CMD_DURATION; and test $CMD_DURATION -ge 5000
        set_color 707a8c
        printf '%ss  ' (math -s1 "$CMD_DURATION / 1000")
    end

    set_color dfbfff
    date '+%a %b %d %H:%M:%S %z'
    set_color normal
end
