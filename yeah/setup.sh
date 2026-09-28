#!/usr/bin/env bash
set -euo pipefail

# 1. Official Arch Repository Packages
PACMAN_PKGS=(
  ttf-jetbrains-mono-nerd
  ttf-firacode-nerd
  ttf-font-awesome
  xdg-desktop-portal-gnome
  waybar
  mako
  niri
  fastfetch
  steam
  anki
  rofi
)

# 2. AUR Packages
AUR_PKGS=(
  zen-browser-bin
  wlogout
  helium-browser-bin
  unnamed-sdvx-clone
  twintaillauncher-bin
  tetrio-desktop
  protonplus
)

# 3. Directories to copy to ~/.config
CONFIG_DIRS=(
  fastfetch
  kitty
  mako
  niri
  pipewire
  waybar
  wlogout
  xdg-desktop-portal
  autostart
)

echo "==> Installing official repo packages..."
sudo pacman -Sy --noconfirm --needed "${PACMAN_PKGS[@]}"

echo "==> Installing AUR packages..."
if command -v yay &> /dev/null; then
  yay -S --noconfirm --needed "${AUR_PKGS[@]}"
elif command -v paru &> /dev/null; then
  paru -S --noconfirm --needed "${AUR_PKGS[@]}"
else
  echo "Error: Neither yay nor paru was found for AUR packages." >&2
  exit 1
fi

echo "==> Copying dotfiles to ~/.config..."
mkdir -p "$HOME/.config"

for dir in "${CONFIG_DIRS[@]}"; do
  if [ -d "./$dir" ]; then
    echo "Copying ./$dir -> $HOME/.config/$dir"
    cp -r "./$dir" "$HOME/.config/"
  else
    echo "Warning: Directory ./$dir does not exist in current location, skipping."
  fi
done

echo "==> Setup complete!"
