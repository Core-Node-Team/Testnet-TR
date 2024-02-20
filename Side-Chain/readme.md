<h1 align="center"> Side Protocol </h1>


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/00bf3951-733f-42d5-8f41-9bc67c06a6e8)



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Side Website](https://side.one)<br>
 * [Blockchain Explorer](https://testnet.itrocket.net/side/staking)<br>
 * [Discord](https://discord.gg/sideprotocol)<br>
 * [Twitter](https://twitter.com/SideProtocol)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |




### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

### 🚧Go kurulumu
```
cd $HOME
VER="1.21.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```
### 🚧Varyasyon atama - cüzdan adını ve moniker adını değiştirin.
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="Adını-yaz"" >> $HOME/.bash_profile
echo "export SIDE_CHAIN_ID="side-testnet-1"" >> $HOME/.bash_profile
echo "export SIDE_PORT="48"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### 🚧Dosyaları çekelim ve kuralım
```
cd $HOME
rm -rf sidechain
git clone -b dev https://github.com/sideprotocol/sidechain.git
cd sidechain
git checkout 0.0.1-75-gbd63479
make install
```
### 🚧İnit
Not: adınızı yazın 
```
sided config node tcp://localhost:${SIDE_PORT}657
sided config keyring-backend os
sided config chain-id side-testnet-1
```
```
sided init "Adını-yaz" --chain-id side-testnet-1
```
### 🚧Genesis ve addrbook
```
wget -O $HOME/.sidechain/config/genesis.json http://37.120.189.81/side_testnet/genesis.json
wget -O $HOME/.sidechain/config/addrbook.json http://37.120.189.81/side_testnet/addrbook.json
```
### Seed peer
```
SEEDS="9c14080752bdfa33f4624f83cd155e2d3976e303@side-testnet-seed.itrocket.net:45656"
PEERS="bbbf623474e377664673bde3256fc35a36ba0df1@side-testnet-peer.itrocket.net:45656,2ca1a2f1170df5ecb55dcae5e976d6dbb85e3b6b@65.109.92.148:61456,ad731aefa7582d59b4de7c9063e87dc90d98fa8f@78.46.45.174:12656,5e0b5f26e4c069fbcaac1ae4b22aba151e463a52@65.108.79.241:60856,cb0c64e85255d127d5e9c16f7db9c995b3600c37@152.228.208.164:26656,fad59a438051161be332714505e86a5da4920bc4@109.123.242.217:21306,09ea56a225a4c3e525ae4cfc1311157dbcbe33c9@141.95.65.26:24966,00e0d0a39d56bb945de4d4179ae0bd49679cac65@65.108.206.118:46656,08f006100a637b2fea09eab6c124949fe437af3e@37.27.69.161:36656,db165a039236165c8c1225c1c793320593ce2b35@65.109.68.87:21656,91b6c3d622e28752c428091ca47eb463b63d14de@162.55.4.42:11356"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sidechain/config/config.toml
```
### 🚧Port ayar
```
sed -i.bak -e "s%:1317%:${SIDE_PORT}317%g;
s%:8080%:${SIDE_PORT}080%g;
s%:9090%:${SIDE_PORT}090%g;
s%:9091%:${SIDE_PORT}091%g;
s%:8545%:${SIDE_PORT}545%g;
s%:8546%:${SIDE_PORT}546%g;
s%:6065%:${SIDE_PORT}065%g" $HOME/.sidechain/config/app.toml
```
### 🚧Port ayar
```
sed -i.bak -e "s%:26658%:${SIDE_PORT}658%g;
s%:26657%:${SIDE_PORT}657%g;
s%:6060%:${SIDE_PORT}060%g;
s%:26656%:${SIDE_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${SIDE_PORT}656\"%;
s%:26660%:${SIDE_PORT}660%g" $HOME/.sidechain/config/config.toml
```
### 🚧Puring
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.sidechain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.sidechain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.sidechain/config/app.toml
```
### 🚧Gas ve diğer ayarlar
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.005uside"|g' $HOME/.sidechain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.sidechain/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.sidechain/config/config.toml
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/sided.service > /dev/null <<EOF
[Unit]
Description=Side node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.sidechain
ExecStart=$(which sided) start --home $HOME/.sidechain
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### 🚧Snap
```
sided tendermint unsafe-reset-all --home $HOME/.sidechain
if curl -s --head curl http://37.120.189.81/side_testnet/side_snap.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl http://37.120.189.81/side_testnet/side_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.sidechain
    else
  echo no have snap
fi
```
### 🚧Başlatalım ve loglara bakalım
```
sudo systemctl daemon-reload
sudo systemctl enable sided
```
```
sudo systemctl restart sided && sudo journalctl -u sided -f
```
### 🚧Cüzdan oluşturma - kelimeleri yedekleyin
```
sided keys add $WALLET
```
### 🚧Cüzdan import
```
sided keys add $WALLET --recover
```
### 🚧Bakiye sorgulama
```
sided query bank balances $WALLET_ADDRESS
```
### 🏆Validator oluşturma
NOT: validator ve cüzdan adınızı yaıznız
```
sided tx staking create-validator \
--amount 1000000uside \
--from cüzdan-adı \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(sided tendermint show-validator) \
--moniker "Adını-yaz" \
--identity "" \
--details "" \
--chain-id side-testnet-1 \
--fees 1000uside \
-y
```


### 🚧Delete node - Silme
```
sudo systemctl stop sided
sudo systemctl disable sided
sudo rm -rf /etc/systemd/system/sided.service
sudo rm $(which sided)
sudo rm -rf $HOME/.sidechain
sed -i "/SIDE_/d" $HOME/.bash_profile
```
