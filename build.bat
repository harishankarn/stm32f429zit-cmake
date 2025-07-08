 :: ====== FOR DOS MACHINE =====
@echo off
set MODE=%1
set DOCKER_PATH=/app
set DOCKER_IMAGE=stm32-compiler

if "%MODE%" NEQ "host" if "%MODE%" NEQ "docker" (
    echo Usage: build.bat [host|docker]
    exit /b 1
)

echo.
echo === STM32 Build Script ===
echo Build mode: %MODE%
echo ----------------------------------
echo.

echo Cleaning build directory...
call cleanup.bat
echo Cleanup done.
echo ----------------------------------
echo.

if "%MODE%"=="docker" (
    echo Running inside Docker container...
    echo ---> Make sure Docker Daemon is running <---
    docker run -it --rm --name stm32_container -v "%cd%":%DOCKER_PATH% %DOCKER_IMAGE%
) else if "%MODE%"=="host" (
    echo Running native CMake build on host...
    echo === Running cmake -B build ===
    cmake -B build
    echo === Running cmake --build build ===
    cmake --build build
    echo === Build DONE ===
)
