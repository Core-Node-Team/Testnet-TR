


# <h1 align="center">Avail's Clash of Nodes Testnet</h1>
![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

* [Twitter](https://twitter.com/AvailProject)
* [Discord](https://discord.gg/y6fHnxZQX8)
* [Website](https://www.availproject.org/)
* [Docs](https://docs.availproject.org/clash-of-nodes/challenges/)
* [Github](https://github.com/availproject/avail/releases)

#### Kurulum Video : [LINK](https://www.youtube.com/watch?v=po4sDoMie6Q&t)

## NOT: eski avail yerine kuracaksanız alt kısma bakın. lütfen tüm dokumanı okuyun.

Not: Ubuntu 22 istiyore ancak 20 binary de eklendi kurarken ona dikkat edin ubuntunuz neyse onu kurun 20 özellikle belirtilmiştir.

### Update ve gereklilikleri yükleyelim

```
sudo apt update
sudo apt install make clang pkg-config libssl-dev build-essential
```

### Dosya olusturuyoruz
```
cd
sudo mkdir /root/avail-node/
```
```
cd /root/avail-node/
```

### Dosyaları çekiyoruz
```
wget https://github.com/availproject/avail/releases/download/v1.11.0.0/x86_64-ubuntu-2204-data-avail.tar.gz
```
------------------------
Not: aşağıdaki ubuntu 20 için olan 2sini bir yapmıyorsunuz.  
```
wget https://github.com/availproject/avail/releases/download/v1.11.0.0/x86_64-ubuntu-2004-data-avail.tar.gz
```
------------------------
### Zipten dosyaları çı çı çıkraaa :D (çıkaralım)
```
tar xvzf x86_64-ubuntu-2204-data-avail.tar.gz
```


------------------
Not: aşağısı ubuntu 20 için olan
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```

------------------------
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

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6a28e76b-c059-4878-9956-ecea4d8ac268)


### Cüzdan olusturma

https://goldberg.avail.tools/#/staking

not: telemetry den ismizi yazarak bakınız.

https://telemetry.avail.tools/#list/0x6f09966420b2608d1947ccfb0f2a362450d1fc7fd902c29b67c906eaa965a7ae

![image](https://github.com/molla202/Avail/assets/91562185/85b2a9c3-7821-41f0-86c6-9b4a1b175cc3)



### Sezon keyi oluşturuyoruz sunucumuzda (daha lazım değil gerenk yok)
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9944
```
OR PORT and change up link end port number. portlara bakınız eğer farklı ise veya değiştirdiyseniz yukarıdaki linkin sonundaki portu ona göre ayarlayınız...
```
sudo lsof -i -P -n | grep LISTEN
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5a8cd641-6a07-4fcc-9a54-6d27a4ba49ae)


# Silme
```
sudo systemctl stop availd.service
sudo systemctl disable availd.service
rm -rf /root/avail-node
```

-----------------------------------------------------

-------------------------------------------------------------------
Not:seçilirseniz validator nasıl olursunuz...

https://goldberg.avail.tools/#/staking/actions

- Sağ kısımdan validatore tıklıyoruz

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/d1a6161f-6c49-46a7-82f4-2f290de3e6ea)

- Sezon keyi olusturmustuk bundaki `"result":` dan sonraki uzun adresi kopyalıyoruz
- validator demiştik açılan ekranda stake miktarı belirliyoruz ileri diyoruz
- ve bizden key soruyor yazıyoruz ileri deyip cüzdandan onaylıyoruz. unutmayın polkadot cüzdanı lazım.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/52029b07-2968-4495-a34c-8113b78cd865)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/788a4687-66f7-4dd4-8faf-1d6e42e32591)


------------------------------------
# Ubuntu 20 yani uzun versiyon kurulum... (intel cpucular)


## Update
```
sudo apt update && sudo apt upgrade -y
sudo apt install make clang pkg-config libssl-dev build-essential git screen protobuf-compiler -y
```



### Rust kuralım
```
curl https://sh.rustup.rs -sSf | sh
```
Not: 1 seçiyoruz
```
source $HOME/.cargo/env
rustup update nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
```
```
screen -S alight
```
### Dosyaları çekelim
```
git clone https://github.com/availproject/avail.git
cd avail
git checkout v1.11.0.0
```
### Kuralım
```
cargo build --release
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






