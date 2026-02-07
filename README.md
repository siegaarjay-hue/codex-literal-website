# www-codex

Simple static download page served from Termux.

## Files

- `index.html` - download page
- `start.sh` - starts a background server
- `stop.sh` - stops the background server
- `serve.sh` - runs a foreground server
- `selftest.sh` - local endpoint and file integrity checks

## Usage

Start server:

```bash
bash start.sh
```

Stop server:

```bash
bash stop.sh
```

Run self-test:

```bash
bash selftest.sh
```

## Notes

- Put `Codex.dmg` in this directory before sharing downloads.
- `Codex.dmg` is ignored by git on purpose.

