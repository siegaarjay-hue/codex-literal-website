#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"
PORT="${PORT:-8000}"
BIND="${BIND:-0.0.0.0}"

echo "Serving on:"
echo "  http://127.0.0.1:${PORT}/"
ip route get 1.1.1.1 2>/dev/null | sed -n "s/.* src \\([^ ]\\+\\).*/  http:\\/\\/\\1:${PORT}\\//p" || true
echo
exec python -m http.server "${PORT}" --bind "${BIND}"
