# Environment Dotfiles

Personal development environment configuration managed with GNU Stow.

## Repository Structure

```
environment/
├── install/              # Setup scripts
│   └── codespace-setup.sh  # GitHub Codespaces bootstrap
├── linux/                # Linux-specific configs
│   └── .gnupg/
├── macos/                # macOS-specific configs
│   └── .config/aerospace/
├── shared/               # Cross-platform configs (stowed to ~)
│   ├── .bashrc
│   ├── .gitconfig
│   ├── .tmux.conf
│   ├── .config/nvim/     # Neovim (see its own AGENTS.md)
│   ├── .config/ghostty/
│   └── .local/bin/
└── resources/            # Fonts and other resources
```

## Common Commands

```bash
# Apply shared configs to home directory
stow -d ~/Development/gnfisher/environment -t ~ shared

# Apply macOS-specific configs
stow -d ~/Development/gnfisher/environment -t ~ macos

# Preview what stow would do (dry run)
stow -n -v -d ~/Development/gnfisher/environment -t ~ shared
```

## Key Files

- `shared/.bashrc` - Shell configuration, aliases, PATH setup
- `shared/.gitconfig` - Git aliases and settings (uses gpg signing)
- `shared/.tmux.conf` - Tmux with C-s prefix, vim-style navigation
- `shared/.config/nvim/` - Neovim config with lazy.nvim

## Git Aliases Available

From `.gitconfig`:
- `git s` - status (short)
- `git d` / `git dc` - diff / diff cached
- `git l` - log (oneline, last 20)
- `git rom` - fetch and rebase on origin/main
- `git amend` - amend without editing message
- `git pushf` - push force with lease

## Workflow Notes

- Uses GNU Stow for symlink management
- Shared configs work on both macOS and Linux
- Codespaces setup clones this repo and stows shared/
- GPG signing enabled for commits (key in .gitconfig)

## Maintaining AGENTS.md

Keep this and all nested AGENTS.md accurate and useful as you make changes:
- Update directory structure when adding/removing config folders
- Add new commands or aliases worth remembering
- Add useful context or information you learned while working on a task that would be useful to future you and other engineers, placed at the appropriate level. e.g. AGENTS.md at the root for repo/project wide concerns, and nested AGENTS.md for module wide concerns, and so on. If a nested AGENTS.md doesn't exist and you think it's a good time to add it, ask the user first.
- Remove outdated information promptly
- Keep it concise — if a section grows large, consider a nested AGENTS.md (like `shared/.config/nvim/AGENTS.md`)
