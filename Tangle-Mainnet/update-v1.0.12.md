

```
sudo systemctl stop tangle
wget -O tangle https://github.com/webb-tools/tangle/releases/download/v1.0.12/tangle-default-linux-amd64 && chmod +x tangle
sudo mv tangle /usr/bin/
tangle --version
```
```
systemctl daemon-reload
systemctl restart tangle && journalctl -u tangle -f -o cat
```
![image](https://github.com/user-attachments/assets/f092b061-4215-47ec-86e5-f1830cbf3334)
