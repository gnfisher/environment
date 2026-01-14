# Entorno 🇪🇸

Entorno de desarrollo personal gestionado con GNU Stow. 💃

## Inicio Rápido 🚀

### macOS

```bash
# Clonar
git clone git@github.com:gnfisher/environment.git ~/Development/gnfisher/environment

# Aplicar configuraciones compartidas
stow -d ~/Development/gnfisher/environment -t ~ shared

# Aplicar configuraciones específicas de macOS
stow -d ~/Development/gnfisher/environment -t ~ macos
```

### Ubuntu / Codespaces

```bash
# Clonar y ejecutar el script de instalación
git clone https://github.com/gnfisher/environment.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Estructura del Repositorio 📂

- `shared/` - Configuraciones multiplataforma (enlazadas a `~`)
- `macos/` - Configuraciones específicas de macOS
- `linux/` - Configuraciones específicas de Linux
- `install/` - Scripts de configuración
- `resources/` - Fuentes y otros recursos

## Notas 📝

### Firma de Commits en Codespaces 🔐

El script `install.sh` desactiva la firma de commits con GPG porque los codespaces no tienen acceso a tu clave GPG. Si deseas commits firmados en codespaces, puedes configurar la firma con SSH:

```bash
# Usar clave SSH para firmar en lugar de GPG
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

También necesitarás agregar tu clave SSH como **Clave de Firma** (no solo de Autenticación) en Configuración de GitHub → Claves SSH y GPG.

Nota: Los codespaces usan reenvío de credenciales, por lo que es posible que necesites generar una clave dedicada en el codespace o explorar el uso de `gh` como ayudante de firma.
