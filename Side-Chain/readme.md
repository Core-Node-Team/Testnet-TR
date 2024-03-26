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

git checkout v0.7.0-rc2

make install

sided version
```
### 🚧İnit
Not: adınızı yazın 
```
sided config node tcp://localhost:${SIDE_PORT}657
sided config keyring-backend os
sided config chain-id side-testnet-3
```
```
sided init "Adını-yaz" --chain-id side-testnet-3
```
### 🚧Genesis ve addrbook
```
wget -O $HOME/.side/config/genesis.json http://37.120.189.81/side_testnet/genesis.json
wget -O $HOME/.side/config/addrbook.json http://37.120.189.81/side_testnet/addrbook.json
```
### Seed peer
```
SEEDS="9c14080752bdfa33f4624f83cd155e2d3976e303@side-testnet-seed.itrocket.net:45656"
PEERS="bbbf623474e377664673bde3256fc35a36ba0df1@side-testnet-peer.itrocket.net:45656,f379c81afd53ecb5c77a4f4521b0ae63d676ff42@95.216.246.20:36656,d2f461128781967d73aaecd9b8299c1bc817ec2f@5.104.86.185:656,572a44f91202908f5057ebdbb8a616bdb1f79498@65.109.113.228:60756,a70265a28a06e5a7d525920514ae17406dbeffd0@104.236.66.76:26656,027ef6300590b1ca3a2b92a274247e24537bd9c9@65.109.65.248:49656,91ae0fe0e7298b1fa5ce4ed06ce7afc1435d8be3@159.203.79.119:26656,2803ac0536102d14d1231ee2ba2401220e6e5161@188.40.66.173:26356,87a70a7d6302a288dd00ee6c09e840b123260190@78.46.79.238:11356,453a0a58f8e189d1682b3b3daefb4bfe3ca44c03@144.217.68.182:26356,dbe7d91d84f183cf26409cc42eb0c2a2c67de62a@167.235.178.134:26356"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.side/config/config.toml
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
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.side/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.side/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.side/config/app.toml
```
### 🚧Gas ve diğer ayarlar
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.005uside"|g' $HOME/.side/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.side/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.side/config/config.toml
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
sided keys add cüzdan-adı-yaz
```
### 🚧Cüzdan import
```
sided keys add cüzdan-adı-yaz --recover
```
### 🚧Bakiye sorgulama
```
sided query bank balances $WALLET_ADDRESS
```
### 🏆Validator oluşturma
NOT: validator ve cüzdan adınızı yaıznız. fauceti discordan alıcaksınız. link sayfanın basında var. `$request side-testnet-1 cüzdanadresi-yaz` Bu şekilde.
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
--chain-id side-testnet-3 \
--fees 1000uside \
-y
```
### Delege
$wallet yazan kısımlara cüzdan adını yazınız  1milyon uside 1 side edıyor
```
sided tx staking delegate $(sided keys show $WALLET --bech val -a) 1000000uside --from $WALLET --chain-id side-testnet-3 --gas auto --fees 1000uside -y
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
