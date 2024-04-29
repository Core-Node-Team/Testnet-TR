
![image](https://github.com/molla202/Galactica/assets/91562185/f83e0f67-e805-46af-a5b9-afc66c1cd3a0)


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Galactica Network Website](https://galactica.com/)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/Galactica%20Testnet)<br>
 * [Discord](https://discord.gg/JvynTZAr)<br>
 * [Twitter](https://twitter.com/GalacticaNet)<br>
 * [FAUCET](https://faucet-reticulum.galactica.com/)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |

### 🚧Gereklilikler ve Update
```
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
```
### 🚧GO
```
ver="1.21.3" &&
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" &&
sudo rm -rf /usr/local/go &&
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" &&
rm "go$ver.linux-amd64.tar.gz" &&
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile &&
source $HOME/.bash_profile &&
go version
```
### 🚧Varyasyonlar
NOT: cüzdan adı ve moniker adı yazınız..
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="node-adi-yaz"" >> $HOME/.bash_profile
echo "export GALACTICA_CHAIN_ID="galactica_9302-1"" >> $HOME/.bash_profile
echo "export GALACTICA_PORT="46"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### 🚧Dosyaları çekelim
```
cd $HOME
rm -rf galactica
git clone https://github.com/Galactica-corp/galactica
cd galactica
git checkout v0.1.2
make build
```
```
mkdir -p ~/.galactica/cosmovisor/upgrades/v0.1.2/bin
mv $HOME/galactica/build/galacticad ~/.galactica/cosmovisor/upgrades/v0.1.2/bin/

```
```
sudo ln -s ~/.galactica/cosmovisor/upgrades/0.1.2 ~/.galactica/cosmovisor/current -f
sudo ln -s ~/.galactica/cosmovisor/current/bin/galacticad /usr/local/bin/galacticad -f
```
### 🚧Cosmovisor kuralım
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/galacticad.service > /dev/null << EOF
[Unit]
Description=galactica node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --home $HOME/.galactica --chain-id galactica_9302-1
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=~/.galactica"
Environment="DAEMON_NAME=galacticad"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.galactica/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
### 🚧Etkinleştirelim
```
sudo systemctl daemon-reload
sudo systemctl enable galacticad
```
### 🚧Ağ ayarları
```
galacticad config chain-id galactica_9302-1
galacticad config keyring-backend os
galacticad config node tcp://localhost:26657
```
### 🚧İnit
```
galacticad init NAME_OF_YOUR_VALIDATOR --chain-id galactica_9302-1
```
### 🚧Genesis ve addrbook
```
curl https://raw.githubusercontent.com/molla202/Galactica/main/genesis.json -o ~/.galactica/config/genesis.json
curl https://raw.githubusercontent.com/molla202/Galactica/main/addrbook.json -o ~/.galactica/config/addrbook.json
```
### 🚧Seed ve Peer
```
SEEDS="52ccf467673f93561c9d5dd4434def32ef2cd7f3@galactica-testnet-seed.itrocket.net:46656"
PEERS="c9993c738bec6a10cfb8bb30ac4e9ae6f8286a5b@galactica-testnet-peer.itrocket.net:11656,e926f2e20568e61646558a2b8fd4a4e46d77903f@141.95.110.124:26656,a028446e34e3c5bd198a60bf6e799a05e8db16a1@116.202.162.188:15656,27fc47bc018e1327eddfe99092cc64b3bc594bf9@144.76.97.251:26756,f3cd6b6ebf8376e17e630266348672517aca006a@46.4.5.45:27456,3afb7974589e431293a370d10f4dcdb73fa96e9b@157.90.158.222:26656,3a8725237bfa1a302831a6c6b04a57afbcdb0955@49.13.166.186:26656,4313c88bb2d7a4afe4a58f87a0f282eee96fbdba@65.109.182.72:46656,c722e6dc5f762b0ef19be7f8cc8fd67cdf988946@49.12.96.14:26656,9990ab130eac92a2ed1c3d668e9a1c6e811e8f35@148.251.177.108:27456,15c8ce51492b22b13be095aac62cf2c33a1cf44e@65.109.68.87:30656,8949fb771f2859248bf8b315b6f2934107f1cf5a@168.119.241.1:26656,707af7d29be8d3fff3c4f0cdc0b8986a6a8aff63@95.217.200.98:28656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.galactica/config/config.toml
```
### 🚧Port
```
sed -i.bak -e "s%:1317%:${GALACTICA_PORT}317%g;
s%:8080%:${GALACTICA_PORT}080%g;
s%:9090%:${GALACTICA_PORT}090%g;
s%:9091%:${GALACTICA_PORT}091%g;
s%:8545%:${GALACTICA_PORT}545%g;
s%:8546%:${GALACTICA_PORT}546%g;
s%:6065%:${GALACTICA_PORT}065%g" $HOME/.galactica/config/app.toml
```
### Port
```
sed -i.bak -e "s%:26658%:${GALACTICA_PORT}658%g;
s%:26657%:${GALACTICA_PORT}657%g;
s%:6060%:${GALACTICA_PORT}060%g;
s%:26656%:${GALACTICA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${GALACTICA_PORT}656\"%;
s%:26660%:${GALACTICA_PORT}660%g" $HOME/.galactica/config/config.toml
```
### 🚧Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.galactica/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.galactica/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.galactica/config/app.toml
```
### 🚧Gas ve index ayarı
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "10agnet"|g' $HOME/.galactica/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.galactica/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.galactica/config/config.toml
```

### 🚧Başlatalım
```
sudo systemctl start galacticad && sudo journalctl -u galacticad -f --no-hostname -o cat
```
### Log
```
sudo journalctl -u galacticad -f --no-hostname -o cat
```
### Cüzdan olusturma
```
galacticad keys add cüzdan-adi-yaz
```
### Cüzdan import
```
galacticad keys add cüzdan-adi-yaz --recover
```
### Cüzdan EVM adresi al
NOT: ALDIĞINIZ ADRES İLE LİNKLERDEKİ FAUCETTEN COİN İSTEYİNİZ.
```
galacticad keys convert-bech32-to-hex $(galacticad keys show cüzdan-adi-yaz -a)
```
### Private key al
```
galacticad keys unsafe-export-eth-key cüzdan-adi-yaz
```
### Validator oluştur
NOT: cüzdan ve vali adını yazınız
```
galacticad tx staking create-validator \
--amount 1000000agnet \
--from Cüzdan-adi \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(galacticad tendermint show-validator) \
--moniker "vali-adi-yaz" \
--identity "" \
--website "" \
--details "" \
--chain-id galactica_9302-1 \
--gas 200000 --gas-prices 15agnet \
-y
```
### Validator editle
```
galacticad tx staking edit-validator \
--commission-rate 0.1 \
--new-moniker "vali-adi" \
--identity "" \
--details "" \
--from cüzdan-adi \
--chain-id galactica_9302-1 \
--gas 200000 --gas-prices 15agnet \
-y 
```
- $WALLET onlan yerleri hata alırsanız cüzdan adınızı yazınız...

### jailden çık
```
galacticad tx slashing unjail --from $WALLET --chain-id galactica_9302-1 --gas 200000 --gas-prices 10agnet -y 
```
### Bakiye yolla
```
galacticad tx bank send $WALLET_ADDRESS <TO_WALLET_ADDRESS> 1000000agnet --gas 200000 --gas-prices 10agnet -y 
```
### Kendine stake et
```
galacticad tx staking delegate $(galacticad keys show $WALLET --bech val -a) 1000000agnet --from $WALLET --chain-id galactica_9302-1 --gas 200000 --gas-prices 10agnet -y 
```
### Stake et
```
galacticad tx staking delegate <TO_VALOPER_ADDRESS> 1000000agnet --from $WALLET --chain-id galactica_9302-1 --gas 200000 --gas-prices 10agnet -y 	
```
### Bakiye sorgula
```
galacticad query bank balances $WALLET_ADDRESS
```
### Node silme
```
sudo systemctl stop galacticad
sudo systemctl disable galacticad
sudo rm -rf /etc/systemd/system/galacticad.service
sudo rm $(which galacticad)
sudo rm -rf $HOME/.galactica
sed -i "/GALACTICA_/d" $HOME/.bash_profile
```
