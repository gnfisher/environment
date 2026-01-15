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
- `install/` - Setup scripts
- `resources/` - Fonts and other resources

## Notes

### Commit Signing in Codespaces

The `install.sh` script disables GPG commit signing because codespaces don't have access to your GPG key. If you want signed commits in codespaces, you can set up SSH signing:

```bash
# Use SSH key for signing instead of GPG
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

You'll also need to add your SSH key as a **Signing Key** (not just Authentication) in GitHub Settings → SSH and GPG keys.

Note: Codespaces use credential forwarding, so you may need to generate a dedicated key in the codespace or explore using `gh` as a signing helper.
