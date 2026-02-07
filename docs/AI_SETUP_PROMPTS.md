# AI Setup Prompts

Use one prompt below with your preferred AI assistant.

## Universal Prompt (Zero to Running)

```text
I am a beginner and starting from zero.
Repository link: https://github.com/siegaarjay-hue/codex-literal-website
My operating system is: <Windows / macOS / Linux / Android with Termux>.
Assume I have NOT cloned the repo yet.

Give exact commands only, step by step, with expected output checks.
Do everything end-to-end:
1) install or verify Git and Node.js 20+
2) clone this exact repository link
3) cd into the project
4) npm install
5) npm run start
6) open correct local URL
7) npm run stop
8) troubleshoot common errors

Use this format for each step:
- Step
- Command
- Expected output
```

## Windows Prompt

```text
I am on Windows 11. I am a beginner and starting from zero.
Repository link: https://github.com/siegaarjay-hue/codex-literal-website
Use PowerShell commands only.
Assume I have NOT cloned the repo yet.
Give exact commands from install to running app.
Include clone command, npm install, npm run start, local URL, npm run stop,
and fixes for PATH or execution policy issues.
```

## macOS Prompt

```text
I am on macOS. I am a beginner and starting from zero.
Repository link: https://github.com/siegaarjay-hue/codex-literal-website
Use zsh/bash commands only.
Assume I have NOT cloned the repo yet.
Include Homebrew install commands if Git or Node.js is missing.
Give exact steps to clone, install, start, open local URL, and stop.
```

## Linux Prompt

```text
I am on Linux. I am a beginner and starting from zero.
Repository link: https://github.com/siegaarjay-hue/codex-literal-website
Use shell commands only.
Assume I have NOT cloned the repo yet.
Include install options for apt and dnf if Git or Node.js is missing.
Give exact steps to clone, install, start, open local URL, and stop.
```

## Android + Termux Prompt

```text
I am on Android using Termux. I am a beginner and starting from zero.
Repository link: https://github.com/siegaarjay-hue/codex-literal-website
Assume I have NOT cloned the repo yet.

Give exact Termux commands only for:
1) pkg update/upgrade
2) install git and nodejs-lts
3) termux-setup-storage
4) git clone the repository link
5) cd into project
6) npm install
7) npm run start
8) open local URL on phone browser
9) npm run stop

Add troubleshooting for:
- npm not found
- permissions/storage issues
- port already in use
```
