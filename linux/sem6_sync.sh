#!/bin/bash

LOGFILE="$HOME/sem6_sync.log"
REPO_PATH="path/to/your/folder"   # <-- CHANGE THIS

exec > >(tee -a "$LOGFILE") 2>&1

echo "======================================="
echo "SEM6 SYNC START - $(date)"
echo "======================================="

# Safety: check git installed
if ! command -v git &> /dev/null; then
    echo "Git not installed."
    read -p "Press Enter to exit..."
    exit 1
fi

# Move to repo
cd "$REPO_PATH" || {
    echo "Repo path invalid."
    read -p "Press Enter to exit..."
    exit 1
}

# Confirm it's a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not a git repository."
    read -p "Press Enter to exit..."
    exit 1
fi

# Fix dual boot permission noise
git config core.fileMode false
git config pull.rebase true

# Refresh index (prevents false changes)
git update-index -q --refresh

# Detect local changes
if ! git diff-index --quiet HEAD --; then
    echo "Local changes detected."
    git add .

    if ! git commit -m "Auto-sync commit $(date +'%Y-%m-%d %H:%M:%S')"; then
        echo "Commit failed."
        read -p "Press Enter to exit..."
        exit 1
    fi
fi

echo "Fetching remote..."
if ! git fetch; then
    echo "Fetch failed."
    read -p "Press Enter to exit..."
    exit 1
fi

echo "Rebasing..."
if ! git pull --rebase; then
    echo "Rebase conflict detected."
    echo "Fix conflicts manually, then run sync again."
    read -p "Press Enter to exit..."
    exit 1
fi

echo "Pushing..."
if ! git push; then
    echo "Push failed."
    read -p "Press Enter to exit..."
    exit 1
fi

echo "======================================="
echo "SYNC SUCCESSFUL"
echo "======================================="

sleep 2   # auto-close after 2 seconds on success
