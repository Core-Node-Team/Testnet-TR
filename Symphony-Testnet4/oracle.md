

```
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
sudo apt-get update && apt-get install -y libssl-dev
```
```
sudo apt update
sudo apt install python3.10
sudo apt install python3.10-venv
```
```
cd $HOME
rm -rf symphony
git clone https://github.com/Orchestra-Labs/symphony
cd symphony
git checkout v0.4.1
make build
```
```
cd $HOME
git clone https://github.com/cmancrypto/symphony-oracle-voter.git
```
```
cd symphony-oracle-voter
git checkout v0.0.5
```
```
sudo tee .env > /dev/null << EOF
VALIDATOR_ADDRESS= $(symphonyd keys show molla202 --bech val -a)
VALIDATOR_ACC_ADDRESS= $(symphonyd keys show molla202 -a)
KEY_BACKEND = test
SYMPHONY_LCD= http://localhost:35317
TENDERMINT_RPC= http://localhost:35657
EOF
```
```
python3 -m venv venv
```
```
source venv/bin/activate
```
```
pip install -r requirements.txt
```
```
deactivate
```
```
sudo tee /etc/systemd/system/oracle.service > /dev/null << EOF
[Unit]
Description=Symphony Oracle
After=network.target

[Service]
# Environment variables
Environment="SYMPHONYD_PATH=/root/symphony/build/symphonyd"
Environment="PYTHON_ENV=production"
Environment="LOG_LEVEL=INFO"
Environment="DEBUG=false"

# Service configuration
Type=simple
User=root
WorkingDirectory=/root/symphony-oracle-voter/
ExecStart=/root/symphony-oracle-voter/venv/bin/python3 -u /root/symphony-oracle-voter/main.py
Restart=always
RestartSec=3
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable oracle.service
sudo systemctl start oracle.service
```
```
sudo journalctl -u oracle -f -o cat
```

```
sudo journalctl -u oracle.service -n 50 --no-pager
```
