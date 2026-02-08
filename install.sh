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
    fish \
    fd-find \
    jq \
    fzf \
    universal-ctags \
    ninja-build \
    gettext \
    cmake \
    build-essential \
    curl \
    git \
    wget \
    unzip

# Install Neovim (build from source for glibc compatibility)
echo "📝 Installing Neovim..."
NVIM_VERSION="v0.11.1"
if ! command -v nvim &>/dev/null || [[ "$(nvim --version 2>/dev/null | head -1)" != *"${NVIM_VERSION#v}"* ]]; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    git clone --depth 1 --branch "${NVIM_VERSION}" https://github.com/neovim/neovim.git
    cd neovim
    sudo rm -f /usr/local/bin/nvim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd "$SCRIPT_DIR"
    rm -rf "$TEMP_DIR"
    echo "✅ Neovim ${NVIM_VERSION} installed"
else
    echo "✅ Neovim already installed"
fi

# Install lazygit
echo "📝 Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if ! command -v lazygit &>/dev/null || [[ "$(lazygit --version | grep -oP 'version=\K[^,]+')" != "$LAZYGIT_VERSION" ]]; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xzf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    cd "$SCRIPT_DIR"
    rm -rf "$TEMP_DIR"
    echo "✅ lazygit ${LAZYGIT_VERSION} installed"
else
    echo "✅ lazygit already installed"
fi

# Install lazydocker
echo "🐳 Installing lazydocker..."
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if ! command -v lazydocker &>/dev/null; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
    tar -xzf lazydocker.tar.gz lazydocker
    sudo install lazydocker /usr/local/bin
    cd "$SCRIPT_DIR"
    rm -rf "$TEMP_DIR"
    echo "✅ lazydocker ${LAZYDOCKER_VERSION} installed"
else
    echo "✅ lazydocker already installed"
fi

# Install difftastic
echo "🔍 Installing difftastic..."
DIFFT_VERSION="0.67.0"
if ! command -v difft &>/dev/null || [[ "$(difft --version | grep -oP '\d+\.\d+\.\d+')" != "$DIFFT_VERSION" ]]; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    curl -Lo difft.tar.gz "https://github.com/Wilfred/difftastic/releases/download/${DIFFT_VERSION}/difft-x86_64-unknown-linux-gnu.tar.gz"
    tar -xzf difft.tar.gz
    sudo install difft /usr/local/bin
    cd "$SCRIPT_DIR"
    rm -rf "$TEMP_DIR"
    echo "✅ difftastic ${DIFFT_VERSION} installed"
else
    echo "✅ difftastic already installed"
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
echo "🐟 Setting fish as default shell..."
if command -v fish &>/dev/null; then
    FISH_PATH=$(which fish)
    # Add fish to /etc/shells if not present
    if ! grep -q "^${FISH_PATH}$" /etc/shells; then
        echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
    fi
    # Change default shell to fish (use sudo since chsh may require it in codespaces)
    sudo chsh -s "$FISH_PATH" "$(whoami)" 2>/dev/null || chsh -s "$FISH_PATH" 2>/dev/null || echo "⚠️  Could not change shell automatically"
    echo "✅ Fish set as default shell"
else
    echo "⚠️  Fish not found, skipping shell change"
fi

# Codespaces-specific setup
if [[ -n "${CODESPACE_NAME:-}" || "${CODESPACES:-}" == "true" ]]; then
    # Store GITHUB_TOKEN in gh config so Copilot CLI can access it
    # (Copilot runs in a non-interactive shell without the env var)
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        echo "🔑 Configuring gh auth for Copilot CLI..."
        token="$GITHUB_TOKEN"
        unset GITHUB_TOKEN
        printf "%s" "$token" | gh auth login --with-token
        echo "✅ gh auth configured"
    fi

fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "To apply changes, run: source ~/.bashrc"
echo ""
echo "Neovim plugins will install on first launch."
