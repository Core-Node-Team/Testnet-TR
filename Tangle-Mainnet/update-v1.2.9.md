```
sudo systemctl stop tangle
wget -O tangle https://github.com/webb-tools/tangle/releases/download/v1.2.9/tangle-default-linux-amd64 && chmod +x tangle
sudo mv tangle /usr/bin/
systemctl daemon-reload
systemctl restart tangle && journalctl -u tangle -f -o cat
```
