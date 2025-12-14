#!/usr/bin/env bash
set -euo pipefail

### =========================
### User-tunable options
### =========================
INSTALL_I3=1
INSTALL_HYPRLAND=1
INSTALL_YAY=1

# Recommended for Wayland + NVIDIA. If enabled, script will:
# - set nvidia_drm modeset=1
# - try to add NVIDIA modules to mkinitcpio MODULES=() and rebuild initramfs
ENABLE_NVIDIA_EARLY_KMS=1

# HiDPI target for i3/X11
X11_DPI=144            # 96 * 1.5
XCURSOR_SIZE=48

# Hyprland scale for 4k @ 150%
HYPR_SCALE="1.5"

# Extra “nice to have” packages (edit freely)
EXTRA_PKGS=(alacritty noto-fonts noto-fonts-emoji)

### =========================
### Helpers
### =========================
log() { printf '\n\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\n\033[1;33m!!\033[0m %s\n' "$*"; }
die() { printf '\n\033[1;31mERR:\033[0m %s\n' "$*" >&2; exit 1; }

need_cmd() { command -v "$1" >/dev/null 2>&1 || die "Missing command: $1"; }

backup_if_exists() {
  local f="$1"
  if [[ -e "$f" ]]; then
    local ts
    ts="$(date +%Y%m%d-%H%M%S)"
    cp -a "$f" "${f}.bak.${ts}"
    warn "Backed up $f -> ${f}.bak.${ts}"
  fi
}

append_block_once() {
  local file="$1"
  local marker="$2"
  local content="$3"

  touch "$file"
  if grep -qF "$marker" "$file"; then
    return 0
  fi
  {
    echo ""
    echo "$marker"
    echo "$content"
    echo "$marker"
  } >>"$file"
}

pacman_install() {
  sudo pacman -S --needed --noconfirm "$@"
}

detect_connected_dp_output() {
  # Hyprland output names usually like DP-1, DP-2, etc.
  # We scan /sys/class/drm/card*-DP-*/status for "connected"
  local status_file name
  for status_file in /sys/class/drm/card*-DP-*/status; do
    [[ -e "$status_file" ]] || continue
    if [[ "$(cat "$status_file")" == "connected" ]]; then
      name="$(basename "$(dirname "$status_file")")"   # e.g. card0-DP-1
      echo "${name#card*-}" | sed -E 's/^card[0-9]+-//'
      return 0
    fi
  done
  return 1
}

ensure_nvidia_modeset() {
  log "Setting NVIDIA DRM modeset=1"
  sudo install -d /etc/modprobe.d
  # Create/overwrite a dedicated file rather than editing random ones.
  cat <<'EOF' | sudo tee /etc/modprobe.d/nvidia-drm-modeset.conf >/dev/null
options nvidia_drm modeset=1
EOF
}

ensure_mkinitcpio_modules() {
  local conf="/etc/mkinitcpio.conf"
  [[ -f "$conf" ]] || die "Expected $conf to exist"

  # Append missing NVIDIA modules to MODULES=() without clobbering existing modules.
  # This is a minimal, pragmatic edit; you can always hand-tune later.
  local needed=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
  local line
  line="$(grep -E '^\s*MODULES=\(' "$conf" || true)"
  if [[ -z "$line" ]]; then
    warn "No MODULES=() line found in $conf; adding one."
    echo "MODULES=(${needed[*]})" | sudo tee -a "$conf" >/dev/null
    return 0
  fi

  # Extract current modules inside parentheses
  local current
  current="$(echo "$line" | sed -E 's/^\s*MODULES=\((.*)\)\s*$/\1/')"

  local m updated="$current"
  for m in "${needed[@]}"; do
    if ! grep -qw "$m" <<<"$current"; then
      updated="$updated $m"
    fi
  done

  # Replace the MODULES line
  sudo sed -i -E "s/^\s*MODULES=\(.*\)\s*$/MODULES=(${updated//  / })/" "$conf"
}

build_initramfs() {
  log "Rebuilding initramfs (mkinitcpio -P)"
  sudo mkinitcpio -P
}

install_yay() {
  if command -v yay >/dev/null 2>&1; then
    log "yay already installed; skipping"
    return 0
  fi

  log "Installing yay (AUR)"
  pacman_install base-devel git

  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT

  git clone https://aur.archlinux.org/yay.git "$tmp/yay"
  (cd "$tmp/yay" && makepkg -si --noconfirm)
}

### =========================
### Main
### =========================
need_cmd pacman
need_cmd sudo

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  die "Run this as your normal user (it will sudo when needed)."
fi

log "Refreshing package databases and upgrading system"
sudo pacman -Syu --noconfirm

log "Enabling NetworkManager and weekly SSD TRIM"
sudo systemctl enable --now NetworkManager >/dev/null 2>&1 || true
sudo systemctl enable --now fstrim.timer

log "Installing base packages (audio, gpu, tooling)"
BASE_PKGS=(
  git
  base-devel
  intel-ucode
  pipewire
  wireplumber
  pipewire-pulse
  nvidia
  nvidia-utils
  nvidia-settings
  egl-wayland
)
pacman_install "${BASE_PKGS[@]}" "${EXTRA_PKGS[@]}"

# Optional: multilib packages for some 32-bit needs (steam/proton etc.)
# We'll try installing lib32-nvidia-utils; it will fail if multilib isn't enabled.
log "Attempting to install lib32-nvidia-utils (optional; will be skipped if multilib not enabled)"
sudo pacman -S --needed --noconfirm lib32-nvidia-utils >/dev/null 2>&1 || \
  warn "Could not install lib32-nvidia-utils (multilib likely disabled). This is OK."

if [[ "$ENABLE_NVIDIA_EARLY_KMS" -eq 1 ]]; then
  ensure_nvidia_modeset
  ensure_mkinitcpio_modules
  build_initramfs
  warn "NVIDIA early-KMS changes applied. A reboot is recommended after the script finishes."
fi

if [[ "$INSTALL_YAY" -eq 1 ]]; then
  install_yay
fi

if [[ "$INSTALL_I3" -eq 1 ]]; then
  log "Installing i3 + Xorg"
  pacman_install xorg-server xorg-xinit xorg-xrandr i3-wm i3status i3lock dmenu

  log "Configuring i3 startx flow + HiDPI (DPI=${X11_DPI})"
  backup_if_exists "$HOME/.xinitrc"
  cat >"$HOME/.xinitrc" <<EOF
xrdb -merge ~/.Xresources
exec i3
EOF

  backup_if_exists "$HOME/.Xresources"
  cat >"$HOME/.Xresources" <<EOF
Xft.dpi: ${X11_DPI}
Xcursor.size: ${XCURSOR_SIZE}
EOF

  # Add env vars to ~/.profile without duplicating
  backup_if_exists "$HOME/.profile"
  append_block_once "$HOME/.profile" \
    "### >>> dotfiles:hidpi-x11 >>>" \
    "export GDK_SCALE=2
export GDK_DPI_SCALE=0.75   # 2 * 0.75 = 1.5
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1.5" \
    "### <<< dotfiles:hidpi-x11 <<<"
fi

if [[ "$INSTALL_HYPRLAND" -eq 1 ]]; then
  log "Installing Hyprland + portals"
  pacman_install hyprland xdg-desktop-portal-hyprland xorg-xwayland wayland-protocols

  log "Creating minimal Hyprland config (scale=${HYPR_SCALE})"
  mkdir -p "$HOME/.config/hypr"
  backup_if_exists "$HOME/.config/hypr/hyprland.conf"

  local_output="DP-1"
  if out="$(detect_connected_dp_output)"; then
    local_output="$out"
  else
    warn "Could not auto-detect a connected DP output; using DP-1. If wrong, run: hyprctl monitors"
  fi

  cat >"$HOME/.config/hypr/hyprland.conf" <<EOF
# Minimal Hyprland config generated by dotfiles bootstrap script

# NVIDIA niceties (commonly helpful)
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = ELECTRON_OZONE_PLATFORM_HINT,auto

# 4K @ 150%
monitor = ${local_output}, preferred, auto, ${HYPR_SCALE}

\$mod = SUPER
bind = \$mod, RETURN, exec, alacritty
bind = \$mod, Q, killactive
bind = \$mod, D, exec, dmenu_run
bind = \$mod SHIFT, E, exit
EOF
fi

log "Done."

echo ""
echo "Next steps:"
echo "  1) Reboot (recommended, especially if NVIDIA initramfs/modeset changed)"
echo "  2) i3:   run 'startx'"
echo "  3) Hypr: run 'dbus-run-session Hyprland'"
echo ""
echo "Hyprland monitor name check:"
echo "  hyprctl monitors"
echo ""
