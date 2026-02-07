# Android Setup (Termux)

This guide is for phone users.

## 1. Install Termux

Use F-Droid release if possible, then open Termux.

## 2. Install dependencies

```bash
pkg update -y
pkg upgrade -y
pkg install -y nodejs-lts git
```

Verify:

```bash
node -v
npm -v
```

## 3. Give storage permission (optional but recommended)

```bash
termux-setup-storage
```

## 4. Go to the project folder

```bash
cd /path/to/codex-literal-website
```

## 5. Install project packages

```bash
npm install
```

## 6. Start server

```bash
npm run start
npm run status
```

Open on phone browser: `http://127.0.0.1:8000/`

## 7. Add your files

Put downloadable files in `downloads/`.

## 8. Stop server

```bash
npm run stop
```

## Optional one-command setup

```bash
bash scripts/termux-bootstrap.sh
```

Auto-start after install:

```bash
bash scripts/termux-bootstrap.sh --start
```

## Troubleshooting

`EACCES` or permission issues
- Make sure you are inside your home directory and rerun commands.

Port is busy
- Use another port:
- `PORT=8080 npm run start`

Node is old
- Run `pkg upgrade -y` and reinstall Node:
- `pkg install -y nodejs-lts`
