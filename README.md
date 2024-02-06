# Raspberry Pi 5 Codepi Setup Guide

Welcome to the setup guide for configuring your Raspberry Pi 5 to work seamlessly with an iPad Pro via USB-C Thunderbolt 4 and USB0 Ethernet, utilizing Blink Shell for SSH connections, as well as enabling remote access through RealVNC Viewer and setting up Code-Server for a portable development environment. This comprehensive guide covers the installation of necessary dependencies, configurations for SSH and VNC, and enhancements for your coding experience with additional tools and languages. The USB0 Ethernet makes this setup latency free and able to work anywhere via static IP address.

## Table of Contents

1.  [Introduction](#introduction)
2.  [Dependencies Installation](#dependencies-installation)
    -   dnsmasq
    -   Node.js (via nodesource)
    -   code-server
    -   VNC Remote Desktop
    -   ZSH and Oh My Zsh
3.  [SSH Configuration](#ssh-configuration)
    -   Blink Shell SSH Key
    -   GitHub SSH Key
    -   Code-Server Certification
    -   Disable MOTD
4.  [Enhancements and Tools](#enhancements-and-tools)
    -   Lazygit
    -   Docker
    -   Neovim
    -   Java and Miniforge
    -   Other Languages and Tool
5.  [Creating a Backup of Your SD Card](#creating-a-backup-of-your-sd-card)
6.  [Conclusion](#conclusion)

## Introduction

This guide is tailored for developers looking to leverage the power of their Raspberry Pi 5 by connecting it to an iPad Pro for a versatile development setup. Whether you're coding on the go or need a portable server, this guide will help you set up your environment efficiently.

## Dependencies Installation

### 0\. Update Raspberri Pi

```bash
sudo apt update
sudo apt full-upgrade
```

### 1\. dnsmasq for USB0 Ethernet Connection to iPad

To enable USB0 Ethernet connection:

```bash
sudo apt update
sudo apt install dnsmasq
```

### 2\. Node.js LTS via nodesource

For the latest LTS version of Node.js:

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash - &&\
sudo apt-get install -y nodejs
```

### 3\. code-server: Visual Studio Code on the Go

Install code-server for VS Code accessibility:

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

### 4\. Enable VNC Remote Desktop

To access your Pi's desktop remotely:

```bash
sudo raspi-config
```

Navigate to: Interface Options > VNC > Enable.

Start and enable VNC service:

```bash
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service
sudo vncpasswd -service
```

### 5\. ZSH and Oh My Zsh Installation

#### Step 1: Install ZSH and Oh My Zsh

Install ZSH, set it as the default shell, and install Oh My Zsh:

```bash
sudo apt update
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Step 2: Install Pure Prompt

```bash
git clone https://github.com/sindresorhus/pure.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/pure
```

To activate the Pure prompt, add the following lines to your `.zshrc` file.

```bash
ZSH_THEME=""
fpath+=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/pure
autoload -U promptinit; promptinit
prompt pure
```

#### Step 3: Install and Activate ZSH Plugins

-   **ZSH Syntax Highlighting** for highlighting commands:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

-   **ZSH Autosuggestions** for command suggestions based on history:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

-   **ZSH Completions** for additional completion definitions:

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

#### Step 6: Activate Plugins in `.zshrc` File

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
```

## SSH Configuration

Configure SSH for secure access:

-   Set up Blink Shell SSH Key for iPad connectivity.
-   Configure GitHub SSH Key for repository management.
-   Secure code-server with proper certification.

### Disable MOTD

To disable the message of the day:

```bash
sudo mv /etc/motd /etc/motdDisabled
```

## Enhancements and Tools

### Lazygit Installation

Follow the steps to install Lazygit, a git command UI to simplify repository management:

```bash
wget https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_arm64.tar.gz
tar -xzf lazygit_0.40.2_Linux_arm64.tar.gz
sudo mv lazygit /usr/local/bin/
lazygit --version
```

### Neovim Setup

Instructions for installing Neovim and Docker, facilitating an advanced text editing experience and container management:

#### 1\. Install Docker

Ensure Docker is installed on your system. If not, you can install it by following the official Docker documentation or by using the simplified commands below for a Debian system:

```bash
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

#### 2\. Clone and build Neovim using Docker for aarch64 Linux:

```bash
git clone https://github.com/matsuu/neovim-aarch64-appimage.git
cd neovim-aarch64-appimage
```

#### 3\. Building the Neovim AppImage

Before building the image run the following command to get permission:

```bash
sudo usermod -aG docker $USER
sudo reboot
```

Inside the repository directory, you can build the Neovim AppImage.

NOTE: Check the repository `https://github.com/matsuu/neovim-aarch64-appimage` and use the latest release listed as the version.

```bash
./build.sh v0.9.4
```

This process will create a Neovim AppImage for the specified version.

If the building of the image goes wrong run: `docker image prune -a` to remove all docker images. Do not run that command if you have other Docker images unrelated to this setup.

#### 4\. Make the AppImage Executable

Once the build process completes, you should have a Neovim AppImage file for aarch64. You'll need to make it executable:

```bash
sudo apt-get update
sudo apt-get install fuse libfuse2
```

```bash
chmod +x nvim-v0.9.4.appimage
```

#### 5\. Run Neovim

Now, you can run Neovim directly from the AppImage:

```bash
./nvim-v0.9.4.appimage
```

#### Set an alias:

Open either .bashrc or .zshrc and put this line:

`alias vim='/home/andreaventi/neovim-aarch64-appimage/nvim-v0.9.4.appimage'`

For optional configuration check this repository:
`https://github.com/av1155/RaspberryPi-Nvim-Config`

### Java and Miniforge Installation

Steps for installing Java JDK and Miniforge to support a broad range of development tasks:

#### Step 1: Download and install the Java JDK:

```bash
curl -L -O https://download.oracle.com/java/21/latest/jdk-21_linux-aarch64_bin.tar.gz
sudo tar -xvzf jdk-21_linux-aarch64_bin.tar.gz -C /usr/local
```

**Set up environment variables** to use the installed Java as the default. Add these lines to your `~/.bashrc` or `~/.zshrc` file:

```bash
export JAVA_HOME=/usr/local/jdk-21.0.2
export PATH=$PATH:$JAVA_HOME/bin
```

#### Step 2: Install Miniforge

1.  **Download Miniforge Installer**: Download the Miniforge installer for ARM64 architectures.

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

### Other Languages and Tools

Install additional languages and tools such as Ruby, LuaRocks, and their respective utilities to enhance your development environment further.

-   **Ruby and Colorls**

```bash
sudo apt update
sudo apt install ruby-full
gem install colorls
```

-   **Luarocks**

```bash
sudo apt install luarocks
```

## Creating a Backup of Your SD Card

To securely back up the SD card of your Raspberry Pi, follow these steps using the RealVNC Viewer's iOS app to access your Raspberry Pi's desktop environment remotely. This process involves using the built-in SD Card Copy tool, allowing you to clone your current SD card to a backup microSD card, ensuring that you have a reliable backup in case of failure or data loss.

### Step-by-Step Guide

1.  **Connect to Your Raspberry Pi:** Open the RealVNC Viewer app on your iOS device. Connect to your Raspberry Pi by selecting it from the list of available connections.

2.  **Access the SD Card Copy Tool:** Once connected and you have access to the Raspberry Pi's desktop, locate and open the **Accessories** menu from the Raspberry Pi's main menu. Here, find and launch the **SD Card Copier** application. This tool is specifically designed for safely cloning your Raspberry Pi's SD card.

3.  **Select Source SD Card:** In the SD Card Copier interface, you'll find a field labeled **'Copy From Device'**. This is where you'll select the SD card currently in use by your Raspberry Pi as the source for the backup. It's usually identifiable by its storage size or label.

4.  **Select Target Backup Card:** Next, identify the backup microSD card in the **'Copy To Device'** field. Ensure this card is inserted into a card reader connected to your Raspberry Pi. Choose the appropriate device from the list. This will be the destination for your backup.

5.  **Initiate the Backup Process:** After confirming your selections, click on the **Start** button to begin copying the contents of your current SD card to the backup microSD card. The process can take some time, depending on the size of your SD card and the amount of data stored on it.

6.  **Completion:** Once the copying process is finished, you'll receive a notification indicating that the backup is complete. It's important to wait until this confirmation appears before removing the backup microSD card to avoid data corruption.

### Tips for a Successful Backup

-   **Verify the Backup:** After the backup process concludes, it's wise to verify that the backup microSD card boots correctly in your Raspberry Pi. This step ensures that the backup is reliable and complete.
-   **Regular Backups:** Regularly update your backup, especially after significant changes to your Raspberry Pi's configuration or data, to keep it current and useful.

By following these detailed steps, you create a dependable backup of your Raspberry Pi's SD card, safeguarding your projects and data against unforeseen issues or failures.

## Conclusion

By following this guide, you will have a fully equipped Raspberry Pi 5 setup, ready to connect to an iPad Pro and serve as a versatile development platform. This configuration enables you to develop, manage projects, and code anywhere, providing a flexible and powerful coding environment.

Should you encounter any issues or have questions, the community forums and official documentation for each tool or language are great resources for support and further learning.
