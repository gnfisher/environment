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

# Inject Codespaces-specific Copilot instructions (cs/ws helpers)
if [[ -n "${CODESPACE_NAME:-}" || "${CODESPACES:-}" == "true" ]]; then
    instructions_file="$SCRIPT_DIR/shared/.copilot/copilot-instructions.md"
    if [[ -f "$instructions_file" ]]; then
        cs_instructions=$(cat <<'EOF'
<!-- CODESPACES_CS_INSTRUCTIONS_BEGIN -->
## Codespaces

You're operating in a Codespace. Use `cs` for Codespaces operations (status/clean/restart/update/services/forward), and `cs ws` for worktrees and draft PR workflows. Use `ws` directly when you want the full worktree manager interface.
<!-- CODESPACES_CS_INSTRUCTIONS_END -->
EOF
)
        awk -v block="$cs_instructions" '
            BEGIN {in_block=0}
            /<!-- CODESPACES_CS_INSTRUCTIONS_BEGIN -->/ {print block; in_block=1; next}
            /<!-- CODESPACES_CS_INSTRUCTIONS_END -->/ {if (in_block) {in_block=0}; next}
            !in_block {print}
        ' "$instructions_file" > "${instructions_file}.tmp" && mv "${instructions_file}.tmp" "$instructions_file"
    fi
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "To apply changes, run: source ~/.bashrc"
echo ""
echo "Neovim plugins will install on first launch."
