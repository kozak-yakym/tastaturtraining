#!/usr/bin/env bash
# Wrapper to run tastaturtraining from the project directory so relative paths work
set -euo pipefail

# Change this if you move the project
PROJECT_DIR="/home/andrii/Work/tastaturtraining"

cd "$PROJECT_DIR" || exit 1

# Run the script with the system python3
exec python3 "$PROJECT_DIR/tastaturtraining.py"
