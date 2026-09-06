#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Theme: Naysayer
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🟦
# @raycast.packageName Themes

# Documentation:
# @raycast.description Apply the Jonathan Blow-inspired Naysayer theme
# @raycast.author gnfisher

set -euo pipefail

"$HOME/.local/bin/theme-switch" naysayer
