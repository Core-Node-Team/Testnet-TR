





# <h1 align="center">Avail-Turing</h1>
![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

* [Twitter](https://twitter.com/AvailProject)
* [Discord](https://discord.gg/y6fHnxZQX8)
* [Website](https://www.availproject.org/)
* [Docs](https://docs.availproject.org/clash-of-nodes/challenges/)
* [Github](https://github.com/availproject/avail/releases)

FAUCET : https://faucet.avail.tools/ 

# Public RPC
```
https://turing-rpc.corenode.info
```
```
wss://turing-rpc.corenode.info
```
#### Kurulum Video : [LINK](https://www.youtube.com/watch?v=po4sDoMie6Q&t)



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
wget https://github.com/availproject/avail/releases/download/v2.1.0.0-rc1/x86_64-ubuntu-2204-avail-node.tar.gz
```
------------------------
Not: aşağıdaki ubuntu 20 için olan 2sini bir yapmıyorsunuz.  
```
wget https://github.com/availproject/avail/releases/download/v2.1.0.0-rc1/x86_64-ubuntu-2004-avail-node.tar.gz
```
------------------------
### Zipten dosyaları çı çı çıkraaa :D (çıkaralım)
```
tar xvzf x86_64-ubuntu-2204-avail-node.tar.gz
```


------------------
Not: aşağısı ubuntu 20 için olan
```
tar xvzf x86_64-ubuntu-2004-avail-node.tar.gz
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
ExecStart=/root/avail-node/avail-node -d /root/avail-node/data --chain turing --port 30333 --validator --name "molla202"

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

https://explorer.avail.so/?rpc=wss%3A%2F%2Fturing-rpc.corenode.info&light=https%3A%2F%2Fapi.lightclient.turing.avail.so%2Fv1#/explorer

not: telemetry den ismizi yazarak bakınız.

https://telemetry.avail.so/#list/0xd3d2f3a3495dc597434a99d7d449ebad6616db45e4e4f178f31cc6fa14378b70

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
