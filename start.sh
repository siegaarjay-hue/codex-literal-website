#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

PORT="${PORT:-8000}"
BIND="${BIND:-0.0.0.0}"
PID_FILE="${PID_FILE:-server.pid}"
LOG_FILE="${LOG_FILE:-server.log}"

if [[ -f "$PID_FILE" ]]; then
  existing_pid="$(cat "$PID_FILE" 2>/dev/null || true)"
  if [[ -n "${existing_pid:-}" ]] && kill -0 "$existing_pid" 2>/dev/null; then
    echo "Already running (PID $existing_pid)"
    exit 0
  fi
fi

if ss -ltn "sport = :$PORT" 2>/dev/null | grep -q LISTEN; then
  echo "Port ${PORT} is already in use."
  ss -ltnp "sport = :$PORT" 2>/dev/null || true
  exit 1
fi

server_dir="$(pwd)"
pid_file_abs="${server_dir}/${PID_FILE}"
log_file_abs="${server_dir}/${LOG_FILE}"

if command -v setsid >/dev/null 2>&1; then
  export SERVER_DIR="$server_dir" PORT BIND PID_FILE_ABS="$pid_file_abs"
  setsid -f bash -lc 'cd "$SERVER_DIR"; echo $$ > "$PID_FILE_ABS"; exec python -m http.server "$PORT" --bind "$BIND"' \
    >"$log_file_abs" 2>&1
else
  nohup python -m http.server "${PORT}" --bind "${BIND}" >"$log_file_abs" 2>&1 &
  echo $! >"$pid_file_abs"
fi

for _ in {1..50}; do
  if curl -fsS "http://127.0.0.1:${PORT}/" >/dev/null 2>&1; then
    break
  fi
  if [[ -f "$pid_file_abs" ]]; then
    pid_now="$(cat "$pid_file_abs" 2>/dev/null || true)"
    if [[ -n "${pid_now:-}" ]] && ! kill -0 "$pid_now" 2>/dev/null; then
      echo "Server exited. Log:"
      tail -n 200 "$log_file_abs" 2>/dev/null || true
      exit 1
    fi
  fi
  sleep 0.1
done

if ! curl -fsS "http://127.0.0.1:${PORT}/" >/dev/null 2>&1; then
  echo "Server did not become reachable on http://127.0.0.1:${PORT}/"
  tail -n 200 "$log_file_abs" 2>/dev/null || true
  exit 1
fi

if [[ ! -f "$pid_file_abs" ]]; then
  echo "Missing pid file: $pid_file_abs" >&2
  exit 1
fi

echo "Started (PID $(cat "$PID_FILE" 2>/dev/null || true))"
echo "  http://127.0.0.1:${PORT}/"
ip route get 1.1.1.1 2>/dev/null | sed -n "s/.* src \\([^ ]\\+\\).*/  http:\\/\\/\\1:${PORT}\\//p" || true
