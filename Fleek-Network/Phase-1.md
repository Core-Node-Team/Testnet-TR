
<div align="center">
  <h1>Fleek-Network Testnet-alpha-1 </h1>
</div>

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/74fad132-3c1f-4bf8-a90a-9afa5cba3f64)


* [CoreNode Telegram](https://t.me/corenodechat)<br>
* [CoreNode Twitter](https://twitter.com/corenodeHQ)<br>
* [Fleek Network](https://fleek.network/)<br>
* [Fleek Network Twitter](https://twitter.com/fleek_net)<br>
* [Fleek Network DOC](https://docs.fleek.network/docs)<br>


 ## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️ CPU |	4 |
| ✔️ RAM	| 16 GB |
| ✔️ Storage	| ~GB SSD |


### Portları açınız. daha sonra ister manuel ister oto kurulumu tercih edebilirsiniz.
```
ufw allow 4230
ufw allow 4200
ufw allow 6969
ufw allow 18000
ufw allow 18101
ufw allow 18102
```
### RESMİ OTO KURULUM UBUNTU 22 HERSEY DAHİL

```
sudo fallocate -l 10240M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
```
adduser lgtn
```
```
usermod -aG sudo lgtn
```
```
su lgtn
```

```
curl https://get.fleek.network | bash
```
NOT: ekranda gözükmesse keyler...
```
lgtn keys show
```
### durumuna bakalım...
```
sudo systemctl status lightning.service
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/87cb0357-c904-406a-ba4f-0484fc2ca2e2)


### Log kontrol
```
tail -f /var/log/lightning/output.log
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/26aa640f-43e5-4fec-a8d6-c2aa4957435b)


```
tail -f /var/log/lightning/diagnostic.log
```
#### oto detay öğrenme
```
curl https://get.fleek.network/node_details | bash
```
#### oto healt check
```
curl https://get.fleek.network/healthcheck | bash
```
#### healt check
Not: internet tarayıcısına ipnizi yazarak bakıcaksınız
```
http://sunucuipsi:4230/health
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b5d5703a-4274-4872-a8ae-d69dd24c3689)


# MANUEL KURULUM....
### 🏠 Update edelim
```bash
sudo apt update; sudo apt upgrade 
```
### 🤖 Gerekli olanlar
```
sudo apt install screen curl tar wget jq build-essential make clang pkg-config libssl-dev cmake gcc
```
### 🤖 Rustup kuruyoruz
✏️ Not: 1 seçeceksiniz. daha önce kuruluysa kurmanıza gerek yok.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source ~/.profile
source ~/.cargo/env
```
### 🤖 Protobuf ve sccache Kuruyoruz
```
cargo install sccache
```
```
sudo apt-get install protobuf-compiler
```
### diski ram oalrka kullanalım kurarken hata vermesin diye
```
sudo fallocate -l 10240M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
### 👷 `fleek-network/lightning.git` 'i klonluyoruz.
```
cd $HOME 
git clone -b testnet-alpha-1 https://github.com/fleek-network/lightning.git ~/lightning
cd lightning
```
```
cargo +stable build --release
```
```
sudo rm -f "/usr/local/bin/lgtn"
sudo ln -s "$HOME/lightning/target/release/lightning-node" /usr/local/bin/lgtn
```
### 🚀 key alma işlemi...

```
lgtn keys generate
```
### servis olarak çalıştıralım...
```
sudo tee /etc/systemd/system/lightning.service > /dev/null <<EOF
[Unit]
Description=Fleek Network Node lightning service
    
[Service]
User=root
Type=simple
MemoryHigh=32G
RestartSec=15s
Restart=always
ExecStart=lgtn -c /home/lgtn/.lightning/config.toml run
StandardOutput=append:/var/log/lightning/output.log
StandardError=append:/var/log/lightning/diagnostic.log
Environment=TMPDIR=/var/tmp
    
[Install]
WantedBy=multi-user.target
EOF
```
```
sudo mkdir -p /var/log/lightning
sudo touch /var/log/lightning/output.log
sudo touch /var/log/lightning/diagnostic.log
```
```
sudo systemctl daemon-reload
sudo systemctl enable lightning
sudo systemctl restart lightning
```
### durumuna bakalım...
```
sudo systemctl status lightning.service
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/87cb0357-c904-406a-ba4f-0484fc2ca2e2)

### Log kontrol
Not: loglar akmaya bilir hata görebilirsiniz. aşağıda miint ve stake sayfası var ordan devam edin
```
tail -f /var/log/lightning/output.log
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/26aa640f-43e5-4fec-a8d6-c2aa4957435b)

```
tail -f /var/log/lightning/diagnostic.log
```

# Devamı aşağıdan

https://github.com/Core-Node-Team/Testnet-TR/blob/main/Fleek-Network/Phase-1-mint-stake.md

---------------


### ♻️ Key dosyası yedekleme
* Dosyalarınız bu konumda yer alıyor. ``~/.lightning/keystore``  yedekleyiniz.alttaki kod port değişikliği için deneyeceğiz :D
```
nano ~/.lightning/config.toml
```

-------------------
### Docker versiyon (alternatif) YAPIM AŞAMASINDA !!! BURASI DAHİL DEĞİLDİR. ALTERNATİFTİR VE BİTMEMİŞTİR...

### Update & docker kurulum 
```
sudo apt-get update && sudo apt install jq git && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
```
```
sudo docker run --name lightning-node -d \
    -p 4230:4230 \
    -p 4200:4200 \
    -p 6969:6969 \
    -p 18000:18000 \
    -p 18101:18101 \
    -p 18102:18102 \
    --mount type=bind,source=$HOME/.lightning,target=/root/.lightning \
    -it ghcr.io/fleek-network/lightning:latest
```

### keyleri görmek için
```
docker exec -it lightning-node lightning-node keys show
```
### key olusturmamışsa olusturmak için
```
docker exec -it lightning-node lightning-node keys generate
```

## Log
```
sudo docker logs -f lightning-node
```
