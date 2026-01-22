#!/bin/bash
# Install shared dotfiles on Ubuntu-based systems (codespaces, etc.)
# Usage: ./install.sh

set -e

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1
set -x

echo "🚀 Installing dotfiles..."

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update

# Install essential tools
echo "🔧 Installing essential tools..."
sudo apt-get install -y \
    stow \
    tmux \
    ripgrep \
    fd-find \
    jq \
    fzf \
    fish \
    universal-ctags \
    build-essential \
    curl \
    wget \
    unzip

# Install Neovim (latest stable)
echo "📝 Installing Neovim..."
NVIM_VERSION="v0.11.1"
if ! command -v nvim &>/dev/null || [[ "$(nvim --version | head -1)" != *"${NVIM_VERSION#v}"* ]]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    wget -q "$NVIM_URL" -O nvim.tar.gz
    tar -xzf nvim.tar.gz
    sudo rm -rf /opt/nvim
    sudo mv nvim-linux-x86_64 /opt/nvim
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    cd "$SCRIPT_DIR"
    rm -rf "$TEMP_DIR"
    echo "✅ Neovim ${NVIM_VERSION} installed"
else
    echo "✅ Neovim already installed"
fi

# Backup existing configs
echo "📁 Backing up existing configs..."
for file in .bashrc .tmux.conf .gitconfig; do
    if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
        mv "$HOME/$file" "$HOME/${file}.bak"
        echo "  Backed up $file"
    fi
done

# Remove existing config dirs that would conflict with stow
for dir in .config/nvim .config/fish; do
    if [[ -d "$HOME/$dir" && ! -L "$HOME/$dir" ]]; then
        mv "$HOME/$dir" "$HOME/${dir}.bak"
        echo "  Backed up $dir"
    fi
done

# Stow shared dotfiles
echo "⚙️  Stowing dotfiles..."
stow -d "$SCRIPT_DIR" -t "$HOME" shared

# Create fd symlink (Ubuntu names it fdfind)
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi

# Disable GPG signing in codespaces (no GPG key available)
# See README.md for info on setting up SSH signing if needed
echo "🔐 Disabling GPG commit signing (no key in codespace)..."
git config --global commit.gpgsign false

# Set fish as the default shell
if command -v fish &>/dev/null; then
    echo "🐚 Setting fish as default shell..."
    FISH_PATH=$(command -v fish)
    # Add fish to /etc/shells if not already present
    if ! grep -Fx "$FISH_PATH" /etc/shells; then
        echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    # Change default shell to fish
    sudo chsh -s "$FISH_PATH" "$USER"
    echo "✅ Fish shell set as default"
else
    echo "⚠️  Fish shell not found, skipping default shell change"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "To apply changes, run: source ~/.bashrc"
echo "Fish shell will be the default on next login."
echo ""
echo "Neovim plugins will install on first launch."
