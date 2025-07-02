#!/bin/bash

# Remove build directory
if [ -d "./build" ]; then
    rm -r ./build
    echo "Removed ./build"
else
    echo "./build has already been removed"
fi

# Remove CMakeCache.txt
if [ -f "./CMakeCache.txt" ]; then
    rm ./CMakeCache.txt
    echo "Removed ./CMakeCache.txt"
else
    echo "./CMakeCache.txt has already been removed"
fi

