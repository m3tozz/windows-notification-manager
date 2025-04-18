@echo off
net session >nul 2>&1 || (
    echo This file needs to be run with administrator privileges.
    powershell -ExecutionPolicy Bypass -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

echo [1] Turn off Notifications
echo [2] Turn on Notifications

CHOICE /C 12 /M "Please make a choice:"

IF %ERRORLEVEL%==1 (
    reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
    gpupdate /force
    taskkill /f /im explorer.exe
    start explorer.exe
    echo Notifications are turned off.
) 

IF %ERRORLEVEL%==2 (
    reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 0 /f
    gpupdate /force
    taskkill /f /im explorer.exe
    start explorer.exe
    echo Notifications are turned on.
)

pause
