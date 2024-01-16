# <h1 align="center">Avail's Clash of Nodes Testnet Update</h1>

![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

Not: şuan için güncelleme gerekli yazmamışlar bi kaç düzeltme ve senkron hızı artırmışlar...
### Ubuntu 22
```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```
```
rm -rf data-avail
```
```
wget https://github.com/availproject/avail/releases/download/v1.9.0.0/x86_64-ubuntu-2204-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2204-data-avail.tar.gz
```

```
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```
--------------------
### Ubuntu 20 
```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```
```
rm -rf data-avail
```
```
wget https://github.com/availproject/avail/releases/download/v1.9.0.0/x86_64-ubuntu-2004-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```

```
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```

-------------------------
# UZUN YOLDAN KISA YOLA DÖNÜŞ
Not: uzun yoldan yapanlar update yapmaya kalkarsa pertingen kısa yola çevirelim
```
cd
sudo mkdir /root/avail-node/
cd /root/avail-node/
```

* Ubuntu 22 dosyası
```
wget https://github.com/availproject/avail/releases/download/v1.9.0.0/x86_64-ubuntu-2204-data-avail.tar.gz
```
//Not: aşağıdaki ubuntu 20 için olan 2sini bir yapmıyorsunuz.
```
wget https://github.com/availproject/avail/releases/download/v1.9.0.0/x86_64-ubuntu-2004-data-avail.tar.gz
```
### Zipten dosyaları çı çı çıkraaa :D (çıkaralım)
```
tar xvzf x86_64-ubuntu-2204-data-avail.tar.gz
```
//Not: aşağısı ubuntu 20 için olan
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```
```
sudo systemctl stop availd.service
```
* isim yazman ghereken yere ismini yaz `adınızı yazın` kısmına
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
ExecStart=/root/avail-node/data-avail -d `pwd`/data --chain goldberg --port 30333 --validator --name "adınızı yazın"

[Install]
WantedBy=multi-user.target
EOF
```

```
sudo systemctl daemon-reload
sudo systemctl enable availd.service
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```
