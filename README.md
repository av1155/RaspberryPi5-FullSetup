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

