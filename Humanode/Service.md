
NOT: deneme aşamasında lütfen bitmeden kurcuklamayınız.

```
sudo tee /etc/systemd/system/hmd.service <<EOF
[Unit]
Description=Humanode Node
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/root/.humanode/workspaces/default
ExecStart=/root/.humanode/workspaces/default/humanode-peer --base-path /root/.humanode/workspaces/default/substrate-data --chain /root/.humanode/workspaces/default/chainspec.json --rpc-cors all --name node-adi-yaz --rpc-url-ngrok-detect --validator
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable hmd
sudo systemctl start hmd
```
```
sudo systemctl status hmd
```
```
journalctl -u hmd -fo cat
