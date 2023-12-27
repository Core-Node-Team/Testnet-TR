<h1 align="center"> Entrypoint-pubtest-2 </h1>

![image](https://github.com/molla202/Entrypoint-pubtest-2/assets/91562185/8e722930-ad7e-481e-b0ce-67bc162a5f19)

![image](https://github.com/molla202/Entrypoint-pubtest-2/assets/91562185/6e40a76c-4e5e-4058-a0f4-fd6a0edf349f)



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Entrypoint Website](https://entrypoint.zone/)<br>
 * [Blockchain Explorer](https://testnet.itrocket.net/entrypoint/staking)<br>
 * [Discord](https://discord.gg/dWccn5wK)<br>
 * [Twitter](https://twitter.com/entrypointzone)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |


### 🚧Update ve gereklilikler
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```
### 🚧Go kurulumu
```
cd $HOME
! [ -x "$(command -v go)" ] && {
VER="1.20.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
}
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```
### 🚧Varyasyonlar
✏️Not: cüzdan adı ve moniker adınızı yazınız
```
echo "export WALLET="cüzdan-adı"" >> $HOME/.bash_profile
echo "export MONIKER="node-adı"" >> $HOME/.bash_profile
echo "export ENTRY_CHAIN_ID="entrypoint-pubtest-2"" >> $HOME/.bash_profile
echo "export ENTRY_PORT="34"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### 🚧Dosyaları çekiyoruz
```
cd $HOME
mkdir -p $HOME/entrypoint && cd entrypoint
wget -O entrypointd https://github.com/entrypoint-zone/testnets/releases/download/v1.3.0/entrypointd-1.3.0-linux-amd64
chmod +x entrypointd-1.3.0-linux-amd64
mv entrypointd-1.3.0-linux-amd64 $HOME/go/bin/entrypointd
```
### 🚧init işlemi
```
entrypointd config node tcp://localhost:${ENTRY_PORT}657
entrypointd config keyring-backend os
entrypointd config chain-id entrypoint-pubtest-2
entrypointd init "$MONIKER" --chain-id entrypoint-pubtest-2
```
### 🚧Genesis ve adressbook indirelim
```
wget -O $HOME/.entrypoint/config/genesis.json https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Entrypoint/genesis.json
wget -O $HOME/.entrypoint/config/addrbook.json https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Entrypoint/addrbook.json
```
### 🚧Seed ve peer
```
SEEDS="e1b2eddac829b1006eb6e2ddbfc9199f212e505f@entrypoint-testnet-seed.itrocket.net:34656"
PEERS="7048ee28300ffa81103cd24b2af3d1af0c378def@entrypoint-testnet-peer.itrocket.net:34656,e0bf0782c0fc1ee550d2eed0de66b0b1825776ab@167.235.39.5:46656,81bf2ade773a30eccdfee58a041974461f1838d8@185.107.68.148:26656,85945c3aa71634f2d9d227710c62722f71dcc528@65.109.53.60:29656,a1583f1ba0f0f8b91bd163110b0bfd709604b266@65.108.206.118:61256,219c01207e171cde99fed5ae4dff1b26d3ca0ad8@95.217.100.248:06656,75e83d67504cbfacdc79da55ca46e2c4353816e7@65.109.92.241:3106,d57c7572d58cb3043770f2c0ba412b35035233ad@80.64.208.169:26656,ffbffb5bed1c8efcf6280ab1635f3eab6cfcf1b4@207.244.253.244:28656,12fb65ddbc028eebdb3d61a96b3784f5f5f31472@[2a01:4f9:3051:3e83::2]:22256,bbf8ef70a32c3248a30ab10b2bff399e73c6e03c@65.21.198.100:20956"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.entrypoint/config/config.toml
```
### 🚧Port ayarı app.toml
```
sed -i.bak -e "s%:1317%:${ENTRY_PORT}317%g;
s%:8080%:${ENTRY_PORT}080%g;
s%:9090%:${ENTRY_PORT}090%g;
s%:9091%:${ENTRY_PORT}091%g;
s%:8545%:${ENTRY_PORT}545%g;
s%:8546%:${ENTRY_PORT}546%g;
s%:6065%:${ENTRY_PORT}065%g" $HOME/.entrypoint/config/app.toml
```
### 🚧Port ayarı config.toml
```
sed -i.bak -e "s%:26658%:${ENTRY_PORT}658%g;
s%:26657%:${ENTRY_PORT}657%g;
s%:6060%:${ENTRY_PORT}060%g;
s%:26656%:${ENTRY_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${ENTRY_PORT}656\"%;
s%:26660%:${ENTRY_PORT}660%g" $HOME/.entrypoint/config/config.toml
```
### 🚧Puring
```
sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.entrypoint/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.entrypoint/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.entrypoint/config/app.toml
```
### 🚧Ayar minimum gas price,  prometheus ve indexing
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.01ibc/8A138BC76D0FB2665F8937EC2BF01B9F6A714F6127221A0E155106A45E09BCC5"|g' $HOME/.entrypoint/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.entrypoint/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.entrypoint/config/config.toml
```
### 🚧Servis dosyası oluşturuyoruz
```
sudo tee /etc/systemd/system/entrypointd.service > /dev/null <<EOF
[Unit]
Description=Entrypoint node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.entrypoint
ExecStart=$(which entrypointd) start --home $HOME/.entrypoint
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### 🚧Snap
```
Coming soon
```
### 🏠Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable entrypointd
sudo systemctl restart entrypointd
sudo journalctl -u entrypointd -fo cat
```
### 👉Cüzdan oluşturalım
```
entrypointd keys add $WALLET
```
YADA import edelim
```
entrypointd keys add $WALLET --recover
```
### 🏆Valiator
```
entrypointd tx staking create-validator \
--amount 1000000uentry \
--from $WALLET \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(entrypointd tendermint show-validator) \
--moniker "$MONIKER" \
--identity "" \
--details "" \
--chain-id entrypoint-pubtest-2 \
--gas auto --gas-adjustment 1.4 --gas-prices 0.01ibc/8A138BC76D0FB2665F8937EC2BF01B9F6A714F6127221A0E155106A45E09BCC5 \
-y
```
