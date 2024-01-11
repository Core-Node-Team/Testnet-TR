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

PEERS="123929fdd6543f82dfff28ca65f3b9cfb270f263@89.163.129.252:16456,a3c09a07b86de7cfaaf3d6c8c72f17c907dbc1d9@89.116.26.45:16456,a34f6e8692f0aa1cefdadc079a0d7c72c641b286@109.228.160.58:16456,e1393da5f12846cbc45a222ff80f4f5ac6359a6f@173.249.25.249:16456,9e229fb23617e6d1fc8f7a1c7b5120f39fe82d00@84.46.255.220:16456,624c44384b25e193989e7e8c6d9dc562b7735e50@154.26.128.108:16456,a3754e66d04ed81fc4da98c18bd3aeabc0c1394e@161.97.74.8:16456,022c802084b1faf2138f9076fe7dd29540a97ffb@144.91.110.78:16456,f55669d08fbfdeb6ccae5a5537687668a39481f6@188.119.112.135:16456,7907142fa13feecb5d10efeabf38467657e93668@213.202.216.196:16456,c9e8aa4e57116afbe80915621624b738949e0309@158.220.109.204:16456,59c88a4e4f39b68424e5d2f463dd9667392efd7c@185.194.217.231:16456,2359240b99824284c1c89d2b4ba7770a7212e50f@207.180.235.178:16456,a246886a74308e2cfc1b403c31f6f87a5a7992a0@46.250.240.29:16456,a45344a36fa02187ddb6f3741e3c8425a19d07ba@62.171.186.40:31156,a067eb05e2df8ccc2ba99039047b98bc31399a9a@5.78.69.113:3156,14e5a49a76d58d2ad63a4f70dbcf0f726ac529d1@65.21.107.96:16456,08cbf2178193f6165cbec2053f7f00017520c380@173.249.47.22:16456,d488d73c6b5c2dcc0294ce1c2a75f882251bce04@65.108.60.230:16456,5c54fec9dff6f81f83bb7753ce18e43c7dc95b24@194.163.173.173:16456,87f942596810d8b2f8a86470caef0d7855813f89@65.109.48.247:09656,264bd9d69ff069f1cf3a687336c5da30b9ad6333@38.242.242.46:16456,beddbcd4a78adef0e6adc5e6cc445cb601608706@155.133.27.150:16456,3cacc1043c68467339b0212621c9888cee77623a@104.251.222.122:16456,8b4cde234f671d5263b996704e5926cc122d18bc@185.135.137.24:16456,5957d28e620a04cbafb8b506d96736f3a8ce53b0@165.232.82.210:31156,343da9ef02d2e6c96001f902b260bdb634d14ddc@149.102.159.15:16456,2b9a417d83bf21b26415a228250597a1be865787@144.91.79.231:16456,d8ad9421acea49336c5f460ff0e89975fe5ffb1a@194.163.134.227:31156,af3b4159b459ee544dca7e7a52eb55539ffb4732@143.42.68.147:26656,cd72d570c728aeb8cfd0679eaa9e8dd2a41474e5@62.171.144.128:26656,410f08405a102aa660af2ee0d06ab065111b7ce9@38.242.237.5:31156,8af526c37c4892745038d8016ec44056b1a70725@3.22.8.141:26656,06ae21da81c0bec51a1aa9e91e2dcc9a696eaea2@62.171.173.131:16456,036887985bac48574e29d90a9c5e235630a66e70@89.116.29.84:26656,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:16456,6c564cf63e0835a559ed4df9ee1ea79536abd1a9@45.85.147.23:26656,868730197ee267db3c772414ec1cd2085cc036d4@148.251.235.130:17656,21af6c66c8ab043e0d9b35bcbeb3ed7b12e96232@168.119.77.61:16456,6aa2fa186f42295b43318344239a40fd29fda451@85.190.254.191:16456,c627530036f7178c8f6bd155ba8da1d64120fb70@185.216.75.112:16456,79fab4c80baaaae785c39b287a6a678ea7dbaa02@194.180.176.180:16456,6ad120cbb54cc02f0fc4c3ed46755979b2df42f4@149.102.132.207:31656,13a72973dfe3ce0eec18f50c63c81411f094f270@161.97.112.48:16456,4c9c7b18d86b464cd03fd87dc1a240c74fed1730@38.242.244.202:16456,3774fb9996de16c2f2280cb2d938db7af88d50be@162.62.52.147:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.babylond/config/config.toml

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
