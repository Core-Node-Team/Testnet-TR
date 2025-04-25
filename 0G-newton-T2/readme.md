<h1 align="center"> 0G

![image](https://github.com/molla202/0G/assets/91562185/6eca238f-cd35-411b-9c5a-857fbd80dd33)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://twitter.com/0G_labs)<br>
 * [0G Website](https://0g.ai/)<br>
 * [0G Blog](https://blog.0g.ai/)<br>
 * [0G gitbook/docs](https://zerogravity.gitbook.io/0g-doc/)<br>
 * [0G Telegram](https://t.me/web3_0glabs)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/0G-Testnet.newton)<br>


## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |

### Public RPC

https://og-testnet-rpc.corenodehq.xyz

https://og-testnet-api.corenodehq.xyz

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
wget https://zgchaind-test.s3.ap-east-1.amazonaws.com/0gchaind-linux-v0.3.0
chmod +x ./0gchaind-linux-v0.3.0
mkdir -p /root/.0gchain/cosmovisor/upgrades/v0.3.0/bin
sudo cp -r ./0gchaind-linux-v0.3.0 /root/.0gchain/cosmovisor/upgrades/v0.3.0/bin/0gchaind
```
```
mkdir -p $HOME/.0gchain/cosmovisor/genesis/bin
mv /root/0gchaind-linux-v0.3.0 $HOME/.0gchain/cosmovisor/genesis/bin/0gchaind
```
```
wget https://github.com/0glabs/0g-chain/releases/download/v0.3.1.alpha.1/0gchaind-linux-v0.3.1.alpha.1
chmod +x ./0gchaind-linux-v0.3.1.alpha.1
mkdir -p /root/.0gchain/cosmovisor/upgrades/v0.3.1/bin
sudo mv ./0gchaind-linux-v0.3.1.alpha.1 /root/.0gchain/cosmovisor/upgrades/v0.3.1/bin/0gchaind
```
### 🚧System link
```
sudo ln -s $HOME/.0gchain/cosmovisor/genesis $HOME/.0gchain/cosmovisor/current -f
sudo ln -s $HOME/.0gchain/cosmovisor/current/bin/0gchaind /usr/local/bin/0gchaind -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/0gchaind.service > /dev/null << EOF
[Unit]
Description=0gchaind node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --json-rpc.api eth,txpool,personal,net,debug,web3
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.0gchain"
Environment="DAEMON_NAME=0gchaind"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.0gchain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable 0gchaind.service
```
### 🚧Node ayarları
```
0gchaind config chain-id zgtendermint_16600-2
0gchaind config keyring-backend os
0gchaind config node tcp://localhost:56657
```
### 🚧İnit
NOT: node adınızı yazınız.
```
0gchaind init NODE-ADI-YAZ --chain-id zgtendermint_16600-2
```
### 🚧Genesis addrbook
```
rm ~/.0gchain/config/genesis.json
curl -Ls https://github.com/0glabs/0g-chain/releases/download/v0.2.3/genesis.json > $HOME/.0gchain/config/genesis.json
```
### 🚧Seed
```
PEERS="80fa309afab4a35323018ac70a40a446d3ae9caf@og-testnet-peer.itrocket.net:11656,928f42a91548484f35a5c98aa9dcb25fb1790a70@65.21.46.201:26656,0ae19691f97f5797694c253bc06c79c8b58ea2a8@85.190.242.81:26656,0e44ddb20380bc06f489b8a58f6cb634c208d4e8@136.243.43.106:26656,ffdf7a8cc6dbbd22e25b1590f61da149349bdc2e@135.181.229.206:26656,56ee4c337848a70a43887531b5f1ca211bac1a34@185.187.170.125:26656,5e098c96e69e3e2a943b923eda791ba34543f792@116.202.210.96:26656,9dbb76298d1625ebcc47d08fa7e7911967b63b61@45.159.221.57:26656,593f012c2f496c3e3972e4c302e6c5d3bfef1a2a@38.242.197.125:26656,c0d35052a7612d992f721b25f186a5d1f569405e@195.201.194.188:26656,8bd2797c8ece0f099a1c31f98e5648d192d8cd54@38.242.146.162:26656,5bb50b80f855b343ac9d8957055fd44b8c51667e@135.181.229.232:31656,fa08f548e8d34b6c72ed9e7495a59ae6be656da8@109.199.97.178:12656"
SEEDS="81987895a11f6689ada254c6b57932ab7ed909b6@54.241.167.190:26656,010fb4de28667725a4fef26cdc7f9452cc34b16d@54.176.175.48:26656,e9b4bc203197b62cc7e6a80a64742e752f4210d5@54.193.250.204:26656,68b9145889e7576b652ca68d985826abd46ad660@18.166.164.232:26656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Gas pruning ayarı
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.0gchain/config/app.toml

sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0ua0gi"|g' $HOME/.0gchain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.0gchain/config/config.toml
```
### indexer null
NOT: stroge node kurucaksanız null yapmamanız gerekebilir.
```
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Port Ayarları
```
echo "export G_PORT="56"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:1317%:${G_PORT}317%g;
s%:8080%:${G_PORT}080%g;
s%:9090%:${G_PORT}090%g;
s%:9091%:${G_PORT}091%g;
s%:8545%:${G_PORT}545%g;
s%:8546%:${G_PORT}546%g;
s%:6065%:${G_PORT}065%g" $HOME/.0gchain/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${G_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.0gchain/config/config.toml
```
### 🚧Snap
```
sudo systemctl stop 0gchaind
cp $HOME/.0gchain/data/priv_validator_state.json $HOME/.0gchain/priv_validator_state.json.backup
curl -L http://37.120.189.81/0g_testnet/0g_snap.tar.lz4 | sudo lz4 -dc - | sudo tar -xf - -C $HOME/.0gchain
mv $HOME/.0gchain/priv_validator_state.json.backup $HOME/.0gchain/data/priv_validator_state.json
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart 0gchaind
```
### 🚧Log
```
sudo journalctl -u 0gchaind.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
0gchaind keys add cuzdan-adini-yaz --eth
```
- Eski cüzdan import ederkene bele
```
0gchaind keys add wallet --eth --recover
```
### 🚧Cüzdan evm adresi alma
NOT:wallet adınızı yazınız
```
echo "0x$(0gchaind debug addr $(0gchaind keys show wallet-adınızı-yazınız -a) | grep hex | awk '{print $3}')"
```
> evm scan :   https://scan-testnet.0g.ai
> evm için private key alma mm ekleme aynı cüzdanı. cüzdna adınızı yazınız.
```
0gchaind keys unsafe-export-eth-key cüzdan-adi-yaz
```
### FAUCET
NOt: faucet suan 
https://faucet.0g.ai/

### 🚧Validator oluşturma
NOT: discorddan rollerinizi de alın ki kanallar açılsın

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2b73ebc0-0880-4237-be41-aeb739f2d325)


NOT: cüzdan adını moniker adınızı yazınız
```
0gchaind tx staking create-validator \
  --amount=1000000ua0gi \
  --pubkey=$(0gchaind tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=zgtendermint_16600-2 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --node=http://localhost:56657 \
  -y
```
### Test dosya yuklemesi deneme

https://scan-testnet.0g.ai/tool


- adresine gidiyoruz cüzdanımızı bağlıyoruz. ağı otomatik ekler. sonra herhangi ufak bir resim dosya seçiyouruz ve upload ediyoruz onay verıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/36d5d3ee-85a2-4d7a-ae56-8784b0fa8c1c)


### Kendine delege
NOT: wallet kısmına cuzdan adı yazınız 2yerede. miktar kısmınada sayıyı yazın 1 dane edeceksenız mıktarı sil 1 yaz olmassa 1 sıfır falan dusur
```bash
0gchaind tx staking delegate $(0gchaind keys show wallet --bech val -a)  miktar000000ua0gi --from wallet -y
```


