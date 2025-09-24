#!/bin/bash

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1
set -x

echo "🚀 Setting up development environment for GitHub Codespace..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo "🔧 Installing essential tools..."
sudo apt-get install -y  stow tmux ripgrep fd-find jq fuse

# Download and install Neovim
echo "📝 Installing Neovim..."
NVIM_VERSION="v0.9.4"
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz"

# Create temp directory and download
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
wget "$NVIM_URL" -O nvim.tar.gz

# Extract and install
tar -xzf nvim.tar.gz
sudo mv nvim-linux64 /opt/nvim

# Add to PATH by creating symlink
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# Clean up
cd /
rm -rf "$TEMP_DIR"

# Set up dotfiles
echo "⚙️  Setting up dotfiles..."
DOTFILES_DIR=$HOME/dotfiles

# Backup existing .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc.bak
fi

git clone https://github.com/gnfisher/environment $DOTFILES_DIR
stow -d $DOTFILES_DIR -t $HOME shared

# Source bashrc
source "$HOME/.bashrc"

echo "✅ Setup complete!"
echo "🔥 Neovim installed at: $(which nvim)"
echo "📍 Config files linked from: $DOTFILES_DIR"
