#!/bin/bash

cd $HOME
if ! [ -x "$(command -v go)" ]; then
VER="1.20"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm -rf  "go$VER.linux-amd64.tar.gz"
if [ ! -d "$HOME/.bash_profile" ]; then
touch $HOME/.bash_profile
source $HOME/.bash_profile
fi
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
fi
if [ ! -d "$HOME/go/bin" ]; then
  mkdir -p "$HOME/go/bin"
fi
