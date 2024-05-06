<h1 align="center"> Side Protocol </h1>


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/00bf3951-733f-42d5-8f41-9bc67c06a6e8)



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Side Website](https://side.one)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/side/staking)<br>
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
echo "export SIDE_CHAIN_ID="S2-testnet-1"" >> $HOME/.bash_profile
echo "export SIDE_PORT="48"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### 🚧Dosyaları çekelim ve kuralım
```
cd $HOME

rm -rf sidechain

rm -rf side

cd $HOME && mkdir -p go/bin/

git clone https://github.com/sideprotocol/side.git

cd side

git checkout v0.8.0

make install

sided version
```
### 🚧İnit
Not: adınızı yazın 
```
sided config node tcp://localhost:${SIDE_PORT}657
sided config keyring-backend os
sided config chain-id S2-testnet-1
```
```
sided init "Adını-yaz" --chain-id S2-testnet-1
```
### 🚧Genesis ve addrbook
```
wget -O $HOME/.side/config/genesis.json https://raw.githubusercontent.com/molla202/Side/main/genesis.json
wget -O $HOME/.side/config/addrbook.json https://raw.githubusercontent.com/molla202/Side/main/addrbook.json
```
### Seed peer
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.005uside\"/;" ~/.side/config/app.toml
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.side/config/config.toml
peers="43cb99189637d1e35b8f11c1580cff305157c94b@54.249.68.205:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.side/config/config.toml
seeds="582dedd866dd77f25ac0575118cf32df1ee50f98@202.182.119.24:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.side/config/config.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.side/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.side/config/config.toml
```
### 🚧Port ayar
```
sed -i.bak -e "s%:1317%:${SIDE_PORT}317%g;
s%:8080%:${SIDE_PORT}080%g;
s%:9090%:${SIDE_PORT}090%g;
s%:9091%:${SIDE_PORT}091%g;
s%:8545%:${SIDE_PORT}545%g;
s%:8546%:${SIDE_PORT}546%g;
s%:6065%:${SIDE_PORT}065%g" $HOME/.side/config/app.toml
```
### 🚧Port ayar
```
sed -i.bak -e "s%:26658%:${SIDE_PORT}658%g;
s%:26657%:${SIDE_PORT}657%g;
s%:6060%:${SIDE_PORT}060%g;
s%:26656%:${SIDE_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${SIDE_PORT}656\"%;
s%:26660%:${SIDE_PORT}660%g" $HOME/.side/config/config.toml
```
### 🚧Puring
```
pruning="custom"
pruning_keep_recent="1000"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.side/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.side/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.side/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.side/config/app.toml
```
### İndexer
```
indexer="null" &&
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.side/config/config.toml
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/sided.service > /dev/null <<EOF
[Unit]
Description=Side node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.side
ExecStart=$(which sided) start --home $HOME/.side
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
  curl http://37.120.189.81/side_testnet/side_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.side
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
sided keys add cüzdan-adı-yaz --key-type="segwit"
```
### 🚧Cüzdan import
```
sided keys add cüzdan-adı-yaz --key-type="segwit" --recover
```
### 🚧Bakiye sorgulama
```
sided query bank balances $WALLET_ADDRESS
```
### 🏆Validator oluşturma
NOT: validator ve cüzdan adınızı yaıznız. fauceti discordan alıcaksınız. link sayfanın basında var. `$request S2-testnet-1 cüzdanadresi-yaz` Bu şekilde.
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
--chain-id S2-testnet-1 \
--fees 1000uside \
-y
```
### Delege
$wallet yazan kısımlara cüzdan adını yazınız  1milyon uside 1 side edıyor
```
sided tx staking delegate $(sided keys show $WALLET --bech val -a) 1000000uside --from $WALLET --chain-id S2-testnet-1 --gas auto --fees 1000uside -y
```
### 🚧Delete node - Silme
```
sudo systemctl stop sided
sudo systemctl disable sided
sudo rm -rf /etc/systemd/system/sided.service
sudo rm $(which sided)
sudo rm -rf $HOME/.side
sed -i "/SIDE_/d" $HOME/.bash_profile
```
