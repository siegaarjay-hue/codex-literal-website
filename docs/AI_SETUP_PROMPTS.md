# AI Setup Prompts

Use one prompt below with your preferred AI assistant.
Replace `<REPO_URL>` with your actual repository URL before sending.

## Universal Autonomous Prompt (AI Does Everything)

```text
You are an autonomous setup agent with terminal access.
Do the full setup yourself end-to-end.
Do NOT ask me to run commands manually unless permissions block you.

I am a beginner and starting from zero.
Repository link: <REPO_URL>
My operating system is: <Windows / macOS / Linux / Android with Termux>.
Assume I have NOT cloned the repo yet.

Requirements:
- Execute commands directly.
- If something fails, troubleshoot and continue.
- Finish only when app is running and verified.

Flow:
1) install or verify Git and Node.js 20+
2) clone this exact repository link
3) cd into the project
4) npm install
5) npm run start
6) verify GET /healthz succeeds
7) run npm run selftest
8) report final URL and status
9) show stop command: npm run stop
```

## Windows Autonomous Prompt

```text
You are an autonomous setup agent with terminal access on Windows 11.
Execute all commands yourself in PowerShell.
Do not ask me to run commands manually unless permissions block you.

I am a beginner and starting from zero.
Repository link: <REPO_URL>
Assume I have NOT cloned the repo yet.

Do end-to-end setup and verification:
- install/check git + node 20+
- clone repo
- npm install
- npm run start
- verify /healthz
- npm run selftest
- report URL
- show npm run stop
```

## macOS Autonomous Prompt

```text
You are an autonomous setup agent with terminal access on macOS.
Execute all commands yourself in zsh/bash.
Do not ask me to run commands manually unless permissions block you.

I am a beginner and starting from zero.
Repository link: <REPO_URL>
Assume I have NOT cloned the repo yet.

Do end-to-end setup and verification:
- check/install git + node 20+ (Homebrew if needed)
- clone repo
- npm install
- npm run start
- verify /healthz
- npm run selftest
- report URL
- show npm run stop
```

## Linux Autonomous Prompt

```text
You are an autonomous setup agent with terminal access on Linux.
Execute all commands yourself in shell.
Do not ask me to run commands manually unless permissions block you.

I am a beginner and starting from zero.
Repository link: <REPO_URL>
Assume I have NOT cloned the repo yet.

Do end-to-end setup and verification:
- check/install git + node 20+ (apt or dnf)
- clone repo
- npm install
- npm run start
- verify /healthz
- npm run selftest
- report URL
- show npm run stop
```

## Android + Termux Autonomous Prompt

```text
You are an autonomous setup agent with Termux terminal access on Android.
Execute all commands yourself in Termux.
Do not ask me to run commands manually unless permissions block you.

I am a beginner and starting from zero.
Repository link: <REPO_URL>
Assume I have NOT cloned the repo yet.

Do end-to-end setup and verification:
1) pkg update/upgrade
2) install git and nodejs-lts
3) termux-setup-storage
4) git clone the repository link
5) cd into project
6) npm install
7) npm run start
8) verify /healthz
9) npm run selftest
10) report local URL for phone browser
11) show npm run stop
```
