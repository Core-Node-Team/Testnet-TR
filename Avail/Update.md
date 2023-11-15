# <h1 align="center">Avail's Clash of Nodes Testnet Update</h1>

![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

Not: şuan için güncelleme gerekli yazmamışlar bi kaç düzeltme ve senkron hızı artırmışlar...
Not: ubuntu 22 içindir eğer ubuntu 20 için istiyorsanız uzun yoldan kurmanız gerekıyor...

```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```
```
rm -rf data-avail
rm -rf amd64-ubuntu-2204-data-avail.tar.gz
```
```
wget https://github.com/availproject/avail/releases/download/v1.8.0.2/amd64-ubuntu-2204-data-avail.tar.gz
```
```
tar xvzf amd64-ubuntu-2204-data-avail.tar.gz
```
```
mv amd64-ubuntu-2204-data-avail data-avail
```
```
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```
------------------------------------------

### Ubuntu 20 ( goldberg yada kate ağından ykseltecekseniz)
```
cd
cd avail
git pull
git checkout v1.8.0.2
```
### Kuralım
```
cargo build --release
```
Not: eğer eski kate ağından uzun kurulumu yaptıysanız alttaki servis dosyasınıda değiştirmeniz gerekiyor.... ve altaki kodu girip dataları silmeniz lazım eskisinin unutmayın kate den guncelleyecekseniz alttaki kod ve servis dosyası yapılacak
```
rm -rf /root/avail/data
```
### Servis oluşturalım.
NOT: molla202 yazan kısmı değiştiriniz explorerdeki görünen isminiz...
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
ExecStart=/root/avail/target/release/data-avail -d `pwd`/data --chain goldberg --port 30333 --validator --name "molla202"

[Install]
WantedBy=multi-user.target
EOF
```

### Nodu başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable availd.service
sudo systemctl restart availd.service
```

### Durmuna bakalım
```
sudo systemctl status availd.service
```

### Log kontrol
```
journalctl -f -u availd.service
```
