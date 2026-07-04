#!/bin/zsh
# Install the macOS dotfiles.

set -euo pipefail

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1

echo "Installing macOS dotfiles..."

SCRIPT_DIR="${0:A:h}"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This installer only supports macOS." >&2
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required. Install it from https://brew.sh, then re-run this script." >&2
    exit 1
fi

echo "Installing Homebrew bundle..."
brew bundle --file "$SCRIPT_DIR/Brewfile"

remove_stale_link() {
    local path="$1"

    if [[ -L "$path" ]]; then
        rm "$path"
        echo "Removed stale symlink $path"
    fi
}

backup_if_plain_path() {
    local path="$1"

    if [[ -e "$path" && ! -L "$path" ]]; then
        local backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$path" "$backup"
        echo "Backed up $path to $backup"
    fi
}

remove_stale_link "$HOME/.bash_profile"
remove_stale_link "$HOME/.bashrc"
remove_stale_link "$HOME/.config/bash"
remove_stale_link "$HOME/.config/fish"

backup_if_plain_path "$HOME/.bash_profile"
backup_if_plain_path "$HOME/.bashrc"
backup_if_plain_path "$HOME/.config/bash"
backup_if_plain_path "$HOME/.config/fish"
backup_if_plain_path "$HOME/.zshrc"
backup_if_plain_path "$HOME/.gitconfig"
backup_if_plain_path "$HOME/.tmux.conf"
backup_if_plain_path "$HOME/.config/starship.toml"
backup_if_plain_path "$HOME/.config/gh"
backup_if_plain_path "$HOME/.config/ghostty"
backup_if_plain_path "$HOME/.config/nvim"
backup_if_plain_path "$HOME/.config/opencode"
backup_if_plain_path "$HOME/.copilot"
backup_if_plain_path "$HOME/.gnupg"

echo "Stowing home configs..."
stow -R --no-folding \
    -d "$SCRIPT_DIR" \
    -t "$HOME" \
    home

if [[ "${SHELL:-}" != "/bin/zsh" ]]; then
    echo "Setting zsh as the default shell..."
    chsh -s /bin/zsh
fi

echo "macOS dotfiles installed."
