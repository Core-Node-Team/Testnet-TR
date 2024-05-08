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
 * [Blockchain Explorer](https://explorer.corenodehq.com/0G%20Testnet.)<br>


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

### 🚧 Go kurulumu
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

### 🚧Dosyaları çekelim

git clone -b v0.1.0 https://github.com/0glabs/0g-chain.git
./0g-chain/networks/testnet/install.sh
source .profile


```
git clone -b v0.1.0 https://github.com/0glabs/0g-chain.git
cd 0g-chain
make build
```
```
mkdir -p $HOME/.0gchain/cosmovisor/genesis/bin
mv /root/0g-chain/out/linux/0gchaind $HOME/.0gchain/cosmovisor/genesis/bin/
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
ExecStart=$(which cosmovisor) run start
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
0gchaind config chain-id zgtendermint_16600-1
0gchaind config keyring-backend os
0gchaind config node tcp://localhost:16457
```
### 🚧İnit
NOT: node adınızı yazınız.
```
0gchaind init NODE-ADI-YAZ --chain-id zgtendermint_16600-1
```
### 🚧Genesis addrbook
```
rm ~/.0gchain/config/genesis.json
curl -Ls https://github.com/0glabs/0g-chain/releases/download/v0.1.0/genesis.json > $HOME/.0gchain/config/genesis.json
```
OR
```
rm ~/.0gchain/config/genesis.json

wget -P ~/.0gchain/config https://github.com/0glabs/0g-chain/releases/download/v0.1.0/genesis.json
```
### 🚧Seed
```
PEERS="c4d619f6088cb0b24b4ab43a0510bf9251ab5d7f@54.241.167.190:26656,44d11d4ba92a01b520923f51632d2450984d5886@54.176.175.48:26656,f2693dd86766b5bf8fd6ab87e2e970d564d20aff@54.193.250.204:26656,f878d40c538c8c23653a5b70f615f8dccec6fb9f@54.215.187.94:26656" && \
SEEDS="c4d619f6088cb0b24b4ab43a0510bf9251ab5d7f@54.241.167.190:26656,44d11d4ba92a01b520923f51632d2450984d5886@54.176.175.48:26656,f2693dd86766b5bf8fd6ab87e2e970d564d20aff@54.193.250.204:26656,f878d40c538c8c23653a5b70f615f8dccec6fb9f@54.215.187.94:26656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Gas pruning ayarı
```

sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.0gchain/config/app.toml

sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0ua0gi"|g' $HOME/.0gchain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.0gchain/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Port Ayarları
```
echo "export G_PORT="16"" >> $HOME/.bash_profile
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
yakında
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
  --amount=10000000000000000ua0gi \
  --pubkey=$(0gchaind tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=zgtendermint_16600-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --gas-prices=99999ua0gi \
  -y
```
### Test dosya yuklemesi deneme

https://scan-testnet.0g.ai/tool


- adresine gidiyoruz cüzdanımızı bağlıyoruz. ağı otomatik ekler. sonra herhangi ufak bir resim dosya seçiyouruz ve upload ediyoruz onay verıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/36d5d3ee-85a2-4d7a-ae56-8784b0fa8c1c)


### Kendine delege
NOT: wallet kısmına cuzdan adı yazınız 2yerede. miktar kısmınada sayıyı yazın 1 dane edeceksenız mıktarı sil 1 yaz olmassa 1 sıfır falan dusur
```bash
0gchaind tx staking delegate $(0gchaind keys show wallet --bech val -a)  miktar0000000000000000ua0gi --from wallet --gas=500000 --gas-prices=99999ua0gi -y
```




