![logo-blue-orange-dot](https://github.com/molla202/Babylon/assets/91562185/09c70e6d-b9c7-421e-9680-400c538331b1)

<h1 align="center"> Babylon Chain </h1>

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Babylon Website](https://www.babylonchain.io/)<br>
 * [Blockchain Explorer](https://babylon.explorers.guru/)<br>
 * [Discord](https://discord.gg/V7NGnHq3)<br>
 * [Twitter](https://twitter.com/babylon_chain)<br>


## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4 |
| RAM	| 8 GB |
| Storage	| 250 GB SSD |

## Oto kurulum 
```
curl -sSL -o babylon-kurulum.sh https://raw.githubusercontent.com/molla202/Scripts/main/babylon.sh && chmod +x babylon-kurulum.sh && bash ./babylon-kurulum.sh
```
## NOT: kurulumu bitirdikten sonra eşleşilecek. eşleşme bitince cüzdan olusturulucak ardından bls key adımı yapılacak sonra faucetten coin alınıp validator kulucak,
### Update ve kütüphane kurulumu
```
sudo apt update
sudo apt install -y curl git jq lz4 build-essential unzip

```
### Go kurulumu yapalım
```
cd $HOME
! [ -x "$(command -v go)" ] && {
VER="1.19.3"
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

### 🌱 Moniker isminizi giriniz (PORT 311 İSTERSENİZ DEĞİŞTİRİNİZ)

```
echo "export WALLET="wallet-adınız"" >> $HOME/.bash_profile
echo "export MONIKER="moniker-adınız"" >> $HOME/.bash_profile
echo "export BABYLON_CHAIN_ID="bbn-test-2"" >> $HOME/.bash_profile
echo "export BABYLON_PORT="31"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
cd || return
rm -rf babylon
git clone https://github.com/babylonchain/babylon
cd babylon || return
git checkout v0.7.2
make install
babylond version # v0.7.2

babylond config keyring-backend test
babylond config chain-id bbn-test-2
babylond init "$MONIKER" --chain-id bbn-test-2

curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/genesis.json > $HOME/.babylond/config/genesis.json

curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/addrbook.json > $HOME/.babylond/config/addrbook.json

SEEDS="8da45f9ff83b4f8dd45bbcb4f850999637fbfe3b@seed0.testnet.babylonchain.io:26656,4b1f8a774220ba1073a4e9f4881de218b8a49c99@seed1.testnet.babylonchain.io:26656"
PEERS=""
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.babylond/config/config.toml

sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.babylond/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.babylond/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.babylond/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.babylond/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.00001ubbn"|g' $HOME/.babylond/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.babylond/config/config.toml
sed -i 's|^network *=.*|network = "mainnet"|g' $HOME/.babylond/config/app.toml

# port yapılandırması in app.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${BABYLON_PORT}317\"%;
s%^address = \":8080\"%address = \":${BABYLON_PORT}080\"%;
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${BABYLON_PORT}090\"%; 
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${BABYLON_PORT}091\"%; 
s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:${BABYLON_PORT}545\"%; 
s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:${BABYLON_PORT}546\"%" $HOME/.babylond/config/app.toml

# port yapılandırması config.toml file
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${BABYLON_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${BABYLON_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${BABYLON_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${BABYLON_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${BABYLON_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${BABYLON_PORT}660\"%" $HOME/.babylond/config/config.toml


sudo tee /etc/systemd/system/babylond.service > /dev/null << EOF
[Unit]
Description=Babylon Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which babylond) start --x-crisis-skip-assert-invariants
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

### Snap atıyoruz
```
sudo apt install liblz4-tool

systemctl stop babylond

cp $HOME/.babylond/data/priv_validator_state.json $HOME/.babylond/priv_validator_state.json.backup

babylond tendermint unsafe-reset-all --home $HOME/.babylond --keep-addr-book

curl -L http://37.120.189.81/babylon_testnet/babylon_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.babylond

mv $HOME/.babylond/priv_validator_state.json.backup $HOME/.babylond/data/priv_validator_state.json


```


### Servisleri aktif edip başlatıyoruz

```
sudo systemctl daemon-reload
sudo systemctl enable babylond
sudo systemctl start babylond
```
```
sudo journalctl -u babylond -f --no-hostname -o cat
```
### Cüzdan Oluşturma
```
babylond keys add $WALLET
```
### Cüzdan import
```
babylond keys add $WALLET --recover
```
### Cüzdan listeleme
```
babylond keys list
```
### Cüzdan Bakiye Sorgulama
```
babylond q bank balances $(babylond keys show $WALLET -a)
```
### Cüzdan Silme
```
babylond keys delete cüzdan-adınız
```
## ⚡⚡⚡ BLS key oluşturun ⚡⚡⚡ $wallet ve wallet yazan kısımlara cüzdan adınızı yazınız
```
babylond create-bls-key $(babylond keys show $WALLET -a)
```
```
sudo systemctl restart babylond
```
```
sed -i -e "s|^key-name *=.*|key-name = \"wallet\"|" $HOME/.babylond/config/app.toml
```
```
sed -i -e "s|^timeout_commit *=.*|timeout_commit = \"10s\"|" $HOME/.babylond/config/config.toml
```
### Ardından restleyip validator işlemine geçebilirsiniz ( oluşturduğunuz cüzdan discordan faucet alınız)
```
sudo systemctl restart babylond
```
### Senkron kontrol edelim
```
babylond status 2>&1 | jq .SyncInfo
```

### 🔭🔭🔭 senkron kodu yada babylond hata verırse kodlar calısmıyorsa bunu giriniz
```
cp /root/go/bin/babylond /usr/local/bin
systemctl restart babylond
```
### Validator Oluşturma ( moniker ve cüzdan adınızı değiştiriniz)
```
babylond tx checkpointing create-validator \
--amount=10000000ubbn \
--pubkey=$(babylond tendermint show-validator) \
--moniker="moniker-yazınız" \
--identity= \
--details="Mustafa Kemal ATATÜRK" \
--chain-id=bbn-test-2 \
--commission-rate=0.10 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1 \
--from=$WALLET \
--gas-prices=0.1ubbn \
--gas-adjustment=1.5 \
--gas=auto \
--node http://localhost:31657 \
-y
```
### Validator Bilgileri Değiştirme Editleme
```
babylond tx staking edit-validator \
--new-moniker="molla202" \
--identity= \
--details="Mustafa Kemal ATATÜRK" \
--chain-id=bbn-test-2 \
--from=$WALLET \
--gas-prices=0.2ubbn \
--gas-adjustment=1.5 \
--gas=auto \
--node http://localhost:31657 \
-y
```
### Jailden Kurtulma
```
babylond tx slashing unjail --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Validator Bilgileri
```
babylond q epoching validator $(babylond keys show $WALLET --bech val -a) 
```
### Ödülleri Talep Etme
```
babylond tx distribution withdraw-all-rewards --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Komisyon ve Ödülleri Talep Etme
```
babylond tx distribution withdraw-rewards $(babylond keys show $WALLET --bech val -a) --commission --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delege Etme Kendine
```
babylond tx epoching delegate $(babylond keys show $WALLET --bech val -a) 1000000ubbn --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delege Etme Başkasına
```
babylond tx epoching delegate valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Redelegate (delege edilenden alıp baskasına delege etme)
```
babylond tx epoching redelegate valoper-adresini-yazınız valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delegeyi Geri Çekme
```
babylond tx epoching unbond valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Başkasına Coin Gönderme
```
babylond tx bank send cüzdan-adresi 1000000ubbn --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Oy Kullanma ( yes, no, no_with_veto yada abstain )
```
babylond tx gov vote 1 yes --from $WALLET --chain-id bbn-test-2 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y 
```
## Node Silme
```
sudo systemctl stop babylond && \
sudo systemctl disable babylond && \
rm /etc/systemd/system/babylond.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .babylond && \
rm -rf babylon && \
rm -rf $(which babylond)
```
