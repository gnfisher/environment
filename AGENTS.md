# Environment Dotfiles

This repository contains dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Dotfile Management with Stow

Dotfiles are symlinked to `~` using Stow.

### Re-syncing After Changes

When you add, remove, or rename files, re-sync the symlinks:

```bash
cd ~/path/to/environment

# Re-stow to update symlinks (removes stale, adds new)
stow -R shared
```

The `-R` (restow) flag is equivalent to `-D` (delete) followed by `-S` (stow), which cleans up removed symlinks and creates new ones.

## Directory Structure

- `shared/` - Dotfiles symlinked to `~` via stow, cross platform
- `linux/` - Linux-specific configuration
- `macos/` - macOS-specific configuration
- `install/` - Installation scripts (don't symlink)
- `resources/` - Additional resources (don't symlink)
