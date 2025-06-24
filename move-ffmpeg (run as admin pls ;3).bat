@echo off
cd /d "%~dp0"
setlocal

set "sourceFolder=%cd%\ffmpeg"
set "targetFolder=C:\Windows\ffmpeg"

:: Check for admin rights
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Please run this script as Administrator!
    pause
    exit /b 1
)

:: Check source folder exists
if not exist "%sourceFolder%" (
    echo ERROR: Folder "%sourceFolder%" not found.
    echo Please place this script inside the folder that contains the 'ffmpeg' folder.
    pause
    exit /b 1
)

:: Check target folder
if exist "%targetFolder%" (
    echo WARNING: Target folder "%targetFolder%" already exists.
    echo It will be deleted and replaced. Continue? (Y/N)
    set /p confirm=
    if /i not "%confirm%"=="Y" (
        echo Operation cancelled.
        pause
        exit /b 1
    )
    rmdir /s /q "%targetFolder%"
)

:: Move folder
move "%sourceFolder%" "%targetFolder%"
if errorlevel 1 (
    echo ERROR: Failed to move folder. Check permissions.
    pause
    exit /b 1
) else (
    echo Success! Moved ffmpeg to %targetFolder%
)

pause
endlocal
