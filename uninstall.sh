#!/usr/bin/env bash
set -euo pipefail

# Base dirs
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
THEME_DIR="${HOME}/.themes"
ICON_DIR="${HOME}/.icons"
FONT_DIR="${HOME}/.local/share/fonts"
BACKUP_AWESOME="${CONFIG_DIR}/awesome.bak"

# 1. Remove awesome symlink & restore backup
if [ -L "${CONFIG_DIR}/awesome" ]; then
  rm "${CONFIG_DIR}/awesome"
  echo "Removed symlink ~/.config/awesome"
  if [ -d "$BACKUP_AWESOME" ]; then
    mv "$BACKUP_AWESOME" "${CONFIG_DIR}/awesome"
    echo "Restored backup → ~/.config/awesome"
  fi
fi

# 2. Remove font symlinks
for src in "${REPO_DIR}/Misc/fonts/"*; do
  rm -f "${FONT_DIR}/$(basename "$src")"
done
echo "Removed font symlinks from $FONT_DIR"

# 3. Remove GTK theme symlinks
for src in "${REPO_DIR}/Misc/gtk_themes/"*; do
  rm -f "${THEME_DIR}/$(basename "$src")"
done
echo "Removed GTK theme symlinks from $THEME_DIR"

# 4. Remove icon pack symlinks
for src in "${REPO_DIR}/Misc/icon_packs/"*; do
  rm -f "${ICON_DIR}/$(basename "$src")"
done
echo "Removed icon pack symlinks from $ICON_DIR"

echo "✅ Uninstall complete."

