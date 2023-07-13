#!/bin/bash

sudo systemctl stop cascadiad
cd $HOME
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.3/cascadiad-v0.1.3-linux-amd64 -o cascadiad
chmod +x cascadiad
sudo mv cascadiad $(which cascadiad)
sudo systemctl restart cascadiad
sudo journalctl -u cascadiad -fo cat
