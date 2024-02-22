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

git checkout v0.6.0

make install

sided version
```
### 🚧İnit
Not: adınızı yazın 
```
sided config node tcp://localhost:${SIDE_PORT}657
sided config keyring-backend os
sided config chain-id side-testnet-2
```
```
sided init "Adını-yaz" --chain-id side-testnet-2
```
### 🚧Genesis ve addrbook
```
wget -O $HOME/.side/config/genesis.json http://37.120.189.81/side_testnet/genesis.json
wget -O $HOME/.side/config/addrbook.json http://37.120.189.81/side_testnet/addrbook.json
```
### Seed peer
```
SEEDS="871aea8a3cccd58a01dbdba6cd7de52b7eb26d73@rpc-t.side.nodestake.org:666"
PEERS="6def6906f05a0d10a671d3cd2005529d320bb3c7@152.228.208.164:26656,85a16af0aa674b9d1c17c3f2f3a83f28f468174d@167.235.242.236:26656,6202f202f52aca046f749ce8fc58ebf06a01e272@65.108.200.40:49656,d9911bd0eef9029e8ce3263f61680ef4f71a87c4@13.230.121.124:26656,027ef6300590b1ca3a2b92a274247e24537bd9c9@65.109.65.248:49656"
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
--chain-id side-testnet-2 \
--fees 1000uside \
-y
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
