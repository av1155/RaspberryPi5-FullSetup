# Raspberry Pi 5 Codepi Setup

## Dependencies:

1. dnsmasq for USB0 Ethernet Connection to iPad

```bash
sudo apt update
sudo apt install dnsmasq
```

2. nodesource for Node.js LTS

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash - &&\
sudo apt-get install -y nodejs
```

3. code-server for portable Visual Studio Code

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

4. Enable VNC Remote Desktop via:

```bash
sudo raspi-config
```

- Interface Options > VNC (enable it)

## SSH

1. Set up Blink Shell SSH Key
2. Set up GitHub SSH Key
3. Set up Code-Server Certification

## Other Packages

### Lazygit

- **Download the Lazygit Binary**:

  - You can download it directly from the command line using `wget` or `curl`. Since direct downloading via the command line might be challenging without the direct link, I recommend downloading the binary from the Lazygit releases page on GitHub using a browser or constructing the download command based on the GitHub URL structure for releases.

  Assuming you have access to `wget`, you could use:

```bash
wget https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_arm64.tar.gz
```

- **Extract the Tarball**:

  - Once the tar.gz file is downloaded, extract it using:

```bash
tar -xzf lazygit_0.40.2_Linux_arm64.tar.gz
```

- **Move Lazygit to a System-wide Location**:

  - After extracting, you'll find the `lazygit` executable. Move it to a location in your system's PATH to make it accessible system-wide. A common choice is `/usr/local/bin/`.

```bash
sudo mv lazygit /usr/local/bin/
```

- **Verify Installation**:

  - To ensure Lazygit was installed successfully, run:

```bash
lazygit --version
```

### Neovim

#### 1\. Install Docker

Ensure Docker is installed on your system. If not, you can install it by following the official Docker documentation or by using the simplified commands below for a Debian system:

```bash
sudo apt update
sudo apt install docker.io
```

After installation, start the Docker service and enable it to launch at boot:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

#### 2\. Clone the `neovim-aarch64-appimage` Repository

If you have a specific repository or script called `neovim-aarch64-appimage` for building the Neovim AppImage, you'll first need to clone that repository or obtain the `build.sh` script. If this script is part of an online repository, you would typically use `git` to clone it:

```bash
git clone https://github.com/matsuu/neovim-aarch64-appimage.git
cd neovim-aarch64-appimage
```

#### 3\. Building the Neovim AppImage

Before building the image run the following command to get permission:

- `sudo usermod -aG docker $USER`
- `sudo reboot`

Inside the repository directory, you can build the Neovim AppImage.

```bash
./build.sh v0.9.4
```

This process will create a Neovim AppImage for the specified version.

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

For configuration check this repository:
`https://github.com/av1155/RaspberryPi-Nvim-Config`

### Installing Java and Miniforge

#### Step 1: Install Java JDK

1.  **Find the Download URL**: First, visit the official Oracle JDK download page or AdoptOpenJDK to get the download link for the ARM 64-bit version. This guide assumes you're using a terminal and know the direct URL to the JDK tar.gz file.
2.  **Download JDK**: Download the JDK tar.gz file. If you have the direct URL, you can do something like this:

```bash
curl -L -O https://download.oracle.com/java/21/latest/jdk-21_linux-aarch64_bin.tar.gz
```

3. **Extract the JDK archive** to the specified directory `/usr/local`.

```bash
sudo tar -xvzf jdk-21_linux-aarch64_bin.tar.gz -C /usr/local
```

4. **Set up environment variables** to use the installed Java as the default. Add these lines to your `~/.bashrc` or `~/.zshrc` file:

```bash
export JAVA_HOME=/usr/local/jdk-21.0.2
export PATH=$PATH:$JAVA_HOME/bin
```

#### Step 2: Install Miniforge

1.  **Download Miniforge Installer**: Download the Miniforge installer for ARM64 architectures. Find the download link from the Miniforge GitHub releases page.

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```
