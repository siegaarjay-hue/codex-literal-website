#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

local_file="Codex.dmg"
if [[ ! -e "$local_file" ]]; then
  echo "Missing ${local_file} in $(pwd)"
  exit 1
fi

local_size="$(wc -c "$local_file" | awk '{print $1}')"
local_sha256="$(sha256sum "$local_file" | awk '{print $1}')"

pick_port() {
  for _ in {1..50}; do
    p=$((18000 + RANDOM % 2000))
    if ! ss -ltn "sport = :$p" 2>/dev/null | grep -q LISTEN; then
      echo "$p"
      return 0
    fi
  done
  echo "Failed to find free port" >&2
  return 1
}

PORT="$(pick_port)"
BIND="127.0.0.1"
base_url="http://${BIND}:${PORT}"

tmpdir="$(mktemp -d)"
cleanup() {
  if [[ -n "${pid:-}" ]] && kill -0 "$pid" 2>/dev/null; then
    kill "$pid" 2>/dev/null || true
  fi
  rm -rf "$tmpdir"
}
trap cleanup EXIT

python -m http.server "$PORT" --bind "$BIND" >"$tmpdir/server.log" 2>&1 &
pid=$!

for _ in {1..50}; do
  if curl -fsS "$base_url/" >/dev/null 2>&1; then
    break
  fi
  sleep 0.1
done

echo "[1/5] GET /"
curl -fsS "$base_url/" >/dev/null

echo "[2/5] HEAD /Codex.dmg (size)"
remote_size="$(curl -fsSI "$base_url/$local_file" | awk -F': ' 'tolower($1)=="content-length"{print $2}' | tr -d '\r')"
if [[ "$remote_size" != "$local_size" ]]; then
  echo "Content-Length mismatch: remote=$remote_size local=$local_size" >&2
  exit 1
fi

echo "[3/5] Range request (first 1024 bytes)"
curl -sS -D "$tmpdir/range.headers" -o /dev/null \
  -H 'Range: bytes=0-1023' --max-filesize 2048 \
  "$base_url/$local_file" >/dev/null 2>&1 || true
range_code="$(awk 'NR==1{print $2}' "$tmpdir/range.headers" 2>/dev/null || true)"
if [[ "$range_code" == "206" ]]; then
  echo "Range supported (206)."
elif [[ "$range_code" == "200" ]]; then
  echo "Range not supported (server returned 200); still OK for downloads."
else
  echo "Unexpected/unknown range response: ${range_code:-"(none)"}" >&2
  sed -n '1,20p' "$tmpdir/range.headers" 2>/dev/null || true
  exit 1
fi

echo "[4/5] Full download SHA256 (stream)"
remote_sha256="$(curl -fsS "$base_url/$local_file" | sha256sum | awk '{print $1}')"
if [[ "$remote_sha256" != "$local_sha256" ]]; then
  echo "SHA256 mismatch: remote=$remote_sha256 local=$local_sha256" >&2
  exit 1
fi

echo "[5/5] OK"
