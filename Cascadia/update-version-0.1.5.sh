#!/bin/bash
clear
echo -e "\e[0;34mStarting\033[0m"
sleep 2
exec > /dev/null 2>&1
systemctl stop cascadiad
cd $HOME
rm -rf cascadiad
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.5/cascadiad -o cascadiad
chmod +x cascadiad
sudo mv cascadiad $(which cascadiad)

sudo tee /etc/systemd/system/cascadiad.service > /dev/null <<EOF
[Unit]
Description=Cascadia Node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which cascadiad) start --home $HOME/.cascadiad --chain-id cascadia_6102-1
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl start cascadiad
sudo systemctl restart cascadiad
exec > /dev/tty 2>&1
clear
rm -rf $HOME/cascadiad
echo -e "\e[0;34mCompleted\033[0m"
sudo journalctl -u cascadiad -fo cat
