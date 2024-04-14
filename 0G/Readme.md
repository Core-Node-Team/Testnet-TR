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
```
git clone https://github.com/0glabs/0g-evmos.git
cd 0g-evmos
git checkout v1.0.0-testnet
make build
```
```
mkdir -p $HOME/.evmosd/cosmovisor/genesis/bin
mv build/evmosd $HOME/.evmosd/cosmovisor/genesis/bin/
rm -rf build
```
### 🚧System link
```
sudo ln -s $HOME/.evmosd/cosmovisor/genesis $HOME/.evmosd/cosmovisor/current -f
sudo ln -s $HOME/.evmosd/cosmovisor/current/bin/evmosd /usr/local/bin/evmosd -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/evmosd.service > /dev/null << EOF
[Unit]
Description=evmosd node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.evmosd"
Environment="DAEMON_NAME=evmosd"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.evmosd/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable evmosd.service
```
### 🚧Node ayarları
```
evmosd config chain-id zgtendermint_9000-1
evmosd config keyring-backend os
evmosd config node tcp://localhost:16457
```
### 🚧İnit
NOT: node adınızı yazınız.
```
evmosd init NODE-ADI-YAZ --chain-id zgtendermint_9000-1
```
### 🚧Genesis addrbook
```
curl -Ls https://github.com/0glabs/0g-evmos/releases/download/v1.0.0-testnet/genesis.json > $HOME/.evmosd/config/genesis.json
```
### 🚧Seed
```
PEERS="1248487ea585730cdf5d3c32e0c2a43ad0cda973@peer-zero-gravity-testnet.trusted-point.com:26326" && \
SEEDS="8c01665f88896bca44e8902a30e4278bed08033f@54.241.167.190:26656,b288e8b37f4b0dbd9a03e8ce926cd9c801aacf27@54.176.175.48:26656,8e20e8e88d504e67c7a3a58c2ea31d965aa2a890@54.193.250.204:26656,e50ac888b35175bfd4f999697bdeb5b7b52bfc06@54.215.187.94:26656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.evmosd/config/config.toml
```
### 🚧Gas ayarı
```
sed -i "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00252aevmos\"/" $HOME/.evmosd/config/app.toml
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
s%:6065%:${G_PORT}065%g" $HOME/.evmosd/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${CROSSFI_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.evmosd/config/config.toml
```
### 🚧Snap
```
sudo apt install liblz4-tool

systemctl stop evmosd

cp $HOME/.evmosd/data/priv_validator_state.json $HOME/.evmosd/priv_validator_state.json.backup

evmosd tendermint unsafe-reset-all --home $HOME/.evmosd --keep-addr-book

curl -L http://37.120.189.81/0g_testnet/0g_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.evmosd

mv $HOME/.evmosd/priv_validator_state.json.backup $HOME/.evmosd/data/priv_validator_state.json
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart evmosd
```
### 🚧Log
```
sudo journalctl -u evmosd.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
evmosd keys add cuzdan-adini-yaz
```
### 🚧Cüzdan evm adresi alma
NOT:wallet adınızı yazınız
```
echo "0x$(evmosd debug addr $(evmosd keys show wallet-adınızı-yazınız -a) | grep hex | awk '{print $3}')"
```
> evm scan :   https://scan-testnet.0g.ai
> evm için private key alma mm ekleme aynı cüzdanı. cüzdna adınızı yazınız.
```
evmosd keys unsafe-export-eth-key cüzdan-adi-yaz
```
### FAUCET
NOt: faucet suan 
https://faucet.0g.ai/

### 🚧Validator oluşturma
NOT: discorddan rollerinizi de alın ki kanallar açılsın

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2b73ebc0-0880-4237-be41-aeb739f2d325)


NOT: cüzdan adını moniker adınızı yazınız
```
evmosd tx staking create-validator \
  --amount=10000000000000000aevmos \
  --pubkey=$(evmosd tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=zgtendermint_9000-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --gas-prices=99999aevmos \
  -y
```
### Test dosya yuklemesi deneme

https://scan-testnet.0g.ai/tool

- adresine gidiyoruz cüzdanımızı bağlıyoruz. ağı otomatik ekler. sonra herhangi ufak bir resim dosya seçiyouruz ve upload ediyoruz onay verıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/36d5d3ee-85a2-4d7a-ae56-8784b0fa8c1c)


### Kendine delege
NOT: wallet kısmına cuzdan adı yazınız 2yerede. miktar kısmınada sayıyı yazın 1 dane edeceksenız mıktarı sil 1 yaz olmassa 1 sıfır falan dusur
```bash
evmosd tx staking delegate $(evmosd keys show wallet --bech val -a)  miktar0000000000000000aevmos --from wallet --gas=500000 --gas-prices=99999aevmos -y
```





