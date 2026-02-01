# Copilot Instructions

Personal development environment managed with GNU Stow.

## Repository Layout

- `install.sh` - Setup script for Ubuntu/Codespaces
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

## Adding New Configs

When asked to "add a config for X" or similar, if it's a dotfile/config file:

1. Create the file in this repo under the appropriate directory:
   - `shared/` for cross-platform configs (most common)
   - `macos/` for macOS-only configs
   - `linux/` for Linux-only configs
2. Mirror the target path structure (e.g., `~/.config/foo/` → `shared/.config/foo/`)
3. Run stow to symlink: `stow -d ~/Development/gnfisher/environment -t ~ shared`

Do NOT create dotfiles directly in `~` — always add them to this repo first, then stow.

## Guidelines

- Keep shared configs cross-platform (macOS + Linux)
- Prompt is simple: `folderName$ ` in both bash and fish
- **Keep bash and fish in sync**: When adding/changing aliases, environment variables, PATH entries, or shell functions, update BOTH `shared/.bashrc` and `shared/.config/fish/config.fish` (and related fish files as needed)
