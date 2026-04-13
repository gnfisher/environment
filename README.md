# Environment

Personal development environment managed with GNU Stow.

## Quick Start

### macOS

```bash
# Clone
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment

# Apply shared configs
stow -d ~/Development/gnfisher/environment -t ~ shared

# Apply macOS-specific configs
stow -d ~/Development/gnfisher/environment -t ~ macos
```

### Ubuntu / Codespaces

```bash
# Clone and run install script
git clone https://github.com/gnfisher/environment.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Repository Layout

- `shared/` - Cross-platform configs (stowed to `~`)
- `macos/` - macOS-specific configs
- `linux/` - Linux-specific configs
- `install.sh` - Setup script for Ubuntu/Codespaces
- `resources/` - Fonts and other resources

## Key Configs

- `shared/.copilot/mcp-config.json` - Copilot CLI MCP server definitions
- `shared/.local/bin/todoist-mcp` - Launches the official Todoist MCP via 1Password CLI
- `~/.local/state/todoist-mcp.env` - Local-only 1Password secret reference file used by Todoist MCP (not committed)
