#!/bin/bash
clear
echo -e "\e[0;34mStarting\033[0m"
sleep 2
exec > /dev/null 2>&1
systemctl stop elysd
cd $HOME/elys
git fetch --all
git checkout v0.19.0
make build
sudo mv $HOME/elys/build/elysd $(which elysd)
sudo systemctl restart elysd
exec > /dev/tty 2>&1
clear
echo -e "\e[0;34mCompleted\033[0m"
sudo journalctl -u elysd -fo cat
