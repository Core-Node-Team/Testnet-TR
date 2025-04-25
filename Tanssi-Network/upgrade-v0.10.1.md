

```
sudo systemctl stop tanssid.service
```
```
wget http://37.120.189.81/tanssi_testnet/tanssi-node && \
chmod +x ./tanssi-node

mv /root/tanssi-node /root/tanssi-data
```
```
sudo systemctl restart tanssid.service
journalctl -u tanssid -fo cat
```
