#!/usr/bin/env bash
set -euo pipefail

# Simple installer for TastaturTraining
# Usage: sudo ./install.sh [TARGET_DIR]
# Default TARGET_DIR is /opt/tastaturtraining

TARGET_DIR="${1:-/opt/tastaturtraining}"

if [[ "$EUID" -ne 0 ]]; then
  echo "This installer must be run as root (use sudo)."
  exit 1
fi

echo "Installing TastaturTraining to $TARGET_DIR"

# Copy project to target (preserve permissions)
rsync -a --delete --exclude='.git' --exclude='*.pyc' ./ "$TARGET_DIR/"

# Ensure wrapper is executable
chmod +x "$TARGET_DIR/bin/run_tastaturtraining.sh" || true

# Install a small launcher in /usr/local/bin for easy Exec usage
cat > /usr/local/bin/tastaturtraining <<'EOF'
#!/usr/bin/env bash
exec "$TARGET_DIR/bin/run_tastaturtraining.sh" "$@"
EOF
chmod +x /usr/local/bin/tastaturtraining

# Install system-wide desktop entry
DESKTOP_PATH="/usr/share/applications/tastaturtraining.desktop"
cat > "$DESKTOP_PATH" <<EOF
[Desktop Entry]
Type=Application
Name=TastaturTraining
Comment=Run Tastatur Training (terminal)
Exec=/usr/local/bin/tastaturtraining
Icon=utilities-terminal
Terminal=true
Categories=Utility;
StartupNotify=true
EOF

chmod 644 "$DESKTOP_PATH"

# If installer was run via sudo, place a launcher on that user's Desktop too
INSTALL_USER="${SUDO_USER:-$(logname 2>/dev/null || echo root)}"
USER_DESKTOP="/home/$INSTALL_USER/Desktop/tastaturtraining.desktop"
if [[ -d "/home/$INSTALL_USER/Desktop" ]]; then
  cp "$DESKTOP_PATH" "$USER_DESKTOP" || true
  chown "$INSTALL_USER":"$INSTALL_USER" "$USER_DESKTOP" || true
  chmod +x "$USER_DESKTOP" || true
  echo "Copied desktop launcher to $USER_DESKTOP"
else
  echo "Note: Desktop folder for user $INSTALL_USER not found; skipping per-user Desktop copy."
fi

echo "Installation complete. You can launch 'TastaturTraining' from the applications menu or run 'tastaturtraining' in terminal."

exit 0
