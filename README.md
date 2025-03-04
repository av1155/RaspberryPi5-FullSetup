# Raspberry Pi 5 Codepi Setup Guide

Welcome to the setup guide for configuring your Raspberry Pi 5 to work seamlessly with an iPad Pro via USB-C Thunderbolt 4 and USB0 Ethernet, utilizing Blink Shell for SSH connections, as well as enabling remote access through RealVNC Viewer and setting up Code-Server for a portable development environment. This comprehensive guide covers the installation of necessary dependencies, configurations for SSH and VNC, and enhancements for your coding experience with additional tools and languages. The USB0 Ethernet makes this setup latency free and able to work anywhere via static IP address.

Many of these steps are optional and simply steps that I take on my system, you may follow only the necessary steps (configuring the usb0 ethernet connection).

> **Optional Setup Note:** I personally use my **new** [.dotfiles](https://github.com/av1155/.dotfiles) repository with my Raspberry Pi + iPad setup to maintain a mirrored development environment across Linux (Arch, Debian), macOS, and WSL. This guide fully covers the hardware setup for a seamless Raspberry Pi 5 and iPad connection, so using my dotfiles is entirely optional—only if you'd like to replicate my complete current configuration. The RaspberryPi5-FullSetup guide remains fully relevant on its own. The optional [.dotfiles](https://github.com/av1155/.dotfiles) repository includes a universal Zsh configuration, tmux session management, a robust Neovim configuration, and much more.

<img src="GithubAssets/iPad+RaspberryPi5.jpg" alt="iPad Pro connected to Raspberry Pi 5" width="500" style="display: block; margin-left: auto; margin-right: auto; border-radius: 15px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: 1px solid #ddd; padding: 10px;"/>

## Table of Contents

1.  [Introduction](#introduction)
2.  [Dependencies Installation](#dependencies-installation)
    - File Configurations
    - dnsmasq
    - Node.js (via nodesource)
    - code-server
    - VNC Remote Desktop
    - ZSH and Oh My Zsh
    - Cockpit and firewalld
3.  [SSH Configuration](#ssh-configuration)
    - Blink Shell SSH Key
    - GitHub SSH Key
    - Code-Server Certification
    - Disable MOTD
4.  [Enhancements and Tools](#enhancements-and-tools)
    - Lazygit
    - Docker
    - Neovim
    - Java, Miniforge, and TMUX
    - Other Languages and Tool
5.  [Creating a Backup of Your SD Card](#creating-a-backup-of-your-sd-card)
6.  [Conclusion](#conclusion)

## Introduction

This guide is tailored for developers looking to leverage the power of their Raspberry Pi 5 by connecting it to an iPad Pro for a versatile development setup. Whether you're coding on the go or need a portable server, this guide will help you set up your environment efficiently.

### Requirements

- **Raspberry Pi:** Raspberry Pi 5 or Raspberry Pi 4 recommended (these both have USB-C).
- **Cable:** A high-quality and short USB-C or Thunderbolt 3 or 4 cable is essential for a stable connection. For the Raspberry Pi 5, a Thunderbolt 4 cable is recommended based on personal experience.
- **Micro-SD Card:** A minimum capacity of 32GB is advised for optimal performance, along with an SD card reader for OS image installation.
- **Secondary Computer:** Required for burning the operating system image onto the micro-SD card.
- **iPad with USB-C Port:** Any model equipped with a USB-C port should suffice. The iPad will not only power the Raspberry Pi but also serve as the interface for a USB Ethernet connection. The use of a high-quality USB-C Thunderbolt cable ensures a reliable link.
- **Keyboard and Mouse:** Any iPad-compatible keyboard and mouse, including case keyboards and mice like the Apple iPad Magic Keyboard, or Bluetooth peripherals.
- **iPad Shell/SSH App:** An application that enables SSH connections to any device. Apps like Blink Shell, Termius, or iSH Shell can be used. This configuration utilizes Blink Shell due to its native Visual Studio Code instance, as well as its compatibility with Nerd Fonts and themes.
- **This setup includes:** An iPad Pro with USB-C, a Thunderbolt 4 cable from Anker, and a Raspberry Pi 5.

## Dependencies Installation

### 0\. Raspberry Pi OS Setup and Raspberry Pi Update

To set up your Raspberry Pi for remote desktop access, follow these steps:

1.  Visit [https://www.raspberrypi.com/software/](https://www.raspberrypi.com/software/) and download the Raspberry Pi Imager software onto your computer.
2.  Insert a microSD card into an SD card reader connected to your computer.
3.  Launch the Raspberry Pi Imager application. In the application, select "Raspberry Pi 4" or "Raspberry Pi 5" as your device. (Note: This setup is expected to work with both models, though it has not been explicitly tested on the Raspberry Pi 4.)
4.  For the operating system, choose "Raspberry Pi OS Full (64-bit)" to ensure compatibility with VNC for remote desktop access.
5.  Before writing the image to the SD card, click on "Edit Settings." Here, you can configure your hostname, set a password, input WiFi settings, and enable SSH. These steps are crucial for remote access and should not be skipped.
6.  Once configured, proceed to write the OS image to the SD card. After completion, safely eject the SD card from your computer and insert it into your Raspberry Pi.
7.  At this point, direct USB Ethernet connection is not yet available. However, you can initiate a regular SSH session. Power on your Raspberry Pi and connect to it via SSH using the configurations set in the previous step.

Finally, make sure to update!

```bash
sudo apt update
sudo apt full-upgrade
```

### 1\. USB0 Ethernet Connection to iPad

**Modify `config.txt` and `cmdline.txt` under the root directory:**

- **`config.txt`:**

    - Add the following line to the end of the file, after `[all]`:
        ```
        dtoverlay=dwc2,dr_mode=peripheral
        ```

    **`cmdline.txt`:**

    - Insert the following line just before `rootwait`:
        ```
        modules-load=dwc2,g_ether
        ```

**Create the following file `/etc/network/interfaces.d/usb0` to enable USB-C Network:**

- Paste the contents under the respective file that is in this repository.
    ```bash
    sudo nano /etc/network/interfaces.d/usb0
    ```

**To enable USB0 Ethernet connection:**

```bash
sudo apt update
sudo apt install dnsmasq
```

**Create the following file `/etc/dnsmasq.d/usb0` to handle IP addresses:**

- Paste the contents under the respective file that is in this repository.
    ```bash
    sudo nano /etc/dnsmasq.d/usb0
    ```

**Create or modify the following file `/etc/dhcpcd.conf`**

- Paste the contents under the respective file that is in this repository.
    ```bash
    sudo nano /etc/dhcpcd.conf
    ```

### Final Steps and Verification

After completing these steps, reboot your Raspberry Pi to apply the changes. Once rebooted, your Raspberry Pi should automatically establish a USB Ethernet connection with your iPad when connected via USB-C. Verify the connection by checking the network settings on your iPad or using network utilities to ensure communication between the devices.

This setup enables a direct Ethernet connection over USB, facilitating various network-based applications and services between your Raspberry Pi and iPad.

- Credits go to [Tech Craft](https://youtu.be/L8r6kMod7Vw?si=tx7C4iFe1Elj0I5_).

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

Navigate to:

- Interface Options > VNC > Enable.
- Display Options > VNC Resolution > 1024x768.
- In a Raspberry Pi 5, also navigate to: Advanced Options > Wayland > X11.

Start and enable VNC service:

```bash
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service
sudo vncpasswd -service
```

If you're planning to use the X11 service instead of Wayland (this setup assumes you do) for compatibility with RealVNC Viewer, you'll need to disable the Wayland VNC service (wayvnc) to avoid conflicts. The `wayvnc.service` is specifically for Wayland's VNC server, and disabling it helps ensure your system uses X11 for remote desktop access. Here's how to stop and disable the Wayland VNC service:

```bash
sudo systemctl stop wayvnc.service
sudo systemctl disable wayvnc.service
```

- Install RealVNC Viewer on your iPad from the App Store. After installation, open the app and connect to your Raspberry Pi using the IP address or hostname of your Pi. When prompted, enter the password you previously set with the `sudo vncpasswd -service` command on your Raspberry Pi. This ensures a secure connection between your iPad and the Raspberry Pi via VNC.

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

- **ZSH Syntax Highlighting** for highlighting commands:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- **ZSH Autosuggestions** for command suggestions based on history:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- **ZSH Completions** for additional completion definitions:

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

#### Step 6: Activate Plugins in the `.zshrc` File

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
```

### Cockpit and Firewalld

**1\. Install Cockpit:**

First, update your system's package list and install Cockpit. Then, enable and start the `cockpit.socket` service to allow Cockpit to start automatically:

```bash
sudo apt update
sudo apt install cockpit
sudo systemctl enable --now cockpit.socket
```

Access Cockpit by entering the following URL in your iPad's local browser: `https://10.55.0.1:9090`. Log in with your Raspberry Pi's username and password.

**2\. Install and Configure Firewalld:**

Update your package list again and install `firewalld`:

```bash
sudo apt update
sudo apt install firewalld
```

**Determine which ports need to be allowed** and add them to the firewall allow list:

```bash
ss -tuln
```

**For example**, to allow essential ports:

```bash
# General syntax: sudo firewall-cmd --zone=public --add-port=<port>/<protocol> --permanent
sudo firewall-cmd --zone=public --add-port=22/tcp --permanent
sudo firewall-cmd --zone=public --add-port=22/udp --permanent
# Repeat for other ports as necessary...
```

In my case, for example, I added the following:

```bash
# Allow both TCP and UDP for each port
sudo firewall-cmd --zone=public --add-port=22/tcp --permanent
sudo firewall-cmd --zone=public --add-port=22/udp --permanent

sudo firewall-cmd --zone=public --add-port=53/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent

sudo firewall-cmd --zone=public --add-port=631/tcp --permanent
sudo firewall-cmd --zone=public --add-port=631/udp --permanent

sudo firewall-cmd --zone=public --add-port=25/tcp --permanent
sudo firewall-cmd --zone=public --add-port=25/udp --permanent

sudo firewall-cmd --zone=public --add-port=5900/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5900/udp --permanent

sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8081/udp --permanent

sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent
sudo firewall-cmd --zone=public --add-port=9090/udp --permanent

sudo firewall-cmd --zone=public --add-port=67/tcp --permanent
sudo firewall-cmd --zone=public --add-port=67/udp --permanent

sudo firewall-cmd --zone=public --add-port=5353/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5353/udp --permanent

sudo firewall-cmd --zone=public --add-port=51314/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51314/udp --permanent

sudo firewall-cmd --zone=public --add-port=40989/tcp --permanent
sudo firewall-cmd --zone=public --add-port=40989/udp --permanent
```

**Add the `usb0` interface to the `public` zone** to ensure it's covered by the firewall rules:

```bash
sudo firewall-cmd --zone=public --add-interface=usb0 --permanent
```

**Reload `firewalld`** to apply the changes, and ensure `firewalld` is enabled to start automatically:

```bash
sudo firewall-cmd --reload
sudo systemctl enable --now firewalld
sudo firewall-cmd --state  # Check the firewall state
```

**3\. Install the Navigator Cockpit App:**

Download and install the Navigator app for an enhanced file browsing experience in Cockpit:

```bash
wget https://github.com/45Drives/cockpit-navigator/releases/download/v0.5.10/cockpit-navigator_0.5.10-1focal_all.deb
sudo apt install ./cockpit-navigator_0.5.10-1focal_all.deb
```

## SSH Configuration

Configure SSH for secure access:

- Set up Blink Shell SSH Key for iPad connectivity.
- Configure GitHub SSH Key for repository management.
- Secure code-server with proper certification.

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

#### Install Snap Package Manager

```bash
sudo apt update
sudo apt install snapd
sudo reboot
```

#### Install Neovim package

```bash
sudo snap install core
sudo snap install nvim --classic
```

That's it! Now neovim is installed and will always have a very recent version that works in aarch64!
Snap is a great package manager that works very well in Raspberry Pi OS.

### !LEGACY NEOVIM SETUP METHOD!:

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

`alias vim='/home/USERNAME/neovim-aarch64-appimage/nvim-v0.9.4.appimage'`

For optional configuration check this repository:
`https://github.com/av1155/RaspberryPi-Nvim-Config`

### Java and Miniforge Installation

Steps for installing Java JDK and Miniforge to support a broad range of development tasks:

#### Step 1: Download and install the Java JDK:

- **!NOTE!:** You may need to change the `jdk-22.0.2` version to something else in each command, like, `jdk-22.0.3`

```bash
cd ~  # Navigate to the home directory
wget https://download.oracle.com/java/22/latest/jdk-22_linux-aarch64_bin.tar.gz  # Download the JDK
tar -xvf jdk-22_linux-aarch64_bin.tar.gz  # Extract the tar.gz file
```

```bash
sudo mkdir -p /usr/lib/jvm  # Create a directory for JVMs if it doesn't exist
sudo mv jdk-22.0.2 /usr/lib/jvm/  # Move the extracted JDK directory to /usr/lib/jvm/
```

**Set up environment variables** to use the installed Java as the default.

```bash
echo "export JAVA_HOME=/usr/lib/jvm/jdk-22.0.2" >> ~/.zshrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.zshrc
source ~/.zshrc
java -version
```

#### Step 2: Install Miniforge

1.  **Download Miniforge Installer**: Download the Miniforge installer for ARM64 architectures.

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

#### Step 3: Install TMUX

1. **Install TMUX**: In aarch64 Debian Linux, we can use apt.

```bash
sudo apt update
sudo apt install tmux
```

2. **Install TPM Plugin Manager**: We have to clone the GitHub repository.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

3. **Config File**: Create a config file for tmux in the .config directory.

```bash
cd ~/.config
mkdir -p tmux
```

- Lastly, either create a new tmux.conf file inside of the newly created `~/.config/tmux` directory, or simply copy the tmux.conf file or its contents from this repository under `~/.config/tmux/` to have a premade custom config.

### Other Languages and Tools

Install additional languages and tools such as Ruby, LuaRocks, and their respective utilities to enhance your development environment further.

- **Ruby and Colorls**

```bash
sudo apt update
sudo apt install ruby-full
gem install colorls
```

To update all installed Ruby gems and clean up old versions, use the following commands:

```bash
sudo gem update
sudo gem cleanup
```

- **Optional apt Packages**
  Delta and thefuck are optional packages which add QOL features. Read into them to understand how to set them up.

```bash
sudo apt update
sudo apt install delta
sudo apt install thefuck
```

- **Cargo and Related Packages**

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustc --version
```

Remove the outdated `fzf` version and replace it with updated cargo `fzf`:

```bash
sudo apt remove fzf
```

Must have packages which are installed via cargo to have the latest versions. Read into all of these packages so you understand what they do, and how to use them.

```bash
cargo install zoxide
cargo install fzf
cargo install eza
cargo install bat
cargo install cargo-update # Run `cargo install-update --all` to update all packages installed via cargo.
cargo install cargo-cache # Run `cargo cache --autoclean` to cleanup.
```

- **`fd` Symlink:**
  On Debian-based systems, the `fd` utility is often installed as `fdfind` to avoid conflicts with another utility named `fd`. However, many developers and scripts expect the command to be simply `fd`. This symlink ensures that when you or any script calls `fd`, it correctly points to `fdfind`.

    ```bash
    sudo ln -s $(which fdfind) /usr/local/bin/fd
    ```

- **Luarocks:**
  `Luarocks` is a package manager for the Lua programming language, allowing you to install and manage Lua modules. Installing `luarocks` ensures that you can easily add and manage Lua libraries, which can be critical for various development tasks, especially if you're working with Lua-based projects or tools.

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

- **Verify the Backup:** After the backup process concludes, it's wise to verify that the backup microSD card boots correctly in your Raspberry Pi. This step ensures that the backup is reliable and complete.
- **Regular Backups:** Regularly update your backup, especially after significant changes to your Raspberry Pi's configuration or data, to keep it current and useful.

By following these detailed steps, you create a dependable backup of your Raspberry Pi's SD card, safeguarding your projects and data against unforeseen issues or failures.

## Conclusion

By following this guide, you will have a fully equipped Raspberry Pi 5 setup, ready to connect to an iPad Pro and serve as a versatile development platform. This configuration enables you to develop, manage projects, and code anywhere, providing a flexible and powerful coding environment.

Should you encounter any issues or have questions, the community forums and official documentation for each tool or language are great resources for support and further learning.
