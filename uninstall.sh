#!/usr/bin/env bash
set -e

APP_NAME="nextexplorer"
APPDATA="/DATA/AppData/${APP_NAME}"
COMPOSE_DIR="${APPDATA}/compose"

echo "======================================"
echo " Uninstall ${APP_NAME}"
echo "======================================"

if docker compose version >/dev/null 2>&1; then
    COMPOSE="docker compose"
elif command -v docker-compose >/dev/null 2>&1; then
    COMPOSE="docker-compose"
else
    echo "Docker Compose nicht gefunden."
    exit 1
fi

if [ -f "${COMPOSE_DIR}/docker-compose.yml" ]; then
    cd "${COMPOSE_DIR}"
    $COMPOSE down
fi

echo
read -p "AppData löschen? (y/N): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    rm -rf "${APPDATA}"
    echo "AppData entfernt."
else
    echo "AppData bleibt erhalten."
fi

echo
echo "NextExplorer wurde entfernt."
