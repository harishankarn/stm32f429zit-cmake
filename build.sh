#!/bin/bash

# ====== FOR UNIX MACHINE =====
MODE=$1
DOCKER_PATH=/app
DOCKER_IMAGE=stm32-compiler

if [ "${MODE}" != "host" ] && [ "${MODE}" != "docker" ]; then
    echo "Usage: ./build.sh [host|docker]"
    exit 1
fi

echo ""
echo "=== STM32 Build Script ==="
echo "Build mode: ${MODE}"
echo "----------------------------------"
echo ""

echo "Cleaning build directory..."
./cleanup.sh
echo "Cleanup done."
echo "----------------------------------"
echo ""

if [ "${MODE}" == "docker" ]; then
    echo "Running inside Docker container..."
	echo "---> Make sure Docker Daemon is running <---"
    docker run -it --rm --name stm32_container -v "$(pwd)":$DOCKER_PATH $DOCKER_IMAGE

elif [ "${MODE}" == "host" ]; then
    echo "Running native CMake build on host..."

    echo "=== Running cmake -B build ==="
    cmake -B build
    echo "=== Running cmake --build build ==="
    cmake --build build
    echo "=== Build DONE ==="
fi

