
# <h1 align="center">Avail Light Node Kurulumu</h1>
![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)


## Linkler:
 * [Avail Resmi Websitesi](https://www.availproject.org/)
 * [Avail Resmi Twitter](https://twitter.com/AvailProject)
 * [Avail Resmi Discord](https://discord.gg/kkHAXZCNZa)
 * [Avail Light Node Dökümantasyon](https://docs.availproject.org/operate/node/light-client/)
 * [Avail Light Node Form](https://docs.google.com/forms/d/e/1FAIpQLSeL6aXqz6vBbYEgD1cZKaQ4vwbN2o3Rxys-wKTuKySVR-oS8g/viewform)

#### Kurulum Video : [LINK](https://www.youtube.com/watch?v=ToiTJdsGf_o&t)
#### Cüzdan import video : [LINK](https://www.youtube.com/watch?v=GcT0J6IUhI8)

### Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	2+ vcpu|
| ✔️RAM	| 4+ GB |
| ✔️Storage	| 40+ GB SSD |
| ✔️UBUNTU | 22 |

## Update
```
sudo apt update && sudo apt upgrade -y
sudo apt-get install make curl clang pkg-config libssl-dev build-essential
```
```
screen -S alight
```

### Avail Light Client'i yükleyin UBUNTU 22
```
cd
wget https://github.com/availproject/avail-light/releases/download/v1.7.10/avail-light-linux-amd64.tar.gz
tar -xvzf avail-light-linux-amd64.tar.gz
mv avail-light-linux-amd64 avail-light
rm -rf avail-light-linux-amd64.tar.gz
```
```
mkdir -p $HOME/.avail/config
curl -Ls https://raw.githubusercontent.com/molla202/Avail/main/config.yml > $HOME/.avail/config/config.yml
```


#### Servis dosyasını oluşturalım.
```
sudo tee /etc/systemd/system/availd.service > /dev/null <<EOF
[Unit]
Description=Avail Light Client
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
ExecStart=/root/avail-light \
--config /root/.avail/config/config.yml \
--app-id 0
 
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF
```

#### Başlatalım
```
sudo systemctl daemon-reload
systemctl enable availd
sudo systemctl restart availd
```

## Loglar
```
journalctl -u availd -fo cat
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6c65bb10-3b46-4df8-a5b3-7cbf59e58cdc)



#### Son blok görüntüleme
```
curl "http://localhost:7000/v1/latest_block"
```
## Cüzdan import yapacaksanız sadece bu
```
nano /identity.toml
```
- görunmuyorsa bu
```
nano /root/.avail/identity/identity.toml
```
- içerisindeki kelimelerle kendi cüzdanınızın kelimeleri değiştirip ctrl x y enterla kaydedelim
```
systemctl daemon-reload && systemctl restart availd && journalctl -u availd -fo cat
```
- başlayınca cüzdan adresi görunecek sizin cüzdanınızmı kontrol edin
-------------------

## <h1 align="center">Avail Light Node ubuntu 20 kısa yol </h1>

## Update
```
sudo apt update && sudo apt upgrade -y
sudo apt-get install make clang pkg-config libssl-dev build-essential
```
```
screen -S alight
```

### Avail Light Client'i yükleyin
```
cd
wget https://github.com/molla202/Avail/raw/main/avail-light.tar.gz
tar -xvzf avail-light.tar.gz
chmod 744 avail-light
```
```
mkdir -p $HOME/.avail/config
curl -Ls https://raw.githubusercontent.com/molla202/Avail/main/config.yml > $HOME/.avail/config/config.yml
```


#### Servis dosyasını oluşturalım.
```
sudo tee /etc/systemd/system/availd.service > /dev/null <<EOF
[Unit]
Description=Avail Light Client
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
ExecStart=/root/avail-light \
--config /root/.avail/config/config.yml \
--app-id 0
 
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF
```

#### Başlatalım
```
sudo systemctl daemon-reload
systemctl enable availd
sudo systemctl restart availd
```

## Loglar
```
journalctl -u availd -fo cat
```
#### Son blok görüntüleme
```
curl "http://localhost:7000/v1/latest_block"
```
## Cüzdan import yapacaksanız sadece bu
```
nano /identity.toml
```
- görunmuyorsa bu
```
nano /root/.avail/identity/identity.toml
```
- içerisindeki kelimelerle kendi cüzdanınızın kelimeleri değiştirip ctrl x y enterla kaydedelim
```
systemctl daemon-reload && systemctl restart availd && journalctl -u availd -fo cat
```
- başlayınca cüzdan adresi görunecek sizin cüzdanınızmı kontrol edin
