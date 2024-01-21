
![artela](https://github.com/molla202/Artela/assets/91562185/a7922117-442e-4bbf-b56a-1d11e09670f7)

## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Artela Resmi Websitesi](https://artela.network/)
 * [Artela Resmi Twitter](https://twitter.com/Artela_Network)
 * [Artela Resmi Discord](https://discord.gg/TzmnmuCU)
 * [Artela Dökümantasyon](https://docs.artela.network/develop/node/run-full-node)
 * [Artela Tüm Linkler](https://linktr.ee/artela_network)
 * [Artela EXPLORER](https://test.explorer.ist/artela/staking)


Not: teşvik bilinmiyor...

### Not: faucet almak için cüzdan olusturduktan sonra altaki kodla adresinizi öğrenin Address (EIP-55): adresiniz burda yazıor
```
artelad debug addr art-ile-başlayancüzdan-adresinizi-yazınız
```



### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4 vcpu|
| ✔️RAM	| 8 GB |
| ✔️Storage	| 200+ GB SSD |
| ✔️UBUNTU | 20or22 |


### Update ve gereklilikler
```
apt update && apt upgrade -y
apt install curl iptables build-essential git wget jq make gcc nano tmux htop lz4 nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
```
### Go kurulum
```
ver="1.20.3"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
### Varyasyonlar (moniker ve cüzdan adınızı değiştiriniz)
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="test"" >> $HOME/.bash_profile
echo "export ARTELA_CHAIN_ID="artela_11822-1"" >> $HOME/.bash_profile
echo "export ARTELA_PORT="45"" >> $HOME/.bash_profile
source $HOME/.bash_profile

cd $HOME
rm -rf artela
git clone https://github.com/artela-network/artela
cd artela
git checkout v0.4.7-rc6
make install

artelad config chain-id artela_11822-1
artelad init "$MONIKER" --chain-id artela_11822-1

wget -qO $HOME/.artelad/config/genesis.json https://raw.githubusercontent.com/Core-Node-Team/scripts/main/artela/genesis.json
wget -qO $HOME/.artelad/config/addrbook.json https://raw.githubusercontent.com/Core-Node-Team/scripts/main/artela/addrbook.json


SEEDS="8d0c626443a970034dc12df960ae1b1012ccd96a@artela-testnet-seed.itrocket.net:30656"
PEERS="5c9b1bc492aad27a0197a6d3ea3ec9296504e6fd@artela-testnet-peer.itrocket.net:30656,e60ccf5954cf2f324bbe0da7eada0a98437eab29@[2a03:4000:4c:e90:781d:c8ff:fe57:726a]:9656,cc926b13a1be8b3c82cbca5bc137c04055c29d66@54.197.218.54:26656,9142bc72d918a36754d64e90f66b382f6d98f67b@161.35.157.41:45656,615a32fbf484e711562fe93b64cc069e1e5f49ab@185.230.138.142:45656,4ff33861644ebda5fb004130de5167a5a39637a9@95.216.192.62:45656,3a280a539aa874a98e4d2cdfa70118e8c14b6745@95.214.55.138:3656,a5dcbab0007379945faf3b32399ef7d7cdaa8b2c@84.247.160.45:45656,2264c863bead1e2822c52d1b553becf9d8089855@[2400:8905::f03c:94ff:fecf:710]:26656,9646a4585197da3edd5b91c73b0ffa6e2b47c36a@45.85.147.242:45656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.artelad/config/config.toml


sed -E 's/^pool-size[[:space:]]*=[[:space:]]*[0-9]+$/apply-pool-size = 10\nquery-pool-size = 30/' ~/.artelad/config/app.toml > ~/.artelad/config/temp.app.toml && mv ~/.artelad/config/temp.app.toml ~/.artelad/config/app.toml


sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.artelad/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.artelad/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.artelad/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.artelad/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.025art"|g' $HOME/.artelad/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.artelad/config/config.toml
sed -i 's|^indexer *=.*|indexer = "null"|' $HOME/.artelad/config/config.toml

# set custom ports in app.toml
sed -i.bak -e "s%:1317%:${ARTELA_PORT}317%g;
s%:8080%:${ARTELA_PORT}080%g;
s%:9090%:${ARTELA_PORT}090%g;
s%:9091%:${ARTELA_PORT}091%g;
s%:8545%:${ARTELA_PORT}545%g;
s%:8546%:${ARTELA_PORT}546%g;
s%:6065%:${ARTELA_PORT}065%g" $HOME/.artelad/config/app.toml

# set custom ports in config.toml file
sed -i.bak -e "s%:26658%:${ARTELA_PORT}658%g;
s%:26657%:${ARTELA_PORT}657%g;
s%:6060%:${ARTELA_PORT}060%g;
s%:26656%:${ARTELA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${ARTELA_PORT}656\"%;
s%:26660%:${ARTELA_PORT}660%g" $HOME/.artelad/config/config.toml

sudo tee /etc/systemd/system/artelad.service > /dev/null << EOF
[Unit]
Description=artela node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which artelad) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

### snap
```
artelad tendermint unsafe-reset-all --home $HOME/.artelad --keep-addr-book

curl -L http://37.120.189.81/artela_testnet/artela_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.artelad
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable artelad
sudo systemctl start artelad
```
### Log
```
sudo journalctl -fu artelad -o cat
```

### Cüzdan olusturma

artelad keys add cüzdan-adı

### validator olusturma
Not: 2 defa faucet alıp yapın.moniker ve cüzdan adınızı yazınız
```
artelad tx staking create-validator \
--amount 950000uart \
--from cüzdan-adınız \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(artelad tendermint show-validator) \
--moniker "moniker-adınız" \
--identity="" \
--website="" \
--details="Mustafa Kemal ATATÜRK❤️" \
--chain-id artela_11822-1 \
--gas auto \
--gas-adjustment 1.4 \
--gas-prices 0.055uart \
--node http://localhost:45657 \
-y
```
### Delege
Not: cüzdan-adınız kısımlarını değiştiriniz.
```
artelad tx staking delegate $(artelad keys show cüzdan-adınız --bech val -a) 1.5art --from cüzdan-adınız --chain-id artela_11822-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.025uart --node http://localhost:45657 -y
```

## Başvuur formu : [TIKLA](https://t.co/EPAoUcWriG)https://t.co/EPAoUcWriG
