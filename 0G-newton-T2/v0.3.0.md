

```
systemctl stop 0gchaind
wget https://zgchaind-test.s3.ap-east-1.amazonaws.com/0gchaind-linux-v0.3.0
chmod +x ./0gchaind-linux-v0.3.0
mkdir -p /root/.0gchain/cosmovisor/upgrades/v0.3.0/bin
sudo mv ./0gchaind-linux-v0.3.0 /root/.0gchain/cosmovisor/upgrades/v0.3.0/bin/0gchaind
```
🚧Servis Düzeltme
```
sudo tee /etc/systemd/system/0gchaind.service > /dev/null << EOF
[Unit]
Description=0gchaind node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --log_output_console
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.0gchain"
Environment="DAEMON_NAME=0gchaind"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.0gchain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload && systemctl restart 0gchaind && journalctl -u 0gchaind -fo cat
```

















