#!/bin/bash

LOGFILE="$HOME/sem6_sync_macos.log"
REPO_PATH="/Users/yourusername/Path/To/Your/Project"  # <-- CHANGE THIS

exec > >(tee -a "$LOGFILE") 2>&1

echo "======================================="
echo "SEM6 SYNC START - $(date)"
echo "======================================="

# Check Git installed
if ! command -v git &> /dev/null; then
    echo "Git not installed."
    read -p "Press Enter to exit..."
    exit 1
fi

# Move to repo
cd "$REPO_PATH" || {
    echo "Repo path invalid: $REPO_PATH"
    read -p "Press Enter..."
    exit 1
}

# Confirm Git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not a git repository."
    read -p "Press Enter..."
    exit 1
fi

# Safe configuration
git config core.fileMode false
git config core.autocrlf false
git config pull.rebase true

# Refresh index
git update-index -q --refresh

# Detect local changes
if ! git diff-index --quiet HEAD --; then
    echo "Local changes detected. Committing..."
    git add .
    git commit -m "auto-sync: $(date +'%Y-%m-%d %H:%M')"
    if [ $? -ne 0 ]; then
        echo "Commit failed."
        read -p "Press Enter..."
        exit 1
    fi
fi

# Fetch
echo "Fetching remote..."
git fetch
if [ $? -ne 0 ]; then
    echo "Fetch failed."
    read -p "Press Enter..."
    exit 1
fi

# Pull (rebase)
echo "Rebasing..."
git pull --rebase
if [ $? -ne 0 ]; then
    echo "Rebase conflict detected."
    echo "Resolve conflicts and run again."
    read -p "Press Enter..."
    exit 1
fi

# Push
echo "Pushing..."
git push
if [ $? -ne 0 ]; then
    echo "Push failed."
    read -p "Press Enter..."
    exit 1
fi

echo "======================================="
echo "SYNC SUCCESSFUL"
echo "======================================="

read -p "Press Enter to close..."
