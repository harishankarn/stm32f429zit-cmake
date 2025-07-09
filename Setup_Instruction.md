# 🔧 Embedded Development Environment Setup Guide

This guide covers setup for **Windows (WSL)**, **macOS**, and **Linux** for embedded development with OpenOCD and USB device support.

---

## 🪟 Windows (WSL) Setup

### 1. Install WSL (Ubuntu)

#### a. Enable Required Windows Features

Go to **Control Panel → Programs → Turn Windows features on or off**, and enable:

* Virtual Machine Platform
* Windows Subsystem for Linux

Alternatively, via PowerShell (Admin):

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

#### b. Install WSL

```powershell
wsl --install
```

This installs:

* WSL 2
* Ubuntu (default)
* Required kernel updates

> 📌 Reboot after install.
> To check install: `wsl --status`

---

### 2. Install Docker for Windows

Download & install Docker:
👉 [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

Enable WSL 2 integration in Docker settings:

* **Settings → Resources → WSL Integration** → Enable for your Ubuntu distro

> ✅ Confirm in WSL: `docker --version`

---

### 3. Clone the Project

Inside WSL (Ubuntu) terminal:

```bash
git clone https://github.com/your-org/your-project.git
cd your-project
```

Replace with actual project link.

---

### 4. Install OpenOCD (Inside WSL)

```bash
sudo apt update
sudo apt install openocd
```

> ✅ Confirm installation: `openocd --version`

---

### 5. Enable USB Access in WSL

Microsoft Guide:
👉 [https://learn.microsoft.com/en-us/windows/wsl/connect-usb](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)

#### a. Install `usbipd-win` (on Windows)

```powershell
winget install --interactive --exact dorssel.usbipd-win
```

#### b. Bind USB device

```powershell
usbipd list
usbipd bind --busid <busid>
usbipd attach --wsl --busid <busid>
```

#### c. Install tools inside WSL

```bash
sudo apt install linux-tools-$(uname -r) linux-cloud-tools-$(uname -r)
```

#### d. Restart WSL

```powershell
wsl --shutdown
```

Then relaunch Ubuntu.

#### e. Confirm device in WSL

```bash
lsusb
```

Should list your ST-Link/J-Link/CMSIS-DAP.

#### f. Detach USB device

```powershell
usbipd detach --busid <busid>
```

---

## 🍎 macOS Setup

### 1. Install Homebrew (if not installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install OpenOCD

```bash
brew install openocd
```

> ✅ Confirm installation: `openocd --version`

### 3. Install USB tools

```bash
brew install usbutils
```

> ✅ Confirm USB device detection:

```bash
lsusb
```

> 📦 If `lsusb` fails: macOS may need additional drivers or permissions for certain USB tools. Consider using `brew install libusb` and checking `system_profiler SPUSBDataType`.

---

## 🐧 Linux Setup (Native Ubuntu/Debian)

### 1. Install required packages

```bash
sudo apt update
sudo apt install openocd usbutils
```

> ✅ Confirm:

```bash
openocd --version
lsusb
```

### 2. Clone the Project

```bash
git clone https://github.com/your-org/your-project.git
cd your-project
```

---

You're now ready to use OpenOCD and interface with dev boards on your platform of choice.
