<h1 align="center"> 0G

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9d9b2b64-736b-4921-aa50-ae87f6d8d34b)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>



## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	16|
| RAM	| 32+ GB |
| Storage	| 400 GB SSD |

### Public RPC & Explorer

https://elys-api.corenode.info/

https://elys-rpc.corenode.info/

https://explorer.corenodehq.com/ELYS-Mainnet/staking/elysvaloper1nrywjuy8sud3ehdw5y08yqnl8dl5vzt635e2pl

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip gcc clang cmake build-essential -y
```

### 🚧 Go kurulumu
```
cd $HOME
VER="1.22.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```

### 🚧Dosyaları çekelim
```
git clone https://github.com/elys-network/elys.git
cd elys
git checkout v1.0.0
make build
```
```
mkdir -p $HOME/.elys/cosmovisor/genesis/bin
mv /root/elys/build/elysd $HOME/.elys/cosmovisor/genesis/bin/elysd
```
```
echo "export ELYS_PORT="15"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### 🚧System link
```
sudo ln -s $HOME/.elys/cosmovisor/genesis $HOME/.elys/cosmovisor/current -f
sudo ln -s $HOME/.elys/cosmovisor/current/bin/elysd /usr/local/bin/elysd -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/elysd.service > /dev/null << EOF
[Unit]
Description=elys node service
After=network-online.target

[Service]
User=root
ExecStart=/root/go/bin/cosmovisor run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=/root/.elys"
Environment="DAEMON_NAME=elysd"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/root/.elys/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target

EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable elysd.service
```
### 🚧İnit
NOT: node adınızı yazınız.
```
elysd init NODE-ADI-YAZ --chain-id elys-1
```
```
sed -i \
-e "s/chain-id = .*/chain-id = \"${ELYS_CHAIN_ID}\"/" \
-e "s/keyring-backend = .*/keyring-backend = \"os\"/" \
-e "s/node = .*/node = \"tcp:\/\/localhost:${ELYS_PORT}657\"/" $HOME/.elys/config/client.toml
```
### 🚧Genesis addrbook
```
curl -o $HOME/.elys/config/genesis.json https://raw.githubusercontent.com/elys-network/networks/refs/heads/main/mainnet/genesis.json
```

### 🚧Gas pruning ayarı
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.0003uelys"|g' $HOME/.elys/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.elys/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.elys/config/config.toml

sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.elys/config/app.toml 
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.elys/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"19\"/" $HOME/.elys/config/app.toml
```

### 🚧Port Ayarları

```
sed -i.bak -e "s%:1317%:${ELYS_PORT}317%g;
s%:8080%:${ELYS_PORT}080%g;
s%:9090%:${ELYS_PORT}090%g;
s%:9091%:${ELYS_PORT}091%g;
s%:8545%:${ELYS_PORT}545%g;
s%:8546%:${ELYS_PORT}546%g;
s%:6065%:${ELYS_PORT}065%g" $HOME/.elys/config/app.toml

```
```
sed -i.bak -e "s%:26658%:${ELYS_PORT}658%g;
s%:26657%:${ELYS_PORT}657%g;
s%:6060%:${ELYS_PORT}060%g;
s%:26656%:${ELYS_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${ELYS_PORT}656\"%;
s%:26660%:${ELYS_PORT}660%g" $HOME/.elys/config/config.toml
```
### 🚧Seed
```
PEERS="9abe7b0e0227e2cd1f31b8c48a6c12c3c3672308@elys-mainnet-rpc.itrocket.net:41656,b42c60adafb47b19f0b36c58985364a897db6b85@65.109.26.242:22056,2cebaa33e41cfb504b99f0093424a9d5916f0e5e@51.178.89.172:26656,d9bfa29e0cf9c4ce0cc9c26d98e5d97228f93b0b@elys.rpc.kjnodes.com:15356"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.elys/config/config.toml
```
### 🚧Snap
```
elysd tendermint unsafe-reset-all --home $HOME/.elys
if curl -s --head curl http://37.120.189.81/elys_mainnet/elys_snap.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl http://37.120.189.81/elys_mainnet/elys_snap.lz4 | lz4 -dc - | tar -xf - -C $HOME/.elys
    else
  echo "no snapshot found"
fi
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart elysd
```
### 🚧Log
```
sudo journalctl -u elysd.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
elysd keys add cuzdan-adini-yaz
```
- Eski cüzdan import ederkene bele
```
elysd keys add wallet --recover
```

### 🚧Validator oluşturma
```
cd $HOME
echo "{\"pubkey\":{\"@type\":\"/cosmos.crypto.ed25519.PubKey\",\"key\":\"$(elysd comet show-validator | grep -Po '\"key\":\s*\"\K[^"]*')\"},
    \"amount\": \"1000000uelys\",
    \"moniker\": \"test\",
    \"identity\": \"\",
    \"website\": \"\",
    \"security\": \"\",
    \"details\": \"\",
    \"commission-rate\": \"0.1\",
    \"commission-max-rate\": \"0.2\",
    \"commission-max-change-rate\": \"0.01\",
    \"min-self-delegation\": \"1\"
}" > validator.json
```
```
elysd tx staking create-validator validator.json \
    --from cüzdan yaz \
    --chain-id elys-1 \
	--gas auto --gas-adjustment 1.5
```



