# Fish completion for ws (worktree manager)

set -l commands new list open delete clean

# Disable file completion by default
complete -c ws -f

# Commands
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "new" -d "Create worktree + tmux session"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "list" -d "List worktrees"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "open" -d "Open worktree tmux session"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "delete" -d "Remove worktree"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "clean" -d "Remove all worktrees"

# list --all
complete -c ws -n "__fish_seen_subcommand_from list" -l all -d "List across all repos"

# new --pr
complete -c ws -n "__fish_seen_subcommand_from new" -l pr -d "Create from PR URL"

# Worktree name completion for open (current repo)
function __ws_worktree_names
    set -l wt_base "$HOME/.worktrees"
    set -l url (git remote get-url origin 2>/dev/null); or return
    set url (string replace -r '\.git$' '' -- $url)
    set -l org_repo
    if string match -rq '^git@[^:]+:(?P<m>[^/]+/[^/]+)$' -- $url
        set org_repo $m
    else if string match -rq '^https://[^/]+/(?P<m>[^/]+/[^/]+)$' -- $url
        set org_repo $m
    else
        return
    end
    set -l wt_dir "$wt_base/$org_repo"
    test -d "$wt_dir"; or return
    for d in $wt_dir/*/
        basename $d
    end
end

# Worktree name completion for delete (all repos, with repo description)
function __ws_worktree_names_all
    set -l wt_base "$HOME/.worktrees"
    test -d "$wt_base"; or return
    for org_dir in $wt_base/*/
        set -l org (basename $org_dir)
        for repo_dir in $org_dir/*/
            set -l repo (basename $repo_dir)
            for wt_dir in $repo_dir/*/
                printf '%s\t%s/%s\n' (basename $wt_dir) $org $repo
            end
        end
    end
end

complete -c ws -n "__fish_seen_subcommand_from open" -a "(__ws_worktree_names)"
complete -c ws -n "__fish_seen_subcommand_from delete" -a "(__ws_worktree_names_all)"
