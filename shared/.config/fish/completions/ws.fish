# Fish completion for ws (worktree manager)

set -l commands new list switch delete sync
set -l repos github sweagentd copilot-mission-control copilot-api

# Disable file completion by default
complete -c ws -f

# Commands
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "new" -d "Create worktree + draft PR"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "list" -d "List worktrees"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "switch" -d "Show worktree path"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "delete" -d "Remove worktree"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "sync" -d "Rebase worktree on main"

# Repo completion for commands that need it
complete -c ws -n "__fish_seen_subcommand_from new switch delete sync; and __fish_is_token_n 3" -a "$repos"
complete -c ws -n "__fish_seen_subcommand_from list; and __fish_is_token_n 3" -a "$repos"

# Worktree name completion (dynamic based on repo)
function __ws_worktree_names
    set -l repo (commandline -opc)[3]
    set -l wt_dir "/workspaces/worktrees/$repo"
    if test -d "$wt_dir"
        ls -1 "$wt_dir" 2>/dev/null
    end
end

complete -c ws -n "__fish_seen_subcommand_from switch delete sync; and __fish_is_token_n 4" -a "(__ws_worktree_names)"
