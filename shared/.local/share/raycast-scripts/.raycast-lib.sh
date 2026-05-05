#!/usr/bin/env bash

set -euo pipefail

open_url() {
    local url="$1"
    if [[ "$(uname -s)" == "Darwin" ]] && [[ -d "/Applications/Microsoft Edge.app" ]]; then
        open -a "Microsoft Edge" "$url"
    else
        open "$url"
    fi
}

urlencode() {
    python3 - "$1" <<'PY'
from urllib.parse import quote_plus
import sys

print(quote_plus(sys.argv[1]))
PY
}

repo_slug() {
    local input="$1"
    if [[ "$input" == */* ]]; then
        printf '%s\n' "$input"
    else
        printf 'github/%s\n' "$input"
    fi
}

open_ghostty() {
    local path="$1"
    local title="$2"
    if [[ "$(uname -s)" == "Darwin" ]] && command -v open >/dev/null 2>&1; then
        open -na "Ghostty" --args "--working-directory=${path}" "--title=${title}"
    else
        printf '%s\n' "$path"
    fi
}
