#!/usr/bin/env bash
set -e

APP_NAME="nextexplorer"
APPDATA="/DATA/AppData/${APP_NAME}"
COMPOSE_DIR="${APPDATA}/compose"

echo "======================================"
echo " Installing ${APP_NAME}"
echo "======================================"

# Docker prüfen
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker ist nicht installiert."
    exit 1
fi

# Docker Compose prüfen
if docker compose version >/dev/null 2>&1; then
    COMPOSE="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
    COMPOSE="docker-compose"
else
    echo "Docker Compose wurde nicht gefunden."
    exit 1
fi

echo "Erstelle Verzeichnisse..."
mkdir -p "${APPDATA}/config"
mkdir -p "${APPDATA}/cache"
mkdir -p "${COMPOSE_DIR}"

echo "Kopiere docker-compose.yml..."
cp files/opt/nextexplorer/docker-compose.yml \
   "${COMPOSE_DIR}/docker-compose.yml"

cd "${COMPOSE_DIR}"

echo "Lade aktuelles Image..."
$COMPOSE pull

echo "Starte NextExplorer..."
$COMPOSE up -d

echo
echo "======================================"
echo " Installation abgeschlossen!"
echo "======================================"
echo
echo "NextExplorer sollte erreichbar sein unter:"
echo
echo "http://<IP-DEINES-ZIMAOS>:6000"
