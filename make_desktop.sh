#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./make_desktop.sh [PROJECT_DIR]
# If PROJECT_DIR is omitted, the script uses the current directory.

PROJECT_DIR="${1:-$(pwd)}"
ABS_DIR="$(cd "$PROJECT_DIR" && pwd)"

DEST_DESKTOP="$HOME/Desktop/tastaturtraining.desktop"
LOCAL_APP_DIR="$HOME/.local/share/applications"

mkdir -p "$HOME/Desktop"
mkdir -p "$LOCAL_APP_DIR"

cat > "$DEST_DESKTOP" <<EOF
[Desktop Entry]
Type=Application
Name=TastaturTraining
Comment=Run Tastatur Training (terminal)
Exec=$ABS_DIR/run.sh
Icon=utilities-terminal
Terminal=true
Categories=Utility;
StartupNotify=true
EOF

chmod +x "$DEST_DESKTOP" || true

# Also copy to local applications so it appears in the menu
cp "$DEST_DESKTOP" "$LOCAL_APP_DIR/" || true
chmod 644 "$LOCAL_APP_DIR/tastaturtraining.desktop" || true

echo "Created desktop launcher: $DEST_DESKTOP"
echo "Also copied to: $LOCAL_APP_DIR/tastaturtraining.desktop"

echo "If the desktop file doesn't allow launching, right-click it and choose 'Allow Launching', or run:"
echo "  chmod +x $DEST_DESKTOP"

exit 0
