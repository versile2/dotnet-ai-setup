@echo off
setlocal EnableExtensions

if "%~1"=="" (
    echo Usage: %~nx0 TARGET_DIRECTORY
    exit /b 1
)

set "SCRIPT_DIR=%~dp0"
for %%I in ("%~1") do set "TARGET_DIR=%%~fI"

if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%" || exit /b 1
)

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "TIMESTAMP=%%I"

for %%F in (
    ".gitattributes"
    ".gitignore"
    "AGENTS.md"
    "AI_REVIEW.md"
    "PROJECTS.md"
    ".github\copilot-instructions.md"
    ".github\instructions\tests.instructions.md"
    ".github\pull_request_template.md"
    "src\.editorconfig"
    "src\Directory.Build.props"
) do (
    call :CopyRelativePath "%%~F"
    if errorlevel 1 exit /b 1
)

exit /b 0

:CopyRelativePath
set "RELATIVE_PATH=%~1"
set "SOURCE_PATH=%SCRIPT_DIR%%RELATIVE_PATH%"
set "DESTINATION_PATH=%TARGET_DIR%\%RELATIVE_PATH%"

if not exist "%SOURCE_PATH%" (
    echo Missing source file: %RELATIVE_PATH%
    exit /b 1
)

for %%I in ("%DESTINATION_PATH%") do set "DESTINATION_DIR=%%~dpI"

if not exist "%DESTINATION_DIR%" (
    mkdir "%DESTINATION_DIR%" || exit /b 1
)

if exist "%DESTINATION_PATH%" (
    move /Y "%DESTINATION_PATH%" "%DESTINATION_PATH%.old%TIMESTAMP%" >nul || exit /b 1
)

copy /Y "%SOURCE_PATH%" "%DESTINATION_PATH%" >nul || exit /b 1
echo Copied %RELATIVE_PATH%
exit /b 0
