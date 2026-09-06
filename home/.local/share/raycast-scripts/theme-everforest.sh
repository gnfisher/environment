#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Neovim Theme: Everforest
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🌲
# @raycast.packageName Themes

# Documentation:
# @raycast.description Apply Everforest in Neovim
# @raycast.author gnfisher

set -euo pipefail

"$HOME/.local/bin/theme-switch" everforest
