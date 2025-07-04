# STM32F429ZI CMake + Docker Project

This project demonstrates a modern CMake-based STM32 firmware build setup for the STM32F429ZI MCU, using Docker for toolchain isolation.

---

## 🐳 Docker-Based Build System

No need to install the ARM GCC toolchain or CMake on your host. Everything runs inside a container using [`stm32-compiler`](https://github.com/jasonyang-ee/STM32-Dockerfile).

---

## 🚀 Quick Start

### ✅ First-Time Compilation (Clone & Build)

This clones your GitHub repo and builds it inside Docker:

```bash
docker run -v "$(pwd)/../project":/app stm32-compiler -r https://github.com/harishankarn04/stm32f429zit-cmake.git
