#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Neovim Theme: Naysayer
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🟦
# @raycast.packageName Themes

# Documentation:
# @raycast.description Apply the Jonathan Blow-inspired Naysayer theme in Neovim
# @raycast.author gnfisher

set -euo pipefail

"$HOME/.local/bin/theme-switch" naysayer
