#!/bin/bash
clear
echo -e "\e[0;34mStarting\033[0m"
sleep 2
exec > /dev/null 2>&1
systemctl stop cascadiad
cd $HOME
rm -rf cascadiad
rm -rf $(which cascadiad)
https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.4/cascadiad -o cascadiad
chmod +x cascadiad
sudo cp cascadiad /usr/local/bin/cascadiad
sudo systemctl start cascadiad
sudo systemctl restart cascadiad
clear
exec > /dev/tty 2>&1
echo -e "\e[0;34mCompleted\033[0m"
sudo journalctl -u cascadiad -fo cat
