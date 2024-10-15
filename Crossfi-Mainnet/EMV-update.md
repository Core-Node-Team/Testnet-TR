
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
echo "export CROSSFI_CHAIN_ID="mineplex-mainnet-1"" >> $HOME/.bash_profile
echo "export CROSSFI_PORT="37"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Dosyaları çekelim
```
cd $HOME
mkdir -p $HOME/.crossfid/cosmovisor/genesis/bin
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0/crossfi-node_0.3.0_linux_amd64.tar.gz && tar -xf crossfi-node_0.3.0_linux_amd64.tar.gz
git clone https://github.com/crossfichain/mainnet.git
cp -r $HOME/mainnet/* $HOME/.crossfid/
mv $HOME/bin/crossfid $HOME/.crossfid/cosmovisor/genesis/bin
```
```
sudo ln -s $HOME/.crossfid/cosmovisor/genesis $HOME/.crossfid/cosmovisor/current -f
sudo ln -s $HOME/.crossfid/cosmovisor/current/bin/crossfid /usr/local/bin/crossfid -f
```
```
wget -O $HOME/.crossfid/config/app.toml https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/refs/heads/main/Crossfi-Mainnet/app.toml
```
### Download and install Cosmovisor
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### Create service
```
sudo tee /etc/systemd/system/crossfid.service > /dev/null << EOF
[Unit]
Description=crossfi node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --home $HOME/.crossfid
Restart=always
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.crossfid"
Environment="DAEMON_NAME=crossfid"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.crossfid/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable crossfid.service
```
### Ayarlamalar

```
crossfid config node tcp://localhost:${CROSSFI_PORT}657
```
### Genesis ve Addrbook

### Port
```
sed -i.bak -e "s%:1317%:${CROSSFI_PORT}317%g;
s%:8080%:${CROSSFI_PORT}080%g;
s%:9090%:${CROSSFI_PORT}090%g;
s%:9091%:${CROSSFI_PORT}091%g;
s%:8545%:${CROSSFI_PORT}545%g;
s%:8546%:${CROSSFI_PORT}546%g;
s%:6065%:${CROSSFI_PORT}065%g" $HOME/.crossfid/config/app.toml
```
### Port
```
sed -i.bak -e "s%:26658%:${CROSSFI_PORT}658%g;
s%:26657%:${CROSSFI_PORT}657%g;
s%:6060%:${CROSSFI_PORT}060%g;
s%:26656%:${CROSSFI_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${CROSSFI_PORT}656\"%;
s%:26660%:${CROSSFI_PORT}660%g" $HOME/.crossfid/config/config.toml
```
### Peer
```
PEERS="2c8951227c667c8833e2930bc07ce1a9f0acbe28@seed-v2.mineplex.io:26656,e9fd5cca36b36d6646cfa65ff72b2f22abec4667@46.101.138.73:26656"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.crossfid/config/config.toml
```
### Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.crossfid/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.crossfid/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.crossfid/config/app.toml
```
### Ayarlar
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "10000000000000mpx"|g' $HOME/.crossfidconfig/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.crossfid/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.crossfid/config/config.toml
```

### Snap
NOT: snap yenilenmedi atmayın.
```
sudo apt install liblz4-tool

systemctl stop crossfid

cp $HOME/.mineplex-chain/data/priv_validator_state.json $HOME/.mineplex-chain/priv_validator_state.json.backup

curl -L http://37.120.189.81/crossfi_mainnet/crossfi_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.mineplex-chain

mv $HOME/.mineplex-chain/priv_validator_state.json.backup $HOME/.mineplex-chain/data/priv_validator_state.json

```
### Başlatalım
```
sudo systemctl daemon-reload
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
--chain-id crossfi-mainnet-1 \
--node http://localhost:36657 \
--identity="" \
--website="" \
--details="" \
--security-contact="" \
--fees 2100000000000000000mpx \
--gas auto \
--gas-adjustment 1.1 \
-y
```


## Sıfırdan kurmayacak sadece update yapacaklar.

```
systemctl stop crossfid
```
```
cp $HOME/.mineplex-chain/data/priv_validator_state.json $HOME/.mineplex-chain/priv_validator_state.json.backup
mv $HOME/.mineplex-chain $HOME/.mineplex-chainydk
```
```
cd $HOME
mkdir -p $HOME/.crossfid/cosmovisor/genesis/bin
mkdir -p $HOME/.crossfid/cosmovisor/upgrades/stop-chain-for-upgrade/bin
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0/crossfi-node_0.3.0_linux_amd64.tar.gz && tar -xf crossfi-node_0.3.0_linux_amd64.tar.gz
git clone https://github.com/crossfichain/mainnet.git
cp -r $HOME/mainnet/* $HOME/.crossfid/
cp -r $HOME/bin/crossfid $HOME/.crossfid/cosmovisor/upgrades/stop-chain-for-upgrade/bin/
mv $HOME/bin/crossfid $HOME/.crossfid/cosmovisor/genesis/bin
```
```
sudo ln -s $HOME/.crossfid/cosmovisor/genesis $HOME/.crossfid/cosmovisor/current -f
sudo ln -s $HOME/.crossfid/cosmovisor/current/bin/crossfid /usr/local/bin/crossfid -f
```
```
wget -O $HOME/.crossfid/config/app.toml https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/refs/heads/main/Crossfi-Mainnet/app.toml
```
```
sudo tee /etc/systemd/system/crossfid.service > /dev/null << EOF
[Unit]
Description=crossfi node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --home $HOME/.crossfid
Restart=always
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.crossfid"
Environment="DAEMON_NAME=crossfid"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.mineplex-chain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable crossfid.service
```
### Ayarlamalar

```
echo "export CROSSFI_PORT="37"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
crossfid config node tcp://localhost:${CROSSFI_PORT}657
```
### Port
```
sed -i.bak -e "s%:1317%:${CROSSFI_PORT}317%g;
s%:8080%:${CROSSFI_PORT}080%g;
s%:9090%:${CROSSFI_PORT}090%g;
s%:9091%:${CROSSFI_PORT}091%g;
s%:8545%:${CROSSFI_PORT}545%g;
s%:8546%:${CROSSFI_PORT}546%g;
s%:6065%:${CROSSFI_PORT}065%g" $HOME/.crossfid/config/app.toml
```
### Port
```
sed -i.bak -e "s%:26658%:${CROSSFI_PORT}658%g;
s%:26657%:${CROSSFI_PORT}657%g;
s%:6060%:${CROSSFI_PORT}060%g;
s%:26656%:${CROSSFI_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${CROSSFI_PORT}656\"%;
s%:26660%:${CROSSFI_PORT}660%g" $HOME/.crossfid/config/config.toml
```
### Peer
```
PEERS="2c8951227c667c8833e2930bc07ce1a9f0acbe28@seed-v2.mineplex.io:26656,e9fd5cca36b36d6646cfa65ff72b2f22abec4667@46.101.138.73:26656,1985bfd22cf1baeb5aaae6b40b13632c28303bd1@188.40.73.112:30656,3f3d80c93d3af57ff3ca5dfe45ba2b523fa8f056@89.58.13.159:16656,3ac1d36f85f590231f03d82f3d640aed82b65763@95.216.246.86:29656,744524914728749e413ea02b63c93ad1d30739ae@89.58.16.136:26656,71af8f90388904abd2b0991bcc4971f8e693f6b4@65.109.12.225:26656,a704f7b923cf7286665b95d49a911bfea1accb5c@8.52.134.76:26656,4a93071180ea61b73a1c44f7a127fa633f9ab275@5.189.165.59:26656,1128a88bc906c7342a8f2d1284418434383317f1@176.9.120.85:26056,c482ab7bb52202149477fded22d6741d746d7e45@95.217.204.58:26056,9dd9a718a70c17eda4a2f2e262a6fcdafa380b04@95.217.45.201:23656,0340b4af187fb04d72a937c3c27107676e3e1623@207.121.25.84:26656,57e3a0e9156d8c4d3a87a7b96d7c6b65a14e6d1a@80.76.43.141:48656,693d9fe729d41ade244717176ab1415b2c06cf86@142.132.253.112:48656,6b90dd8399533bca9066030f6193dca37f1565e1@65.109.234.80:26656,90fd2ad4f2b57bf6fa0c40cd579310f5ceebf0f5@5.78.128.70:26656,773a284b788b76e3b4a8f228e85178b00fe8af95@65.108.151.146:26656,1f8480f21ce7de30c5e8e1ef682a70873d7b5e72@193.34.213.234:48656,c012114f8e1464f01c2069de71de2088420d3fc8@65.109.99.157:16610,dbe6c7cff5cc334f0af8703109ef796f69077f20@65.109.233.218:29656,c0e3881024d720e4d885c6f34846313aea401418@149.50.96.238:37656,78b645fb75d2150694611fa4dda039f769d924f1@180.149.44.66:36656,2e92087539bf85fb015f2381596730998d758fe5@5.78.82.61:26656,f4b747f48202761f9c60a9020998b8be35ad67d9@65.108.0.88:35656"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.crossfid/config/config.toml
```
### Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.crossfid/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.crossfid/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.crossfid/config/app.toml
```
### Ayarlar
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "10000000000000mpx"|g' $HOME/.crossfid/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.crossfid/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.crossfid/config/config.toml
```

### Data taşıma
```
cp $HOME/.crossfid/data/priv_validator_state.json $HOME/.crossfid/priv_validator_state.json.backup
```
```
cp -r $HOME/.mineplex-chainydk/keyring-file $HOME/.crossfid/
cp -r $HOME/.mineplex-chainydk/config/priv_validator_key.json $HOME/.crossfid/config/priv_validator_key.json
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart crossfid
```
### Log
```
sudo journalctl -u crossfid -fo cat
```





