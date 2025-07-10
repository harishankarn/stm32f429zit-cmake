# STM32F4 CMake + Docker Project

A modern STM32 firmware build system for the STM32F4 MCU, using **CMake** and **Docker** for portability and toolchain isolation.

---

## 🐳 Docker-Based Build System

No need to install ARM GCC or CMake on your host system. All builds run inside a Docker container, ensuring a clean, consistent environment.

---

## 🚀 Quick Start

### ✅ One-Liner Clone & Build

```bash
docker run --rm -v "$(pwd)":/app <docker-image> -r <git-repo-url>
