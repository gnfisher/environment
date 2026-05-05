#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Codespace Web Ports
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔌
# @raycast.packageName Codespace

# Documentation:
# @raycast.description Toggle browser-facing forwarded ports for the blessed Codespace
# @raycast.author gnfisher

set -euo pipefail

"${HOME}/.local/bin/ws" cs web-ports
