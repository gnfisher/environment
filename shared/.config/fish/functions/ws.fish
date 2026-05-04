# ws - Git worktree manager (fish wrapper)
# Delegates to the bash ws script in ~/.local/bin/ws, except open needs to cd.
function ws
    if test (count $argv) -ge 2; and test "$argv[1]" = open
        set -l path (command ws open $argv[2..-1])
        or return $status

        if test -d "$path"
            cd "$path"
        else
            echo "$path"
            return 1
        end
        return
    end

    command ws $argv
end
