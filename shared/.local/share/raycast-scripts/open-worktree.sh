#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Worktree
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌲
# @raycast.packageName Workspaces
# @raycast.argument1 { "type": "text", "placeholder": "repo, branch, worktree, or path" }

# Documentation:
# @raycast.description Open a managed worktree in Ghostty by fuzzy text match
# @raycast.author gnfisher

set -euo pipefail

query="$1"
ws="${HOME}/.local/bin/ws"

if [[ ! -x "$ws" ]]; then
    echo "ws not found at $ws" >&2
    exit 1
fi
if ! command -v jq >/dev/null 2>&1; then
    echo "jq is required." >&2
    exit 1
fi

matches=$(
    "$ws" list --all --full --json \
        | jq -r --arg q "$query" '
            .[]
            | select(
                (.repo | ascii_downcase | contains($q | ascii_downcase))
                or (.name | ascii_downcase | contains($q | ascii_downcase))
                or (.branch | ascii_downcase | contains($q | ascii_downcase))
                or (.path | ascii_downcase | contains($q | ascii_downcase))
            )
            | [.repo, .name, .branch, .path]
            | @tsv
        '
)

count=$(printf '%s\n' "$matches" | sed '/^$/d' | wc -l | tr -d ' ')
case "$count" in
    0)
        echo "No worktree matched: $query"
        exit 1
        ;;
    1)
        path=$(printf '%s\n' "$matches" | cut -f4)
        "$ws" open "$path"
        echo "Opened: $path"
        ;;
    *)
        echo "Multiple worktrees matched:"
        printf '%s\n' "$matches" | awk -F'\t' '{ printf "  %s\t%s\t%s\n", $1, $2, $3 }'
        exit 1
        ;;
esac
