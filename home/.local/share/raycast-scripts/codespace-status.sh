#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Codespace Status
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🚀
# @raycast.packageName Codespace

# Documentation:
# @raycast.description Show blessed Codespace repo and web-port status
# @raycast.author gnfisher

set -euo pipefail

ws="${HOME}/.local/bin/ws"
repo="${HOME}/Development/github/github"

if [[ -d "$repo/.git" || -f "$repo/.git" ]]; then
    (cd "$repo" && "$ws" cs status)
else
    echo "Local github/github checkout not found at: $repo"
    echo "Skipping repo sync status."
fi
echo
"$ws" cs web-ports status
