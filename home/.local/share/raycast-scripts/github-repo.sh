#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Repo
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🐙
# @raycast.packageName GitHub
# @raycast.argument1 { "type": "text", "placeholder": "owner/repo or repo" }

# Documentation:
# @raycast.description Open a GitHub repository in Microsoft Edge
# @raycast.author gnfisher

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=/dev/null
source "$script_dir/.raycast-lib.sh"

repo=$(repo_slug "$1")
open_url "https://github.com/${repo}"
