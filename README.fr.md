# environnement

*[english](README.md) | [français](README.fr.md)*

environnement de développement personnel géré avec gnu stow.

## démarrage rapide

### macos

```bash
# cloner
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment

# appliquer les configurations partagées
stow -d ~/Development/gnfisher/environment -t ~ shared

# appliquer les configurations spécifiques à macos
stow -d ~/Development/gnfisher/environment -t ~ macos
```

### ubuntu / codespaces

```bash
# cloner et exécuter le script d'installation
git clone https://github.com/gnfisher/environment.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## organisation du dépôt

- `shared/` - configurations multiplateformes (installées dans `~`)
- `macos/` - configurations spécifiques à macos
- `linux/` - configurations spécifiques à linux
- `install/` - scripts d'installation
- `resources/` - polices et autres ressources

## notes

### signature des commits dans codespaces

le script `install.sh` désactive la signature gpg des commits car les codespaces n'ont pas accès à votre clé gpg. si vous souhaitez des commits signés dans les codespaces, vous pouvez configurer la signature ssh :

```bash
# utiliser une clé ssh pour signer au lieu de gpg
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

vous devrez également ajouter votre clé ssh en tant que **clé de signature** (pas seulement authentification) dans paramètres github → clés ssh et gpg.

note : les codespaces utilisent le transfert d'identifiants, vous devrez donc peut-être générer une clé dédiée dans le codespace ou explorer l'utilisation de `gh` comme assistant de signature.

---

© 2026 gnfisher. tous droits réservés.
