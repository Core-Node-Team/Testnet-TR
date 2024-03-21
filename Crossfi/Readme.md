


<h1 align="center"> CrossFi </h1>


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2d6d845d-3c30-495f-a9bb-74b9e56fada6)



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Crossfi Website](https://crossfi.org/)<br>
 * [Blockchain Explorer](https://test.xfiscan.com/)<br>
 * [Discord](https://discord.gg/crossfi)<br>
 * [Twitter](https://twitter.com/crossfichain)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	8|
| RAM	| 16+ GB |
| Storage	| 400 GB SSD |


### 🚧Update ve gereklilikler
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```
### 🚧Go kurulumu
```
ver="1.21.6"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
### Varyasyonları atayalım
Not: ismini-yaz kısmına adınızı yazınız..
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="ismini-yaz"" >> $HOME/.bash_profile
echo "export CROSSFI_CHAIN_ID="crossfi-evm-testnet-1"" >> $HOME/.bash_profile
echo "export CROSSFI_PORT="36"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Dosyaları çekelim
```
cd $HOME
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0-prebuild3/crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz && tar -xf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz
tar -xvf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz
chmod +x $HOME/bin/crossfid
mv $HOME/bin/crossfid $HOME/go/bin
rm -rf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz $HOME/bin
```
### İnit
```
crossfid config node tcp://localhost:${CROSSFI_PORT}657
crossfid config keyring-backend os
crossfid config chain-id crossfi-evm-testnet-1
rm -rf testnet ~/.mineplex-chain
git clone https://github.com/crossfichain/testnet.git
mv $HOME/testnet/ $HOME/.mineplex-chain/
```
### Genesis ve Addrbook
```
wget -O $HOME/.mineplex-chain/config/genesis.json http://37.120.189.81/crossfi_testnet/genesis.json
wget -O $HOME/.mineplex-chain/config/addrbook.json http://37.120.189.81/crossfi_testnet/addrbook.json
```
### Seeds ve Peers
```
SEEDS="89752fa7945a06e972d7d860222a5eeaeab5c357@128.140.70.97:26656,dd83e3c7c4e783f8a46dbb010ec8853135d29df0@crossfi-testnet-seed.itrocket.net:36656"
PEERS="66bdf53ec0c2ceeefd9a4c29d7f7926e136f114a@crossfi-testnet-peer.itrocket.net:36656,b88d969ba0e158da1b4066f5c17af9da68c52c7a@65.109.53.24:44656,94eac2bd4f373b31ee9897fd5a2ab4a05080390b@65.108.127.160:26656,5ebd3b1590d7383c0bb6696ad364934d7f1c984e@160.202.128.199:56156,b0b01c08d7d4c6c2740cc5fe6ea74eb7fdde64f2@38.242.151.229:26656,dda09f9625cab3fb655c22ef85d756fc77132b9d@167.235.102.45:10956,c8914e513463791d91cc9ab35035c0c1111f307f@84.247.183.225:36656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.mineplex-chain/config/config.toml
```
### Port
```
sed -i.bak -e "s%:1317%:${CROSSFI_PORT}317%g;
s%:8080%:${CROSSFI_PORT}080%g;
s%:9090%:${CROSSFI_PORT}090%g;
s%:9091%:${CROSSFI_PORT}091%g;
s%:8545%:${CROSSFI_PORT}545%g;
s%:8546%:${CROSSFI_PORT}546%g;
s%:6065%:${CROSSFI_PORT}065%g" $HOME/.mineplex-chain/config/app.toml
```
### Port
```
sed -i.bak -e "s%:26658%:${CROSSFI_PORT}658%g;
s%:26657%:${CROSSFI_PORT}657%g;
s%:6060%:${CROSSFI_PORT}060%g;
s%:26656%:${CROSSFI_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${CROSSFI_PORT}656\"%;
s%:26660%:${CROSSFI_PORT}660%g" $HOME/.mineplex-chain/config/config.toml
```
### Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.mineplex-chain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.mineplex-chain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.mineplex-chain/config/app.toml
```
### Ayarlar
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "10000000000000mpx"|g' $HOME/.mineplex-chain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.mineplex-chain/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.mineplex-chain/config/config.toml
```
### SErvis oluşturalım
```
sudo tee /etc/systemd/system/crossfid.service > /dev/null <<EOF
[Unit]
Description=Crossfi node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.mineplex-chain
ExecStart=$(which crossfid) start --home $HOME/.mineplex-chain
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### Snap
```
crossfid tendermint unsafe-reset-all --home $HOME/.mineplex-chain
if curl -s --head curl http://37.120.189.81/crossfi_testnet/side_snap.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl http://37.120.189.81/crossfi_testnet/crossfi_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.mineplex-chain
    else
  echo no have snap
fi
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable crossfid
sudo systemctl restart crossfid
```
### Log
```
sudo journalctl -u crossfid -f
```
### Cüzdan oluşturma
```
crossfid keys add cüzdan-adi
```
### Validator oluşturma
```
crossfid tx staking create-validator \
--amount 1000000000000000000mpx \
--from wallet \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(crossfid tendermint show-validator) \
--moniker "Adini-yaz" \
--chain-id crossfi-evm-testnet-1 \
--node http://localhost:36657 \
--identity="" \
--website="" \
--details="" \
--security-contact="contact@corenode.info" \
--fees 150000000000000000mpx \
--gas 300000 \
--gas-adjustment 1.3 \
-y
```

