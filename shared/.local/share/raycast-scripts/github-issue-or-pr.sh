#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Issue or PR
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔎
# @raycast.packageName GitHub
# @raycast.argument1 { "type": "text", "placeholder": "owner/repo or repo" }
# @raycast.argument2 { "type": "text", "placeholder": "number" }

# Documentation:
# @raycast.description Open a GitHub issue or pull request by number
# @raycast.author gnfisher

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=/dev/null
source "$script_dir/.raycast-lib.sh"

repo=$(repo_slug "$1")
number="$2"

if [[ ! "$number" =~ ^[0-9]+$ ]]; then
    echo "Issue/PR number must be numeric." >&2
    exit 1
fi

open_url "https://github.com/${repo}/issues/${number}"
