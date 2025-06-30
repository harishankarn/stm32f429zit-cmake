#!/bin/bash

echo ""
echo "=== Running cmake . ==="
cmake .
echo "=== cmake . DONE ==="
echo ""
echo "----------------------------------"
echo ""

echo "=== Running cmake -B build ==="
cmake -B build
echo "=== cmake -B build DONE ==="
echo ""
echo "----------------------------------"
echo ""

echo "=== Running cmake --build build ==="
cmake --build build
echo "=== Build DONE ==="
echo ""
echo "----------------------------------"
echo ""
