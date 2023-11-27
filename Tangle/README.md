# Tangle-Network

![image](https://github.com/molla202/Tangle-Network/assets/91562185/65a58a93-a5a4-4507-b789-7adeee085311)


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
wget -O tangle https://github.com/webb-tools/tangle/releases/download/v0.4.7/tangle-standalone-linux-amd64
chmod 744 tangle
mv tangle /usr/bin/
tangle --version
```

### Ağ dosyasını çekiyoruz
```
wget -O $HOME/.tangle/tangle-standalone.json "https://raw.githubusercontent.com/webb-tools/tangle/main/chainspecs/testnet/tangle-standalone.json"
chmod 744 ~/.tangle/tangle-standalone.json
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
  --chain $HOME/.tangle/tangle-standalone.json \
  --node-key-file "$HOME/.tangle/node-key" \
  --port 30333 \
  --rpc-port 9933 \
  --prometheus-port 9615 \
  --auto-insert-keys \
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
systemctl restart tangle && journalctl -u tangle -f -o cat
```
### Log komutu
```
journalctl -u tangle -f -o cat
```
### Panel işlemleri
* herhangi bir polka cüzdanı işimizi görecektir.
https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc.tangle.tools&ref=blog.webb.tools#/accounts
* adrese gidiyoruz ve cüzdan adresimizi kopyalıyoruz
* faucetten `testcoini` talep edıyoruz https://faucet.tangle.tools/ twit bağlama gbi öncelikler var aynı amanda takip.  ağdan tangleyi seçiyoruz. 2 tip talep yontemi var biri pola diğeri mm adresi
* daha sonra validator olmak için adrese gidiyoruz.
https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc.tangle.tools&ref=blog.webb.tools#/staking/actions

![image](https://github.com/molla202/Tangle-Network/assets/91562185/93fad2ef-5d27-40d3-9701-b8d7f1c8ee2b)

* validate diyoruz cüzdanımızı seçiyoruz. `1` adet deyip devam ediyoruz.

![image](https://github.com/molla202/Tangle-Network/assets/91562185/674b3116-4d04-4537-a101-18bc432d6825)

![image](https://github.com/molla202/Tangle-Network/assets/91562185/26e31fed-2ac9-43b0-b487-f9b2fd951339)

* gelen ekranda `sezon keyi` girmemiz lazım almak için eşleşmesi bitmiş nodemuzda şu kodu giriyoruz
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9933
```

* daha sonrası normal şeyler zaten beklemede gorunucez https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc.tangle.tools&ref=blog.webb.tools#/staking bu rda belirli dönemde onaylandıktan sonra aktive geçicez suan validator limiti 20 yukseltilicektir.

* yedek almayı unutmayınız. aşağıdaki yerdeki dosyaları yedekleyiniz taşımakta laızm olucak taşımak için normal kurun eşleşin sonra durdurup key dosyalarını değiştirip başlatın

`$HOME/.tangle/node-key`

`$HOME/.tangle/data/chains/tangle-standalone-testnet/keystore/`


### Nodu silmek
```
systemctl stop tangle && \
systemctl disable tangle && \
rm /etc/systemd/system/tangle.service && \
systemctl daemon-reload && \
cd \
rm -r .tangle
```

