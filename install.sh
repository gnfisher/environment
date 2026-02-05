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

# Install Neovim (extract AppImage for glibc compatibility without FUSE)
echo "📝 Installing Neovim..."
NVIM_VERSION="v0.11.1"
if ! command -v nvim &>/dev/null || [[ "$(nvim --version 2>/dev/null | head -1)" != *"${NVIM_VERSION#v}"* ]]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage"
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    wget -q "$NVIM_URL" -O nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract >/dev/null
    sudo rm -rf /opt/nvim
    sudo mv squashfs-root /opt/nvim
    sudo ln -sf /opt/nvim/AppRun /usr/local/bin/nvim
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

    # Inject Codespaces-specific Copilot instructions (cs/ws helpers)
    instructions_file="$SCRIPT_DIR/shared/.copilot/copilot-instructions.md"
    if [[ -f "$instructions_file" ]]; then
        cs_instructions=$(cat <<'EOF'
<!-- CODESPACES_CS_INSTRUCTIONS_BEGIN -->
## Codespaces

You're operating in a Codespace. The repos we care about live under /workspaces/* (example layout):
```
/workspaces/
  copilot-api/
  copilot-developer-action-local/
  copilot-mission-control/
  github/
  github-ui/
  packages/
  sweagentd/
```

We work across repos; each repo has its own branch and docs (start with README.md and docs/). Prefer `cs` for Codespaces operations (status/clean/restart/update/services/forward), and `cs ws` for worktrees and draft PR workflows; use `ws` for the full worktree manager.

Repo aliases and meaning: `capi` == copilot-api; copilot-mission-control == cmc/mission control/task api; `github` is the monolith; `github-ui` contains the React UI. Start the monolith with UI via `script/dx/server-start --ui` (or `cs-services start github`) which uses github-ui as the source.

Reliable scripts/docs (preferred):
- `cs-services status|start|stop|logs <service>` (github, sweagentd, capi, mission-control).
- github: script/dx/server-start --ui; script/dx/server-logs; script/server --log-output (logs in tmp/app.log and tmp/*.log).
- github-ui: script/server (or from github, script/server --ui); README.md for full-stack vs UI-only.
- sweagentd: script/server (overmind), script/cosmos-dev, script/redis-dev; logs via `cs-services logs sweagentd` (overmind socket /tmp/overmind-sweagentd.sock).
- copilot-api: docs/dev/local-development.md; script/server; make cosmos-emulator-*; docs/dev/debug-logging.md.
- copilot-mission-control: docs/dev/dotcom-codespaces-development.md; script/server --type all --background; script/routes.

Log tips: prefer `cs-services logs <service>`; otherwise use repo-specific logs (github tmp/*.log, sweagentd overmind socket, mission-control/log and copilot-api/log when present).
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
