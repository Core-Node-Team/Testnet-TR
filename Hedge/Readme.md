<h1 align="center"> Hedge </h1>


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2920b33b-283a-4efb-ac72-545ef98c562d)


> Hedge, zincir üzerindeki çoklu imza yetenekleri ve Akıllı Sözleşme Güvenlik Analizi katmanı sayesinde benzersiz işlem güvenliği sağlar.

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Hedge Website](https://hedgeblock.io/)<br>
 * [Blockchain Explorer](https://explorer.nodestake.org/hedge-testnet)<br>
 * [Discord](https://discord.gg/HMVhE7recm)<br>
 * [Twitter](https://twitter.com/hedgeblockio)<br>

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
sudo wget -O hedged https://github.com/hedgeblock/testnets/releases/download/v0.1.0/hedged_linux_amd64_v0.1.0
chmod +x hedged
mkdir -p $HOME/go/bin
sudo mv hedged /go/bin
set -eux; \
  wget -O /lib/libwasmvm.x86_64.so https://github.com/CosmWasm/wasmvm/releases/download/v1.3.0/libwasmvm.x86_64.so
```
### 🚧 İnit işlemi
```
hedged config chain-id berberis-1
hedged config keyring-backend test
```
```
hedged init "Moniker" --chain-id berberis-1
```
```
sudo wget -O $HOME/.hedge/config/genesis.json "http://37.120.189.81/hedge_tesnet/genesis.json"
sudo wget -O $HOME/.hedge/config/addrbook.json "http://37.120.189.81/hedge_tesnet/addrbook.json"
```
### 🚧 Gas ayarları
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025uhedge\"/;" ~/.hedge/config/app.toml
peers=""
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.hedge/config/config.toml
seeds="7879005ab63c009743f4d8d220abd05b64cfee3d@54.92.167.150:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.hedge/config/config.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.hedge/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.hedge/config/config.toml
```
### 🚧 Puring
```
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="10" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.hedge/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.hedge/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.hedge/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.hedge/config/app.toml
```
### 🚧 Servis oluşturalım
```
sudo tee /etc/systemd/system/hedged.service > /dev/null <<EOF
[Unit]
Description=Hedged Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which hedged) start
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable hedged
```
### 🚧 Snap
```
sided tendermint unsafe-reset-all --home $HOME/.hedge
if curl -s --head curl http://37.120.189.81/hedge_testnet/hedge_snap.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl http://37.120.189.81/hedge_testnet/hedge_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.hedge
    else
  echo no have snap
fi
```

### 🚧 Başlatalım
```
sudo systemctl restart hedged
```
```
journalctl -u hedged -f -o cat
```
### Validator oluşturma
```
hedged tx staking create-validator \
--amount 1000000uhedge \
--pubkey $(hedged tendermint show-validator) \
--chain-id berberis-1 \
--min-self-delegation 1 \
--commission-max-change-rate 0.01 \
--commission-max-rate 0.2 \
--commission-rate 0.05 \
--moniker "" \
--identity "" \
--details "" \
--website "" \
--security-contact "" \
--from "cüzdan-adi-yaz" \
--gas "200000" \
-y
```
### Edit validator
```
hedged tx staking edit-validator \
--chain-id berberis-1 \
--commission-rate 0.05 \
--new-moniker "" \
--identity "" \
--details "" \
--website "" \
--security-contact "" \
--from "cüzdan-adi-yaz" \
--gas "200000" \
-y
```

### Yararlı komutlar

Cüzdan oluşturma

    hedged keys add wallet

Cüzdan import

    hedged keys add wallet --recover

Cüzdan listeleme

    hedged keys list

Cüzdan silme

    hedged keys delete wallet

Bakiye sorgula

    hedged q bank balances $(hedged keys show wallet -a)


Ödülleri çek

    hedged tx distribution withdraw-rewards $(hedged keys show wallet --bech val -a) --commission --from wallet --chain-id berberis-1 --gas-prices=0.025uhedge --gas-adjustment=1.5 --gas=auto -y

Kendine delege

    hedged tx staking delegate $(hedged keys show wallet --bech val -a) 1000000uhedge --from wallet --chain-id berberis-1 --gas-prices=0.025uhedge --gas-adjustment=1.5 --gas=auto -y

Mapustan Çıkma (yak bi cuara)

    hedged tx slashing unjail --from wallet --chain-id=berberis-1 --gas-prices=0.025uhedge --gas-adjustment=1.5 --gas=auto -y 
    
Validator bilgileri

    hedged status 2>&1 | jq -r '.ValidatorInfo // .validator_info'

Sync durmu

    hedged status 2>&1 | jq -r '.SyncInfo.catching_up // .sync_info.catching_up'

Peer öğren

    echo $(hedged tendermint show-node-id)'@'$(curl -s ifconfig.me)':'$(cat $HOME/.hedge/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')

Silme ( Tez kellesini uçurasın )

    sudo systemctl stop hedged && sudo systemctl disable hedged && sudo rm /etc/systemd/system/hedged.service && sudo systemctl daemon-reload && rm -rf $HOME/.hedge && rm -rf hedge && sudo rm -rf $(which hedged) 












