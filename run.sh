#!/usr/bin/env bash
set -euo pipefail

# Simple launcher: change to project directory and run the script with python3
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

exec python3 tastaturtraining.py
