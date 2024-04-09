<h1 align="center"> Tangle-Mainnet

![6494599436915879aa403230_Tangle Logo](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5ca31aae-4def-4d8f-8384-bed84448a08b)


</h1>

## NOT: ubuntu 22
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
mkdir -p $HOME/.tangle && cd $HOME/.tangle
wget -O tangle https://github.com/webb-tools/tangle/releases/download/v1.0.0/tangle-default-linux-amd64
chmod 744 tangle
mv tangle /usr/bin/
tangle --version
```
```
wget https://github.com/webb-tools/tangle/blob/main/chainspecs/mainnet/tangle-mainnet.json
mv $HOME/tangle-mainnet.json $HOME/.tangle/tangle-mainnet.json
```
### Servis oluşturuyoruz
Not: node adini yaz kısmına adınızı yazınız....
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
  --name 'node-adini-yaz' \
  --chain $HOME/.tangle/tangle-mainnet.json \
  --node-key-file "$HOME/.tangle/node-key" \
  --port 30334 \
  --rpc-port 9934 \
  --prometheus-port 9616 \
  --validator \
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
```


### Keyleri oluşturalım
NOT:kelimeleri yaz   kısmına explorerde bir cüzdan oluşturup onun kelimelerini yazın kaydetmeyide unutmayın...
#### Account Keys
```
tangle key insert \
--scheme Sr25519 \
--suri "kelimeleri yaz" \
--base-path $HOME/.tangle/data/ \
--chain $HOME/.tangle/tangle-mainnet.json \
--key-type acco
```
#### Babe Keys
```
tangle key insert \
--base-path $HOME/.tangle/data/ \
--chain $HOME/.tangle/tangle-mainnet.json \
--scheme Sr25519 \
--suri "kelimeleri yaz" \
--key-type babe
```
#### Im-online Keys - these keys are optional
```
tangle key insert \
--base-path $HOME/.tangle/data/ \
--chain $HOME/.tangle/tangle-mainnet.json \
--scheme Sr25519 \
--suri "kelimeleri yaz" \
--key-type imon
```
#### Role Keys
```
tangle key insert \
--base-path $HOME/.tangle/data/ \
--chain $HOME/.tangle/tangle-mainnet.json \
--scheme Ecdsa \
--suri "kelimeleri yaz" \
--key-type role
```
#### Grandpa Keys

 ```
tangle key insert \
--base-path $HOME/.tangle/data/ \
--chain $HOME/.tangle/tangle-mainnet.json \
--scheme Ed25519 \
--suri "kelimeleri yaz" \
--key-type gran
```

### BAşlatalım artık

#### Log komutu
```
systemctl restart tangle && journalctl -u tangle -f -o cat
journalctl -u tangle -f -o cat
```
### Sezon key olusturma
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9934
```
### gerekli linkler
- Explorer

https://polkadot.js.org/apps/?rpc=wss://rpc.tangle.tools#/accounts

- Claim linki

https://app.tangle.tools/claim

- Telemetry

https://telemetry.avail.so/#list/0xd3d2f3a3495dc597434a99d7d449ebad6616db45e4e4f178f31cc6fa14378b70
