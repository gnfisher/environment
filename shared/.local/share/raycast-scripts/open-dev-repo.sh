#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Dev Repo
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📁
# @raycast.packageName Workspaces
# @raycast.argument1 { "type": "text", "placeholder": "repo or owner/repo" }

# Documentation:
# @raycast.description Open a local ~/Development repo in Ghostty
# @raycast.author gnfisher

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=/dev/null
source "$script_dir/.raycast-lib.sh"

query="$1"
dev_root="${HOME}/Development"

if [[ "$query" == */* ]]; then
    candidate="${dev_root}/${query}"
    if [[ -d "$candidate/.git" || -d "$candidate" ]]; then
        open_ghostty "$candidate" "$query"
        echo "Opened: $candidate"
        exit 0
    fi
fi

matches=()
while IFS= read -r path; do
    matches+=("$path")
done < <(find "$dev_root" -mindepth 2 -maxdepth 2 -type d -name "$query" 2>/dev/null | sort)

case "${#matches[@]}" in
    0)
        echo "No repo matched: $query"
        exit 1
        ;;
    1)
        path="${matches[0]}"
        title="${path#${dev_root}/}"
        open_ghostty "$path" "$title"
        echo "Opened: $path"
        ;;
    *)
        echo "Multiple repos matched:"
        printf '  %s\n' "${matches[@]#${dev_root}/}"
        exit 1
        ;;
esac
