#!/usr/bin/env bash
set -euo pipefail

# Create a portable tar.gz package of the project excluding VCS and pyc files
# Usage: ./create_package.sh [OUTPUT_FILE]

OUT="${1:-tastaturtraining.tar.gz}"
PKGNAME="tastaturtraining"

echo "Creating package $OUT"

# create temporary directory to stage the package with a top-level folder
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

mkdir -p "$tmpdir/$PKGNAME"
rsync -a --exclude='.git' --exclude='*.pyc' --exclude='__pycache__' ./ "$tmpdir/$PKGNAME/"

(cd "$tmpdir" && tar -czf "$PWD/../$OUT" "$PKGNAME")
mv "$tmpdir/../$OUT" .

echo "Package created: $OUT"

exit 0
