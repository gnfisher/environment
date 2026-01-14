# Environnement

*[English](README.md) | [Français](README.fr.md)*

Environnement de développement personnel géré avec GNU Stow.

## Démarrage Rapide

### macOS

```bash
# Cloner
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment

# Appliquer les configurations partagées
stow -d ~/Development/gnfisher/environment -t ~ shared

# Appliquer les configurations spécifiques à macOS
stow -d ~/Development/gnfisher/environment -t ~ macos
```

### Ubuntu / Codespaces

```bash
# Cloner et exécuter le script d'installation
git clone https://github.com/gnfisher/environment.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Organisation du Dépôt

- `shared/` - Configurations multiplateformes (installées dans `~`)
- `macos/` - Configurations spécifiques à macOS
- `linux/` - Configurations spécifiques à Linux
- `install/` - Scripts d'installation
- `resources/` - Polices et autres ressources

## Notes

### Signature des Commits dans Codespaces

Le script `install.sh` désactive la signature GPG des commits car les codespaces n'ont pas accès à votre clé GPG. Si vous souhaitez des commits signés dans les codespaces, vous pouvez configurer la signature SSH :

```bash
# Utiliser une clé SSH pour signer au lieu de GPG
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

Vous devrez également ajouter votre clé SSH en tant que **Clé de Signature** (pas seulement authentification) dans Paramètres GitHub → Clés SSH et GPG.

Note : Les Codespaces utilisent le transfert d'identifiants, vous devrez donc peut-être générer une clé dédiée dans le codespace ou explorer l'utilisation de `gh` comme assistant de signature.
