#!/usr/bin/env bash
set -euo pipefail

# Simple uninstaller for TastaturTraining
# Usage: sudo ./uninstall.sh [TARGET_DIR]
# Default TARGET_DIR is /opt/tastaturtraining

TARGET_DIR="${1:-/opt/tastaturtraining}"

if [[ "$EUID" -ne 0 ]]; then
  echo "This uninstaller must be run as root (use sudo)."
  exit 1
fi

echo "Removing TastaturTraining from $TARGET_DIR"

if [[ -d "$TARGET_DIR" ]]; then
  rm -rf "$TARGET_DIR"
  echo "Removed $TARGET_DIR"
else
  echo "$TARGET_DIR does not exist; skipping"
fi

if [[ -f /usr/local/bin/tastaturtraining ]]; then
  rm -f /usr/local/bin/tastaturtraining
  echo "Removed /usr/local/bin/tastaturtraining"
fi

if [[ -f /usr/share/applications/tastaturtraining.desktop ]]; then
  rm -f /usr/share/applications/tastaturtraining.desktop
  echo "Removed system desktop entry"
fi

# Remove per-user desktop if present for sudo user
INSTALL_USER="${SUDO_USER:-$(logname 2>/dev/null || echo root)}"
USER_DESKTOP="/home/$INSTALL_USER/Desktop/tastaturtraining.desktop"
if [[ -f "$USER_DESKTOP" ]]; then
  rm -f "$USER_DESKTOP" || true
  echo "Removed $USER_DESKTOP"
fi

echo "Uninstallation complete."

exit 0
