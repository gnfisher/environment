# Fish completion for ws (Copilot worktree manager)

set -l commands new pr list open path pick title delete dd clean cs
set -l cs_commands bless status sync ssh repo ports forward web-ports web
set -l web_port_actions toggle start stop status

# Disable file completion by default
complete -c ws -f

# Commands
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "new" -d "Create named worktree"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "pr" -d "Create/reuse PR worktree"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "list" -d "List managed worktrees"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "open" -d "Change to worktree"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "path" -d "Print worktree path"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "pick" -d "Pick worktree with fzf"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "title" -d "Set terminal title for worktree"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "delete" -d "Delete managed worktree(s)"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "dd" -d "Delete current worktree and cd to base repo"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "clean" -d "Delete all worktrees for repo"
complete -c ws -f -n "not __fish_seen_subcommand_from $commands" -a "cs" -d "Manage blessed Codespace"

# list --all
complete -c ws -f -n "__fish_seen_subcommand_from list" -l all -d "List across all repos"
complete -c ws -f -n "__fish_seen_subcommand_from list" -l simple -d "Simple columns (default)"
complete -c ws -f -n "__fish_seen_subcommand_from list" -l full -d "Show all columns"
complete -c ws -f -n "__fish_seen_subcommand_from list" -l json -d "Output JSON"
complete -c ws -f -n "__fish_seen_subcommand_from list" -l format -a "text json" -d "Output format"

# new --pr / pr
complete -c ws -f -n "__fish_seen_subcommand_from new" -l pr -d "Create from PR number or URL"

# open/delete options
complete -c ws -f -n "__fish_seen_subcommand_from delete" -s f -l force -d "Delete dirty worktrees too"
complete -c ws -f -n "__fish_seen_subcommand_from delete" -s y -l yes -d "Skip multi-delete confirmation"
complete -c ws -f -n "__fish_seen_subcommand_from dd" -s f -l force -d "Delete dirty current worktree too"
complete -c ws -f -n "__fish_seen_subcommand_from cs; and __fish_seen_subcommand_from sync" -l force-remote -d "Discard dirty remote checkout"
complete -c ws -f -n "__fish_seen_subcommand_from cs; and __fish_seen_subcommand_from web-ports web" -l status -d "Show managed web port forwarding status"

# Worktree name completion for open (current repo)
function __ws_worktree_names
    set -l wt_base "$HOME/.copilot/copilot-worktrees"
    set -l url (git remote get-url origin 2>/dev/null); or begin
        printf '\tNo git repo detected\n'
        return
    end
    set url (string replace -r '\.git$' '' -- $url)

    set -l repo_name
    if string match -rq '^git@[^:]+:[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else if string match -rq '^https://[^/]+/[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else if string match -rq '^ssh://git@[^/]+/[^/]+/(?P<r>[^/]+)$' -- $url
        set repo_name $r
    else
        printf '\tCannot parse repo remote\n'
        return
    end

    set -l repo_dir "$wt_base/$repo_name"
    test -d "$repo_dir"; or begin
        printf '\tNo managed worktrees for repo\n'
        return
    end

    set -l found 0
    for gitfile in $repo_dir/*/.git $repo_dir/*/*/.git $repo_dir/*/*/runtime/.git
        test -f "$gitfile"; or continue
        set found 1
        set -l wt_dir (path dirname $gitfile)
        set -l rel (string replace -r "^$repo_dir/" "" -- $wt_dir)
        echo $rel
        echo (path basename $wt_dir)
    end
    test $found -eq 1; or printf '\tNo managed worktrees for repo\n'
end

# Worktree name completion for delete (all managed worktrees)
function __ws_worktree_names_all
    set -l wt_base "$HOME/.copilot/copilot-worktrees"
    test -d "$wt_base"; or begin
        printf '\tNo managed worktrees\n'
        return
    end

    set -l found 0
    for gitfile in $wt_base/*/*/.git $wt_base/*/*/*/.git $wt_base/*/*/*/runtime/.git
        test -f "$gitfile"; or continue
        set found 1
        set -l wt_dir (path dirname $gitfile)
        set -l rel (string replace -r "^$wt_base/" "" -- $wt_dir)
        set -l display (string replace -r "^[^/]+/" "" -- $rel)
        printf '%s\t%s\n' (path basename $wt_dir) $rel
        printf '%s\t%s\n' $display $rel
        printf '%s\t%s\n' $rel $rel
    end
    test $found -eq 1; or printf '\tNo managed worktrees\n'
end

function __ws_worktree_open_names_all
    set -l wt_base "$HOME/.copilot/copilot-worktrees"
    test -d "$wt_base"; or begin
        printf '\tNo managed worktrees\n'
        return
    end

    set -l found 0
    for gitfile in $wt_base/*/*/.git $wt_base/*/*/*/.git $wt_base/*/*/*/runtime/.git
        test -f "$gitfile"; or continue
        set found 1
        set -l wt_dir (path dirname $gitfile)
        set -l rel (string replace -r "^$wt_base/" "" -- $wt_dir)
        set -l repo (string split -m1 / -- $rel)[1]
        set -l display (string replace -r "^[^/]+/" "" -- $rel)
        printf '%s\t%s\n' $display $repo
        printf '%s\t%s\n' $rel $rel
        printf '%s\t%s\n' (path basename $wt_dir) $rel
    end
    test $found -eq 1; or printf '\tNo managed worktrees\n'
end

# Current repo PR suggestions from gh
function __ws_pr_numbers
    if not command -sq gh
        return
    end
    gh pr list --limit 50 --json number,title --jq '.[] | "\(.number)\t\(.title)"' 2>/dev/null
end

function __ws_codespace_names
    if not command -sq gh
        return
    end
    gh cs list --limit 100 --json name,displayName,state --jq '.[] | "\(.name)\t\(.displayName // .state // "")"' 2>/dev/null
end

complete -c ws -f -n "__fish_seen_subcommand_from pr" -a "(__ws_pr_numbers)"
complete -c ws -f -n "__fish_seen_subcommand_from new" -l pr -a "(__ws_pr_numbers)"
complete -c ws -f -n "__fish_seen_subcommand_from cs; and not __fish_seen_subcommand_from $cs_commands" -a "$cs_commands"
complete -c ws -f -n "__fish_seen_subcommand_from cs; and __fish_seen_subcommand_from bless" -a "(__ws_codespace_names)"
complete -c ws -f -n "__fish_seen_subcommand_from cs; and __fish_seen_subcommand_from web-ports web; and not __fish_seen_subcommand_from $web_port_actions" -a "$web_port_actions"

complete -c ws -f -n "__fish_seen_subcommand_from open" -a "(__ws_worktree_open_names_all)"
complete -c ws -f -n "__fish_seen_subcommand_from path" -a "(__ws_worktree_names)"
complete -c ws -f -n "__fish_seen_subcommand_from title" -a "(__ws_worktree_names)"
complete -c ws -f -n "__fish_seen_subcommand_from delete" -a "(__ws_worktree_names_all)"

# Keep compatibility for free-form args where completion is not enough
complete -c ws -n "__fish_seen_subcommand_from open" -f
complete -c ws -n "__fish_seen_subcommand_from path" -f
complete -c ws -n "__fish_seen_subcommand_from title" -f
complete -c ws -n "__fish_seen_subcommand_from delete" -f
complete -c ws -n "__fish_seen_subcommand_from new" -f
complete -c ws -n "__fish_seen_subcommand_from pr" -f
