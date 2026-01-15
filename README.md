# environment

*[english](README.md) | [français](README.fr.md)*

personal development environment managed with gnu stow.

## quick start

### macos

```bash
# clone
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment

# apply shared configs
stow -d ~/Development/gnfisher/environment -t ~ shared

# apply macos-specific configs
stow -d ~/Development/gnfisher/environment -t ~ macos
```

### ubuntu / codespaces

```bash
# clone and run install script
git clone https://github.com/gnfisher/environment.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## repository layout

- `shared/` - cross-platform configs (stowed to `~`)
- `macos/` - macos-specific configs
- `linux/` - linux-specific configs
- `install/` - setup scripts
- `resources/` - fonts and other resources

## notes

### commit signing in codespaces

the `install.sh` script disables gpg commit signing because codespaces don't have access to your gpg key. if you want signed commits in codespaces, you can set up ssh signing:

```bash
# use ssh key for signing instead of gpg
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

you'll also need to add your ssh key as a **signing key** (not just authentication) in github settings → ssh and gpg keys.

note: codespaces use credential forwarding, so you may need to generate a dedicated key in the codespace or explore using `gh` as a signing helper.

---

© 2026 gnfisher. all rights reserved.
