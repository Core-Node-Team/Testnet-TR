


```
cd $HOME
mkdir -p $HOME/.mineplex-chain/cosmovisor/genesis/bin
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0-prebuild3/crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz && tar -xf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz
tar -xvf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz
chmod +x $HOME/bin/crossfid
mv $HOME/bin/crossfid $HOME/.mineplex-chain/cosmovisor/genesis/bin
```
```
sudo ln -s $HOME/.mineplex-chain/cosmovisor/genesis $HOME/.mineplex-chain/cosmovisor/current -f
sudo ln -s $HOME/.mineplex-chain/cosmovisor/current/bin/crossfid /usr/local/bin/crossfid -f
```

### Download and install Cosmovisor
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### Create service
```
sudo tee /etc/systemd/system/crossfid.service > /dev/null << EOF
[Unit]
Description=crossfi node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --home $HOME/.mineplex-chain
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.mineplex-chain"
Environment="DAEMON_NAME=crossfid"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.mineplex-chain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable crossfid.service
sudo systemctl restart crossfid
```
### Log
```
sudo journalctl -u crossfid -f
```
