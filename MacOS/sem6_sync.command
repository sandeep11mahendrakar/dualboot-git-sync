#!/bin/bash

# ===== CONFIGURATION =====
PROJECT="/Users/yourusername/Path/To/Your/Project"
# Example:
# PROJECT="/Users/sandeep/Documents/sem6"

echo "------ GIT SYNC START ------"

# Check internet connectivity
ping -c 1 github.com > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "No internet connection. Sync cancelled."
    exit 1
fi

cd "$PROJECT" || exit 1

echo "Pulling latest changes..."
git pull --rebase
if [ $? -ne 0 ]; then
    echo "Pull failed. Possible conflict. Fix manually."
    exit 1
fi

echo "Adding changes..."
git add .

if ! git diff --cached --quiet; then
    echo "Committing changes..."
    git commit -m "Manual sync $(date)"
    echo "Pushing to GitHub..."
    git push
    echo "Sync completed successfully."
else
    echo "No changes to commit."
fi

echo "------ GIT SYNC END ------"
