# ⚙ Windows + WSL Setup Guide (with USB Support)

## 1. Install WSL (Ubuntu)

### a. Enable Required Windows Features

Go to **Control Panel → Programs → Turn Windows features on or off**, and enable:

* Virtual Machine Platform
* Windows Subsystem for Linux

Alternatively, via PowerShell (Admin):

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

### b. Install WSL

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

## 2. Install Docker for Windows

Download & install Docker:
👉 [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

Enable WSL 2 integration in Docker settings:

* **Settings → Resources → WSL Integration** → Enable for your Ubuntu distro

> ✅ Confirm in WSL: `docker --version`

---

## 3. Clone the Project

Inside WSL (Ubuntu) terminal:

```bash
git clone https://github.com/your-org/your-project.git
cd your-project
```

Replace with actual project link.

---

## 4. Install OpenOCD (Inside WSL)

```bash
sudo apt update
sudo apt install openocd
```

> ✅ Confirm installation: `openocd --version`

---

## 5. Enable USB Access in WSL

Microsoft Guide:
👉 [https://learn.microsoft.com/en-us/windows/wsl/connect-usb](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)

### a. Install `usbipd-win` (on Windows)

```powershell
winget install --interactive --exact dorssel.usbipd-win
```

### b. Bind USB device

```powershell
usbipd list
usbipd bind --busid <busid>
usbipd attach --wsl --busid <busid>
```

### c. Install tools inside WSL

```bash
sudo apt install linux-tools-$(uname -r) linux-cloud-tools-$(uname -r)
```

### d. Restart WSL

```powershell
wsl --shutdown
```

Then relaunch Ubuntu.

### e. Confirm device in WSL

```bash
lsusb
```

Should list your ST-Link/J-Link/CMSIS-DAP.

### f. Detach USB device

```powershell
usbipd detach --busid <busid>
```

---

Now you're ready to use OpenOCD and interface with dev boards from WSL.