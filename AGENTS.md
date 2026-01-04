# Environment Dotfiles

This repository contains dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Dotfile Management with Stow

Dotfiles are organized in the `shared/` directory and symlinked to `~` using Stow.

### Re-syncing After Changes

When you add, remove, or rename files, re-sync the symlinks:

```bash
cd ~/path/to/environment

# Re-stow to update symlinks (removes stale, adds new)
stow -R shared
```

The `-R` (restow) flag is equivalent to `-D` (delete) followed by `-S` (stow), which cleans up removed symlinks and creates new ones.

### Troubleshooting

```bash
# Dry-run to see what would happen
stow -n -v shared

# Force restow if conflicts exist
stow -R --adopt shared  # Careful: --adopt moves existing files INTO the repo
```

## Directory Structure

- `shared/` - Dotfiles symlinked to `~` via stow
- `linux/` - Linux-specific configuration
- `macos/` - macOS-specific configuration
- `install/` - Installation scripts
- `resources/` - Additional resources
