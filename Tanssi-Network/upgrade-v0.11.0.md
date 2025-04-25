

```
sudo systemctl stop tanssid.service
```
```
wget https://github.com/moondance-labs/tanssi/releases/download/v0.11.0-para/tanssi-node && \
chmod +x ./tanssi-node

mv /root/tanssi-node /root/tanssi-data
```
```
sudo systemctl restart tanssid.service
journalctl -u tanssid -fo cat
```
