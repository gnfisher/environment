function fish_right_prompt
    if set -q CMD_DURATION; and test $CMD_DURATION -ge 5000
        set_color brblack
        printf '%ss' (math -s1 "$CMD_DURATION / 1000")
        set_color normal
    end
end
