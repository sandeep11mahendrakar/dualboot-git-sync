@echo off
echo ------ GIT SYNC START ------

REM ===== CONFIGURATION =====
REM Change this path to your project directory
cd /d "C:\Path\To\Your\Project"

ping -n 1 github.com >nul
if errorlevel 1 (
    echo No internet connection. Sync cancelled.
    pause
    exit /b
)

echo Pulling latest changes...
git pull --rebase
if errorlevel 1 (
    echo Pull failed. Possible conflict. Fix manually.
    pause
    exit /b
)

echo Adding changes...
git add .

git diff --cached --quiet
if errorlevel 1 (
    echo Committing changes...
    git commit -m "Manual sync %date% %time%"
    echo Pushing to GitHub...
    git push
    echo Sync completed successfully.
) else (
    echo No changes to commit.
)

echo ------ GIT SYNC END ------
pause
