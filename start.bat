@echo off
setlocal

cls

REM Check if Node.js is installed by checking the version
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed. Installing via winget...
    winget install OpenJS.NodeJS

    REM Check if the installation was successful
    if %errorlevel% neq 0 (
        echo Failed to install Node.js. Please install it manually.
        exit /b 1
    )

    echo Node.js has been installed. Please reboot your system for the changes to take effect.
    exit /b 0
) else (
    echo Node.js is already installed.
    echo Running "npm install"...
    npm install

    echo Starting the server...
    node server.js
)

endlocal
