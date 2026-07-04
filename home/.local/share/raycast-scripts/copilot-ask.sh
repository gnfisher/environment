#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ask Copilot
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Copilot
# @raycast.argument1 { "type": "text", "placeholder": "question" }

# Documentation:
# @raycast.description Ask a one-off Copilot CLI question
# @raycast.author gnfisher

set -euo pipefail

if ! command -v copilot >/dev/null 2>&1; then
    echo "copilot CLI is not on PATH." >&2
    exit 1
fi

copilot -p "$1"
