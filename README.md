# Codex Literal Website

[![CI](https://github.com/siegaarjay-hue/codex-literal-website/actions/workflows/ci.yml/badge.svg)](https://github.com/siegaarjay-hue/codex-literal-website/actions/workflows/ci.yml)

A professional, cross-platform artifact download portal built for reliable file delivery.

## Highlights

- Cross-platform runtime (Linux, macOS, Windows)
- Background or foreground server modes
- Download manifest API with SHA256 checksums
- HTTP range support for resumable downloads
- Automated test suite and CI matrix validation

## Quick Start

1. Install Node.js 20+.
2. Place release files in `downloads/`.
3. Run:

```bash
npm install
npm run start
npm run status
```

Server defaults to `http://127.0.0.1:8000/`.

### Foreground mode

```bash
npm run serve
```

### Stop background mode

```bash
npm run stop
```

## Validation

Run unit tests:

```bash
npm test
```

Run end-to-end self-test:

```bash
npm run selftest
```

Run both:

```bash
npm run check
```

## Legacy Compatibility

The server still supports a top-level `Codex.dmg` file for backward compatibility, but new files should live in `downloads/`.

## Project Layout

- `index.html` - landing page
- `assets/` - front-end styles and scripts
- `scripts/server.mjs` - HTTP server implementation
- `scripts/codex-web.mjs` - operational CLI (`serve/start/stop/status/selftest`)
- `tests/` - automated test suite
- `.github/workflows/ci.yml` - multi-OS CI

## Platform Notes

- Windows: use PowerShell, CMD, or Git Bash with `npm run ...` commands.
- macOS/Linux: any shell is fine.
- CI validates all core flows on `ubuntu-latest`, `macos-latest`, and `windows-latest`.

## Security

See `SECURITY.md` for reporting guidance.

## License

MIT - see `LICENSE`.
