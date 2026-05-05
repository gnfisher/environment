#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitHub Code Search
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔭
# @raycast.packageName GitHub
# @raycast.argument1 { "type": "text", "placeholder": "search query" }

# Documentation:
# @raycast.description Search GitHub code in Microsoft Edge
# @raycast.author gnfisher

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=/dev/null
source "$script_dir/.raycast-lib.sh"

query=$(urlencode "$1")
open_url "https://github.com/search?q=${query}&type=code"
