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
sleep 5
sleep 2

# Variables to configure
BINARY_NAME="story" # The Story binary
PROJECT_DIR="$HOME/.story/story" # The Story project's dot directory

# Cosmovisor directory settings
COSMOVISOR_DIR="$PROJECT_DIR/cosmovisor"
GENESIS_BIN="$COSMOVISOR_DIR/genesis/bin"
UPGRADES_DIR="$COSMOVISOR_DIR/upgrades"
SERVICE_NAME="${BINARY_NAME}.service"

# Installing a specific version of Cosmovisor
echo "Installing Cosmovisor v1.6.0..."
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.6.0

# Creating Cosmovisor directories
echo "Creating Cosmovisor directories..."
mkdir -p $GENESIS_BIN
mkdir -p $UPGRADES_DIR

# Copying the existing binary to the Cosmovisor genesis directory
echo "Copying the current binary..."
cp $(which $BINARY_NAME) $GENESIS_BIN/$BINARY_NAME

sudo ln -s $PROJECT_DIR/cosmovisor/genesis $PROJECT_DIR/cosmovisor/current -f
sudo ln -s $PROJECT_DIR/cosmovisor/current/bin/$BINARY_NAME /usr/local/bin/$BINARY_NAME -f

# Setting up the systemd service file
echo "Configuring the service file..."
sudo tee /etc/systemd/system/$SERVICE_NAME > /dev/null <<EOF
[Unit]
Description=$BINARY_NAME Cosmos Daemon
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run run
Restart=always
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_NAME=$BINARY_NAME"
Environment="DAEMON_HOME=$PROJECT_DIR"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$PROJECT_DIR/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF

# Upgrade

# Step 1: Download the new binary for Story v0.13.0
rm -rf story-linux-amd64
wget https://github.com/piplabs/story/releases/download/v0.13.0/story-linux-amd64

# Step 2: Make the binary executable
chmod +x ./story-linux-amd64

# Step 3: Create the Cosmovisor upgrade directory
mkdir -p /root/.story/cosmovisor/upgrades/v0.13.0/bin

# Step 4: Move the binary to the Cosmovisor upgrade directory
sudo mv ./story-linux-amd64 /root/.story/cosmovisor/upgrades/v0.13.0/bin/story




# Restarting and enabling the service
echo "Restarting the service..."
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl stop $SERVICE_NAME # Stop the current service
sudo systemctl restart $SERVICE_NAME # Start the new service

# Checking service status
echo "Checking the service status..."
sudo systemctl status $SERVICE_NAME

# Success message with dynamic project name
echo "Corenode Community"
