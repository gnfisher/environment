#!/usr/bin/env bash
# Install the Codespaces dotfiles subset.

set -euo pipefail

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1

echo "Installing Codespaces dotfiles..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_NAME="${USER:-$(id -un)}"

if ! command -v apt-get >/dev/null 2>&1; then
    echo "This installer expects an Ubuntu-based Codespaces environment with apt-get." >&2
    exit 1
fi

echo "Installing tmux, fish, and stow..."
sudo apt-get update
sudo apt-get install -y fish stow tmux

backup_if_plain_path() {
    local path="$1"

    if [[ -e "$path" && ! -L "$path" ]]; then
        local backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$path" "$backup"
        echo "Backed up $path to $backup"
    fi
}

backup_if_plain_path "$HOME/.tmux.conf"
backup_if_plain_path "$HOME/.config/fish"

echo "Stowing tmux and fish configs..."
stow -R --no-folding \
    -d "$SCRIPT_DIR" \
    -t "$HOME" \
    --ignore='^(?!\.tmux\.conf$|\.config(/fish(/.*)?)?$).*' \
    shared

echo "Setting fish as the default shell..."
FISH_PATH="$(command -v fish)"
if ! grep -qxF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

CURRENT_SHELL="$(getent passwd "$USER_NAME" | cut -d: -f7)"
if [[ "$CURRENT_SHELL" != "$FISH_PATH" ]]; then
    sudo chsh -s "$FISH_PATH" "$USER_NAME"
fi

echo "Codespaces dotfiles installed."
