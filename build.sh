#!/usr/bin/env bash
set -e

VERSION=$(cat VERSION)

echo "======================================"
echo " Building NextExplorer sysext v${VERSION}"
echo "======================================"

# Arbeitsverzeichnisse
rm -rf dist release
mkdir -p dist release

# Dateien kopieren
cp -a sysext/. dist/

# SquashFS-Image erzeugen
mksquashfs dist release/nextexplorer.raw \
    -noappend \
    -comp xz

# Prüfsumme erzeugen
sha256sum release/nextexplorer.raw > release/SHA256SUMS

echo
echo "Build erfolgreich abgeschlossen."
echo
ls -lh release/
