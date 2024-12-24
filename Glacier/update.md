```
cd
sudo systemctl stop glacierd
cd glacier
rm -rf verifier
wget -O verifier https://github.com/Glacier-Labs/node-bootstrap/releases/download/v0.0.4-beta/verifier_linux_amd64
chmod +x $HOME/glacier/verifier
sudo systemctl daemon-reload
sudo systemctl enable glacierd
sudo systemctl restart glacierd
journalctl -u glacierd -fo cat
```
