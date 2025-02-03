





# <h1 align="center">Avail-Mainnet</h1>
![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

* [Twitter](https://twitter.com/AvailProject)
* [Discord](https://discord.gg/y6fHnxZQX8)
* [Website](https://www.availproject.org/)
* [Docs](https://docs.availproject.org/clash-of-nodes/challenges/)
* [Github](https://github.com/availproject/avail/releases)

FAUCET : https://faucet.avail.tools/ 

# Public RPC
```
https://mainnet-rpc.corenodehq.xyz
```
```
wss://mainnet-rpc.corenodehq.xyz
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
wget https://github.com/availproject/avail/releases/download/v2.2.4.1/x86_64-ubuntu-2204-avail-node.tar.gz
```
------------------------
Not: aşağıdaki ubuntu 20 için olan 2sini bir yapmıyorsunuz.  
```
wget https://github.com/availproject/avail/releases/download/v2.2.4.1/x86_64-ubuntu-2004-avail-node.tar.gz
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
ExecStart=/root/avail-node/avail-node -d /root/avail-node/data --chain mainnet --port 30333 --validator --name "molla202"

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

https://explorer.avail.so/?rpc=wss%3A%2F%2Fmainnet-rpc.corenode.info#/accounts

not: telemetry den ismizi yazarak bakınız.

https://telemetry.avail.so/#list/0xb91746b45e0346cc2f815a520b9c6cb4d5c0902af848db0a80f85932d2e8276a

![image](https://github.com/user-attachments/assets/5d53a337-954e-4df3-88e3-057620da2e7e)




### Sezon keyi oluşturuyoruz sunucumuzda (daha lazım değil gerenk yok)
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9944
```
OR PORT and change up link end port number. portlara bakınız eğer farklı ise veya değiştirdiyseniz yukarıdaki linkin sonundaki portu ona göre ayarlayınız...
```
sudo lsof -i -P -n | grep LISTEN
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5a8cd641-6a07-4fcc-9a54-6d27a4ba49ae)
