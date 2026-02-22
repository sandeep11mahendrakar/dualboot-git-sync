@echo off
setlocal enabledelayedexpansion

echo =======================================
echo SEM6 SYNC START - %date% %time%
echo =======================================

REM ===== CONFIGURATION =====
set "REPO_PATH=C:\Path\To\Your\Project"
set "LOGFILE=%USERPROFILE%\sem6_sync_windows.log"

REM ===== Logging Setup =====
echo. >> "%LOGFILE%"
echo ===== %date% %time% ===== >> "%LOGFILE%"

REM ===== Check Git Installed =====
where git >nul 2>&1
if errorlevel 1 (
    echo Git not installed or not in PATH.
    echo Git not installed. >> "%LOGFILE%"
    pause
    exit /b 1
)

REM ===== Move to Repo =====
cd /d "%REPO_PATH%" 2>nul
if errorlevel 1 (
    echo Repo path invalid: %REPO_PATH%
    echo Invalid repo path. >> "%LOGFILE%"
    pause
    exit /b 1
)

REM ===== Confirm Git Repo =====
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not a git repository.
    echo Not a git repo. >> "%LOGFILE%"
    pause
    exit /b 1
)

REM ===== Dual Boot Safe Settings =====
git config core.fileMode false
git config pull.rebase true

REM ===== Refresh Index =====
git update-index -q --refresh

REM ===== Detect Local Changes =====
git diff-index --quiet HEAD --
if errorlevel 1 (
    echo Local changes detected. Committing...
    git add .
    git commit -m "auto-sync %date% %time%"
    if errorlevel 1 (
        echo Commit failed.
        echo Commit failed. >> "%LOGFILE%"
        pause
        exit /b 1
    )
)

REM ===== Fetch =====
echo Fetching remote...
git fetch
if errorlevel 1 (
    echo Fetch failed.
    echo Fetch failed. >> "%LOGFILE%"
    pause
    exit /b 1
)

REM ===== Pull (Rebase) =====
echo Rebasing...
git pull --rebase
if errorlevel 1 (
    echo Rebase conflict detected. Fix manually.
    echo Rebase conflict. >> "%LOGFILE%"
    pause
    exit /b 1
)

REM ===== Push =====
echo Pushing...
git push
if errorlevel 1 (
    echo Push failed. Check internet/auth.
    echo Push failed. >> "%LOGFILE%"
    pause
    exit /b 1
)

echo =======================================
echo SYNC SUCCESSFUL
echo =======================================

echo Sync successful. >> "%LOGFILE%"

timeout /t 2 >nul
exit /b 0
