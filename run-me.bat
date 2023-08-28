@echo off
echo Administrative permissions required. Detecting permissions...
echo.

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
    echo.
) else (
    echo Failure: Current permissions inadequate.

    pause

    exit
)

set relativePath=%~dp0

echo "%relativePath%bulk-edit-settings.ps1"

pwsh -NoProfile -ExecutionPolicy Bypass -File "%relativePath%bulk-edit-settings.ps1"

exit