# <h1 align="center">Avail's Clash of Nodes Testnet Update</h1>

![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

```
systemctl stop availd
```
```
rm -rf /root/avail-node/data/chains/avail_goldberg_testnet/db/full
```
### Ubuntu 22
```
cd /root/avail-node/
```
```
rm -rf data-avail
```
```
wget https://github.com/availproject/avail/releases/download/v1.10.0.0/x86_64-ubuntu-2204-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```
### Ubuntu 20
```
cd /root/avail-node/
```
```
rm -rf data-avail
```
```
wget https://github.com/availproject/avail/releases/download/v1.10.0.0/x86_64-ubuntu-2004-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```
### Servis dosyası düzenlenecek mecburi
```
sudo tee /etc/systemd/system/availd.service > /dev/null <<'EOF'
[Unit]
Description=Avail Validator
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
Type=simple
Restart=always
RestartSec=120
ExecStart=/root/avail-node/data-avail -d `pwd`/data --chain goldberg --port 30333 --validator --name "adınızı yazın" \
--reserved-nodes \
"/dns/bootnode-001.goldberg.avail.tools/tcp/30333/p2p/12D3KooWCVqFvrP3UJ1S338Gb8SHvEQ1xpENLb45Dbynk4hu1XGN" \
"/dns/bootnode-002.goldberg.avail.tools/tcp/30333/p2p/12D3KooWD6sWeWCG5Z1qhejhkPk9Rob5h75wYmPB6MUoPo7br58m" \
"/dns/bootnode-003.goldberg.avail.tools/tcp/30333/p2p/12D3KooWMR9ZoAVWJv6ahraVzUCfacNbFKk7ABoWxVL3fJ3XXGDw" \
"/dns/bootnode-004.goldberg.avail.tools/tcp/30333/p2p/12D3KooWMuyLE3aPQ82HTWuPUCjiP764ebQrZvGUzxrYGuXWZJZV" \
"/dns/bootnode-005.goldberg.avail.tools/tcp/30333/p2p/12D3KooWKJwbdcZ7QWcPLHy3EJ1UiffaLGnNBMffeK8AqRVWBZA1" \
"/dns/bootnode-006.goldberg.avail.tools/tcp/30333/p2p/12D3KooWM8AaHDH8SJvg6bq4CGQyHvW2LH7DCHbdv633dsrti7i5" \
--reserved-only

[Install]
WantedBy=multi-user.target
EOF
```
### Başlatalım
```
systemctl daemon-reload && systemctl restart availd && journalctl -u availd -fo cat
```

Not: başlangıcta sürümün 1.10 olduğunu görün bele

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b13effd8-6e23-4961-b726-8a7215df6cbe)



