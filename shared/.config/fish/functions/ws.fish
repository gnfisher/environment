# ws - Git worktree manager (fish wrapper)
# Delegates to the bash ws script in ~/.local/bin/ws, except commands that
# resolve a worktree path should cd in the current shell.
function ws
    if test (count $argv) -ge 1
        switch $argv[1]
            case open
                if test (count $argv) -lt 2
                    command ws $argv
                    return $status
                end

                set -l path (command ws open $argv[2..-1])
                or return $status

                if test -d "$path"
                    cd "$path"
                else
                    echo "$path"
                    return 1
                end
                return

            case new pr pick
                set -lx WS_OPEN_MODE print
                set -l path (command ws $argv)
                or return $status

                if test -d "$path"
                    cd "$path"
                else
                    echo "$path"
                    return 1
                end
                return

            case dd
                set -l path (command ws $argv)
                or return $status

                if test -d "$path"
                    cd "$path"
                else
                    echo "$path"
                    return 1
                end
                return
        end
    end

    command ws $argv
end
