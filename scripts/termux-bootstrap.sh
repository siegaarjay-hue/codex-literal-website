#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AUTO_START="${1:-}"

if ! command -v pkg >/dev/null 2>&1; then
  echo "This script is for Termux (Android)."
  echo "If you are on desktop, use: npm install && npm run start"
  exit 1
fi

echo "[1/6] Updating Termux packages..."
pkg update -y
pkg upgrade -y

echo "[2/6] Installing dependencies..."
pkg install -y nodejs-lts git

echo "[3/6] Optional storage permission setup..."
if command -v termux-setup-storage >/dev/null 2>&1; then
  termux-setup-storage || true
fi

echo "[4/6] Installing project dependencies..."
cd "$ROOT_DIR"
npm install

echo "[5/6] Ensuring downloads directory exists..."
mkdir -p downloads

echo "[6/6] Setup complete."
if [[ "$AUTO_START" == "--start" ]]; then
  echo "Starting server now..."
  npm run start
  echo "Open: http://127.0.0.1:8000/"
else
  echo "Run: npm run start"
  echo "Then open: http://127.0.0.1:8000/"
fi
