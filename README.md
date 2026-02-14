# 🚀 DualBoot Git Sync

A simple, safe, one-click Git synchronization system for developers using **dual-boot environments (Linux + Windows)**.

This tool automates:

- `git pull --rebase`
- `git add .`
- `git commit` (only if changes exist)
- `git push`

All with a single click.

---

## 🎯 Problem

Developers working in dual-boot systems often face:

- Forgetting to pull before working
- Conflicts from unsynced changes
- Manual repetitive Git commands
- SSH inconsistencies between OS environments

This project provides a controlled, one-click sync workflow to eliminate friction.

---

## 🧠 Design Philosophy

- ❌ No auto-push on shutdown (dangerous)
- ❌ No hidden background automation
- ✅ Explicit manual sync button
- ✅ Safe conflict detection
- ✅ Internet connectivity check
- ✅ Cross-platform compatibility

---

## 📂 Project Structure

dualboot-git-sync/
├── linux/
│ └── sem6_sync.sh
├── windows/
│ └── sem6_sync.bat
├── macos/
│ └── sem6_sync.command
└── README.md

--------------------------------------------------------------------------------------------

## 🐧 Linux Setup

1. Edit `PROJECT` path inside `sem6_sync.sh`
2. Make executable:

```bash
chmod +x sem6_sync.sh

🪟 Windows Setup

Edit the project path inside sem6_sync.bat

Create a desktop shortcut

(Optional) Assign custom .ico icon

🔁 Recommended Workflow

On any OS:

Before serious work → Click Sync

After finishing work → Click Sync

If work is temporary or experimental → Do not sync.

⚠ Conflict Handling

If both operating systems modify the same file without syncing:

Git will pause

You manually resolve the conflict

No data is lost

No silent overwrites

--------------------------------------------------------------------------------------------
🏗 Architecture

Linux --------─┐
               ├── GitHub (central source of truth)
Windows/macos -┘



Each OS:

Pulls before work

Pushes after work

💡 Why Not Fully Automatic?

Automatic background Git push can:

Push unfinished work

Fail during shutdown

Cause silent merge issues

This system keeps the developer in control.

📌 Use Cases

Dual boot development setups

Cross-platform coding environments

Academic projects across OS

Personal workflow optimization




