# Fish completion for ws (Copilot worktree manager)

set -l commands new pr list open delete clean

# Disable file completion by default
complete -c ws -f

# Commands
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "new" -d "Create named worktree + tmux session"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "pr" -d "Create/reuse PR worktree"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "list" -d "List managed worktrees"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "open" -d "Open worktree tmux session"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "delete" -d "Delete managed worktree"
complete -c ws -n "not __fish_seen_subcommand_from $commands" -a "clean" -d "Delete all worktrees for repo"

# list --all
complete -c ws -n "__fish_seen_subcommand_from list" -l all -d "List across all repos"
complete -c ws -n "__fish_seen_subcommand_from list" -l simple -d "Simple columns (default)"
complete -c ws -n "__fish_seen_subcommand_from list" -l full -d "Show all columns"
complete -c ws -n "__fish_seen_subcommand_from list" -l json -d "Output JSON"
complete -c ws -n "__fish_seen_subcommand_from list" -l format -a "text json" -d "Output format"

# new --pr / pr
complete -c ws -n "__fish_seen_subcommand_from new" -l pr -d "Create from PR number or URL"

# Worktree name completion for open (current repo)
function __ws_worktree_names
    set -l wt_base "$HOME/.copilot/copilot-worktrees"
    set -l url (git remote get-url origin 2>/dev/null); or return
    set url (string replace -r '\.git$' '' -- $url)

    set -l repo_name
    if string match -rq '^git@[^:]+:[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else if string match -rq '^https://[^/]+/[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else if string match -rq '^ssh://git@[^/]+/[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else
        return
    end

    set -l repo_dir "$wt_base/$repo_name"
    test -d "$repo_dir"; or return

    for gitfile in (find $repo_dir -mindepth 1 -maxdepth 3 -type f -name .git 2>/dev/null)
        set -l wt_dir (dirname $gitfile)
        set -l rel (string replace -r "^$repo_dir/" "" -- $wt_dir)
        echo $rel
        echo (basename $wt_dir)
    end
end

# Worktree name completion for delete (all managed worktrees)
function __ws_worktree_names_all
    set -l wt_base "$HOME/.copilot/copilot-worktrees"
    test -d "$wt_base"; or return

    for gitfile in (find $wt_base -mindepth 2 -maxdepth 5 -type f -name .git 2>/dev/null)
        set -l wt_dir (dirname $gitfile)
        set -l rel (string replace -r "^$wt_base/" "" -- $wt_dir)
        printf '%s\t%s\n' (basename $wt_dir) $rel
        printf '%s\t%s\n' $rel $rel
    end
end

# Current repo PR suggestions from gh
function __ws_pr_numbers
    if not command -sq gh
        return
    end
    gh pr list --limit 50 --json number,title --jq '.[] | "\(.number)\t\(.title)"' 2>/dev/null
end

complete -c ws -n "__fish_seen_subcommand_from pr" -a "(__ws_pr_numbers)"
complete -c ws -n "__fish_seen_subcommand_from new" -l pr -a "(__ws_pr_numbers)"

complete -c ws -n "__fish_seen_subcommand_from open" -a "(__ws_worktree_names)"
complete -c ws -n "__fish_seen_subcommand_from delete" -a "(__ws_worktree_names_all)"

# Keep compatibility for free-form args where completion is not enough
complete -c ws -n "__fish_seen_subcommand_from open" -f
complete -c ws -n "__fish_seen_subcommand_from delete" -f
complete -c ws -n "__fish_seen_subcommand_from new" -f
complete -c ws -n "__fish_seen_subcommand_from pr" -f
