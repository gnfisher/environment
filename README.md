# Environment

Personal macOS development environment managed with Homebrew and GNU Stow.

## Quick Start

```bash
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment
cd ~/Development/gnfisher/environment
./install.sh
```

## Repository Layout

- `Brewfile` - Homebrew packages and casks
- `home/` - Dotfiles stowed to `~`
- `install.sh` - macOS setup script

## Key Configs

- `home/.zshrc` - Minimal zsh config
- `home/.config/starship.toml` - Fast Starship prompt
- `home/.config/nvim/` - Optional Neovim config
- `home/.config/ghostty/` - Ghostty config
- `home/.copilot/` - Copilot CLI config and skills

## Direction

- macOS only
- zsh only; no bash or fish support
- Starship for prompt
- mise for language/tool version management
- Homebrew for system packages and Go
