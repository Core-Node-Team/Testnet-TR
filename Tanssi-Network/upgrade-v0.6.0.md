```
sudo systemctl stop tanssid.service
```
```
wget https://github.com/moondance-labs/tanssi/releases/download/v0.6.0/tanssi-node && \
chmod +x ./tanssi-node

sudo mkdir /root/tanssi-data/

cd /root/tanssi-data/

mv /root/tanssi-node /root/tanssi-data
```
```
sudo systemctl restart tanssid.service
journalctl -u tanssid -fo cat
```
