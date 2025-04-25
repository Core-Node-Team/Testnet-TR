# Tangle-Network

![image](https://github.com/molla202/Tangle-Network/assets/91562185/65a58a93-a5a4-4507-b789-7adeee085311)

### Discord : https://discord.gg/n5fx5xpt
## NOT: ubuntu 22

## Sistem Gereksinimleri istenilen
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 200 GB SSD |

## Sistem Gereksinimleri minimum
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2|
| RAM	| 4+ GB |
| Storage	| 200 GB SSD |

### Update
```
apt update && apt upgrade -y
```
### Gereklilikler
```
apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev libgmp3-dev tar clang bsdmainutils ncdu unzip llvm libudev-dev make protobuf-compiler -y
```
### Dosyaları çekiyoruz
```
sudo systemctl stop tangle
rm -r .tangle; mkdir -p $HOME/.tangle
rm -r /usr/bin/tangle
wget -O tangle https://github.com/webb-tools/tangle/releases/download/v0.6.1/tangle-testnet-linux-amd64 && chmod +x tangle
sudo mv tangle /usr/bin/
tangle --version
```


### Servis oluşturuyoruz
Not: `yourname=<name>` kısmında `<name>` değiştiriyoruz adımızı yazıyoruz.
```
yourname=<name>
```
```
tee /etc/systemd/system/tangle.service > /dev/null << EOF
[Unit]
Description=Tangle Validator Node
After=network-online.target
StartLimitIntervalSec=0
[Service]
User=$USER
Restart=always
RestartSec=3
LimitNOFILE=65535
ExecStart=/usr/bin/tangle \
  --base-path $HOME/.tangle/data/ \
  --name '$yourname' \
  --chain tangle-testnet \
  --node-key-file "$HOME/.tangle/node-key" \
  --port 30333 \
  --rpc-port 9933 \
  --prometheus-port 9615 \
  --pruning archive \
  --validator \
  --auto-insert-keys \
  --telemetry-url "wss://telemetry.polkadot.io/submit 0" \
  --no-mdns
[Install]
WantedBy=multi-user.target
EOF
```
### Servisi başlatıryoruz
```
systemctl daemon-reload
systemctl enable tangle
systemctl restart tangle && journalctl -u tangle -f -o cat
```
### Log komutu
```
journalctl -u tangle -f -o cat
```
### Panel işlemleri
* herhangi bir polka cüzdanı işimizi görecektir.

https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ftestnet-rpc.tangle.tools#/accounts

* adrese gidiyoruz ve cüzdan adresimizi kopyalıyoruz
* faucetten `testcoini` talep edıyoruz discord faucet kanalı 10 dane verıor 9 dane ile validator oluyoruz..
* daha sonra validator olmak için adrese gidiyoruz.

https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ftestnet-rpc.tangle.tools#/staking/actions

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/f7d61eb9-3484-442c-8031-450b5b8eed8c)


* validate diyoruz cüzdanımızı seçiyoruz. `9` adet deyip devam ediyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/4a284c8a-96de-4ea1-ae75-33c8c681c010)


* gelen ekranda `sezon keyi` girmemiz lazım almak için eşleşmesi bitmiş nodemuzda şu kodu giriyoruz

```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9933
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/7b31c8d0-22e7-4b7b-859d-f041a20f3053)


* daha sonrası normal şeyler zaten beklemede gorunucez 

https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ftestnet-rpc.tangle.tools#/staking

burda belirli dönemde onaylandıktan sonra aktive geçicez .

* Lider toplasında puanlar zamanla yansıyacak

https://leaderboard.tangle.tools/

### Nodu silmek
```
systemctl stop tangle && \
systemctl disable tangle && \
rm /etc/systemd/system/tangle.service && \
systemctl daemon-reload && \
cd \
rm -r .tangle
```

