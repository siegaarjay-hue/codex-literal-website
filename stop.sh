#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"
PID_FILE="${PID_FILE:-server.pid}"

if [[ ! -f "$PID_FILE" ]]; then
  echo "Not running (no $PID_FILE)."
  exit 0
fi

pid="$(cat "$PID_FILE" 2>/dev/null || true)"
if [[ -z "${pid:-}" ]]; then
  rm -f "$PID_FILE"
  echo "Not running."
  exit 0
fi

if ! kill -0 "$pid" 2>/dev/null; then
  rm -f "$PID_FILE"
  echo "Not running."
  exit 0
fi

kill "$pid" 2>/dev/null || true
for _ in {1..20}; do
  if ! kill -0 "$pid" 2>/dev/null; then
    rm -f "$PID_FILE"
    echo "Stopped."
    exit 0
  fi
  sleep 0.1
done

kill -9 "$pid" 2>/dev/null || true
rm -f "$PID_FILE"
echo "Stopped (forced)."

