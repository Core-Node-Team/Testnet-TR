# Avail's Clash of Nodes Testnet
## NOT: eski avail yerine kuracaksanız alt kısma bakın. lütfen tüm dokumanı okuyun.

![image](https://github.com/molla202/Avail/assets/91562185/6b726a06-d16c-4455-89a5-321ead104e37)

Not: Ubuntu 22 istiyore

### Update ve gereklilikleri yükleyelim

```
sudo apt update
sudo apt install make clang pkg-config libssl-dev build-essential
```

### Create Avail File
```
cd ..
```

### Create Avail File in home Directory
```
sudo mkdir /root/avail-node/
```

### Go To Avail File You Created
```
cd /root/avail-node/
```

### Download The Required Files
```
wget https://github.com/availproject/avail/releases/download/v1.8.0.0/amd64-ubuntu-2204-data-avail.tar.gz
```

### Zipten dosyaları çı çı çıkraaa :D (çıkaralım)
```
tar xvzf amd64-ubuntu-2204-data-avail.tar.gz
```
```
mv amd64-ubuntu-2204-data-avail data-avail
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
ExecStart=/root/avail-node/data-avail -d /root/avail-node/data --chain goldberg --port 30333 --validator --name "molla202"

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

### Cüzdan olusturma

https://kate.avail.tools/

not: telemetry den ismizi yazarak bakınız.

https://telemetry.avail.tools/#list/0x6f09966420b2608d1947ccfb0f2a362450d1fc7fd902c29b67c906eaa965a7ae

![image](https://github.com/molla202/Avail/assets/91562185/85b2a9c3-7821-41f0-86c6-9b4a1b175cc3)



### Sezon keyi oluşturuyoruz sunucumuzda (daha lazım değil gerenk yok)
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9933
```


# Silme
```
sudo systemctl stop availd.service
sudo systemctl disable availd.service
rm -rf /root/avail-node
```

-----------------------------------------------------
# Eski kurulum olan yere kurucaksanız
```
rm -rf /root/avail-node/data
```

```
cd /root/avail-node/
```

### Download The Required Files
```
wget https://github.com/availproject/avail/releases/download/v1.8.0.0/amd64-ubuntu-2204-data-avail.tar.gz
```

### Zipten dosyaları çı çı çıkraaa :D (çıkaralım)
```
tar xvzf amd64-ubuntu-2204-data-avail.tar.gz
```
```
mv amd64-ubuntu-2204-data-avail data-avail
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
ExecStart=/root/avail-node/data-avail -d /root/avail-node/data --chain goldberg --port 30333 --validator --name "molla202"

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











