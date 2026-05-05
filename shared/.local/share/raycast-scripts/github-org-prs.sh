#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Org PRs
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧭
# @raycast.packageName GitHub
# @raycast.argument1 { "type": "text", "placeholder": "search terms", "optional": true }

# Documentation:
# @raycast.description Open GitHub PR search scoped to the github org
# @raycast.author gnfisher

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=/dev/null
source "$script_dir/.raycast-lib.sh"

extra="${1:-}"
query="org:github is:pr ${extra}"
open_url "https://github.com/search?q=$(urlencode "$query")&type=pullrequests"
