#!/bin/bash


sleep 1
echo -e '\e[0;32m'
echo " ▄████████  ▄██████▄     ▄████████    ▄████████     ███▄▄▄▄    ▄██████▄  ████████▄     ▄████████ ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███▀▀▀██▄ ███    ███ ███   ▀███   ███    ███ ";
echo "███    █▀  ███    ███   ███    ███   ███    █▀      ███   ███ ███    ███ ███    ███   ███    █▀  ";
echo "███        ███    ███  ▄███▄▄▄▄██▀  ▄███▄▄▄         ███   ███ ███    ███ ███    ███  ▄███▄▄▄     ";
echo "███        ███    ███ ▀▀███▀▀▀▀▀   ▀▀███▀▀▀         ███   ███ ███    ███ ███    ███ ▀▀███▀▀▀     ";
echo "███    █▄  ███    ███ ▀███████████   ███    █▄      ███   ███ ███    ███ ███    ███   ███    █▄  ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███   ███ ███    ███ ███   ▄███   ███    ███ ";
echo "████████▀   ▀██████▀    ███    ███   ██████████      ▀█   █▀   ▀██████▀  ████████▀    ██████████ ";
echo "                        ███    ███                                                               ";
echo ""
echo -e '\e[0m' 
sleep 3
sleep 2

if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo apt update -y && sudo apt upgrade -y
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
        sudo apt-get remove -y $pkg
    done

    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    sudo apt update -y && sudo apt install -y docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker

    echo "Docker installed successfully."
else
    echo "Docker is already installed."
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully."
else
    echo "Docker Compose is already installed."
fi

TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
if [ -z "$TIMEZONE" ]; then
    TIMEZONE="Asia/Jakarta"
fi
echo "Server timezone detected: $TIMEZONE"

CUSTOM_USER=$(openssl rand -hex 4)  
PASSWORD=$(openssl rand -hex 12)    
echo "Generated username: $CUSTOM_USER"
echo "Generated password: $PASSWORD"

echo "Setting up Chromium with Docker Compose..."
mkdir -p $HOME/chromium && cd $HOME/chromium

cat <<EOF > docker-compose.yaml
---
services:
  chromium:
    image: lscr.io/linuxserver/chromium:latest
    container_name: chromium
    security_opt:
      - seccomp:unconfined
    environment:
      - CUSTOM_USER=$CUSTOM_USER
      - PASSWORD=$PASSWORD
      - PUID=1000
      - PGID=1000
      - TZ=$TIMEZONE
      - LANG=en_US.UTF-8
      - CHROME_CLI=https://google.com/
    volumes:
      - /root/chromium/config:/config
    ports:
      - 3010:3000
      - 3011:3001
    shm_size: "1gb"
    restart: unless-stopped
EOF

if [ ! -f "docker-compose.yaml" ]; then
    echo "Failed to create docker-compose.yaml. Exiting..."
    exit 1
fi

echo "Running Chromium container..."
cd $HOME/chromium
docker-compose up -d

IPVPS=$(curl -s ipinfo.io/ip)

echo "Access Chromium in your browser at: http://$IPVPS:3010/ or https://$IPVPS:3011/"
echo "Username: $CUSTOM_USER"
echo "Password: $PASSWORD"
echo " KAYDET KAYDET KAYDET "

docker system prune -f
echo "Setup complete! Subscribe: https://t.me/corenodeduyuru"
