# Copilot Instructions

Personal development environment managed with GNU Stow.

## Repository Layout

- `install/` - Setup scripts (e.g., `codespace-setup.sh`)
- `linux/` - Linux-specific configs (`.gnupg/`)
- `macos/` - macOS-specific configs (`.config/aerospace/`)
- `shared/` - Cross-platform configs stowed to `~`
- `resources/` - Fonts and other resources

## Stow Commands

```bash
# Apply shared configs
stow -d ~/Development/gnfisher/environment -t ~ shared

# Apply macOS configs
stow -d ~/Development/gnfisher/environment -t ~ macos

# Dry run
stow -n -v -d ~/Development/gnfisher/environment -t ~ shared
```

## Key Configs

- `shared/.bashrc` - Bash config, aliases, PATH
- `shared/.config/fish/` - Fish shell config (mirrors bash)
- `shared/.gitconfig` - Git aliases, GPG signing
- `shared/.tmux.conf` - Tmux (C-s prefix, vim navigation)
- `shared/.config/nvim/` - Neovim with lazy.nvim

## Git Aliases

- `git s` - status (short)
- `git d` / `git dc` - diff / diff cached
- `git l` - log (oneline, last 20)
- `git rom` - fetch and rebase on origin/main
- `git amend` - amend without editing message

## Shell Aliases (bash & fish)

- `ll`, `la`, `l` - ls variants
- `..`, `...` - cd parent/grandparent
- `g` - git
- `dots` - cd to this repo
- `dev` - cd to ~/Development
- `gh-clone <url>` - clone to ~/Development/$org/$repo

## Guidelines

- Keep shared configs cross-platform (macOS + Linux)
- Prompt is simple: `folderName$ ` in both bash and fish
