🚀 DualBoot Git Sync

A safe, deterministic, one-click Git synchronization utility designed for dual-boot developers (Linux + Windows + macOS).

This tool standardizes your workflow across operating systems and prevents common sync errors.

🎯 Problem Statement

Dual-boot development introduces recurring issues:

Forgetting to pull before working

Conflicts caused by unsynced edits

Repetitive Git commands

Inconsistent Git configurations across OS

File permission noise (especially NTFS)

Manual synchronization increases friction and error probability.

✅ Solution

DualBoot Git Sync provides a controlled, explicit synchronization model:

Each sync operation performs:

git pull --rebase

git add .

git commit (only if changes exist)

git push

All triggered intentionally by the developer.

No background automation. No silent commits.

🧠 Design Philosophy

❌ No automatic push on shutdown

❌ No hidden background services

✅ Manual explicit sync

✅ Dirty state detection

✅ Rebase-first workflow

✅ Conflict visibility

✅ Cross-platform parity

✅ NTFS-safe configuration

The developer remains in full control.

📂 Project Structure
dualboot-git-sync/
├── linux/
│   └── sem6_sync.sh
├── windows/
│   └── sem6_sync.bat
├── macos/
│   └── sem6_sync.command
└── README.md
🐧 Linux Setup

Edit REPO_PATH inside sem6_sync.sh

Make executable:

chmod +x sem6_sync.sh

(Optional) Create .desktop launcher.

🪟 Windows Setup

Edit REPO_PATH inside sem6_sync.bat

Create desktop shortcut

(Optional) Assign custom .ico icon

🍎 macOS Setup

Edit REPO_PATH inside sem6_sync.command

Make executable:

chmod +x sem6_sync.command

Double-click to run
(First time: allow via Security & Privacy if blocked)

🔁 Recommended Workflow

On any OS:

Before serious work → Click Sync

After finishing work → Click Sync

Never edit on both OS without syncing first.

⚠ Conflict Handling

If both OS modify the same file without syncing:

Git will pause during rebase

You manually resolve conflicts

No data loss

No silent overwrites

🏗 Architecture
Linux --------─┐
               ├── GitHub (source of truth)
Windows ------─┤
macOS --------─┘

Each OS:

Pulls before work

Pushes after work

📌 Ideal Use Cases

Dual-boot development

Cross-platform coding workflows

Academic environments

Personal productivity optimization

Now let’s fix your macOS script properly.

Your current macOS script is basic. It does not:

Validate Git

Handle dirty state robustly

Handle dual-boot newline issues

Fail safely

Log activity

Let’s upgrade it.
