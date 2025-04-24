#!/usr/bin/env bash
set -euo pipefail

# Base dirs
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
THEME_DIR="${HOME}/.themes"
ICON_DIR="${HOME}/.icons"
FONT_DIR="${HOME}/.local/share/fonts"
BACKUP_AWESOME="${CONFIG_DIR}/awesome.bak"

# 1. Create target dirs if needed
mkdir -p "$CONFIG_DIR" "$THEME_DIR" "$ICON_DIR" "$FONT_DIR"

# 2. Backup existing awesome config (if not already a symlink)
if [ -d "${CONFIG_DIR}/awesome" ] && [ ! -L "${CONFIG_DIR}/awesome" ]; then
  mv "${CONFIG_DIR}/awesome" "${BACKUP_AWESOME}"
  echo "Backed up ~/.config/awesome → ~/.config/awesome.bak"
fi

# 3. Link awesome config
ln -sfn "${REPO_DIR}/awesome" "${CONFIG_DIR}/awesome"
echo "Linked awesome → ~/.config/awesome"

# 4. Link fonts
for src in "${REPO_DIR}/Misc/fonts/"*; do
  ln -sfn "$src" "${FONT_DIR}/$(basename "$src")"
done
echo "Linked fonts → $FONT_DIR"

# 5. Link GTK themes
for src in "${REPO_DIR}/Misc/gtk_themes/"*; do
  ln -sfn "$src" "${THEME_DIR}/$(basename "$src")"
done
echo "Linked GTK themes → $THEME_DIR"

# 6. Link icon packs
for src in "${REPO_DIR}/Misc/icon_packs/"*; do
  ln -sfn "$src" "${ICON_DIR}/$(basename "$src")"
done
echo "Linked icon packs → $ICON_DIR"

echo "✅ Install complete."

