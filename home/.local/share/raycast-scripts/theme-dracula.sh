#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Theme: Dracula
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🧛
# @raycast.packageName Themes

# Documentation:
# @raycast.description Apply Dracula with transparency
# @raycast.author gnfisher

set -euo pipefail

"$HOME/.local/bin/theme-switch" dracula
