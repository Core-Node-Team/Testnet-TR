
![image](https://github.com/molla202/MantraChain/assets/91562185/fd76840c-6f3f-4fdb-8650-58e84ae353fa)


`Faucet` : https://faucet.hongbai.mantrachain.io/

`Discord` : https://discord.gg/tSgpKbaP

`Explorer` : 

## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 500 GB SSD |

### Update ve gereklilikleri kuralum
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```
### Go kurulumu
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
### Varyasyonları ayarlayalım

Not: isim yazılacak yerler var unutmayınız.
```
echo "export WALLET="cüzdan-adı-yaz"" >> $HOME/.bash_profile
echo "export MONIKER="moniker-adı-yaz"" >> $HOME/.bash_profile
echo "export MANTRA_CHAIN_ID="mantra-hongbai-1"" >> $HOME/.bash_profile
echo "export MANTRA_PORT="23"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Dosyaları çekelim
```
cd $HOME
rm -rf /usr/lib/libwasmvm.x86_64.so
sudo wget -P /usr/lib https://github.com/CosmWasm/wasmvm/releases/download/v1.3.1/libwasmvm.x86_64.so
wget https://github.com/MANTRA-Finance/public/raw/main/mantrachain-hongbai/mantrachaind-linux-amd64.zip
unzip mantrachaind-linux-amd64.zip
rm -rf mantrachaind-linux-amd64.zip
mv mantrachaind $HOME/go/bin
```
### İnit işlemi
Not: adınızı yazmayı unutmayınız
```
mantrachaind config node tcp://localhost:${MANTRA_PORT}657
mantrachaind config keyring-backend os
mantrachaind config chain-id mantra-hongbai-1
```
```
mantrachaind init "buraya-yazılacak" --chain-id mantra-hongbai-1
```
### Genesis ve adressbook indirelim

```
curl -Ls https://raw.githubusercontent.com/MANTRA-Finance/public/main/mantrachain-hongbai/genesis.json > $HOME/.mantrachain/config/genesis.json
```

### Seed ve peer ayarları

```
CONFIG_TOML="$HOME/.mantrachain/config/config.toml"
SEEDS="d6016af7cb20cf1905bd61468f6a61decb3fd7c0@34.72.142.50:26656"
PEERS="da061f404690c5b6b19dd85d40fefde1fecf406c@34.68.19.19:26656,20db08acbcac9b7114839e63539da2802b848982@34.72.148.3:26656,7ba9e5051a1cb2542c2ecbfa12954bdbab3121f5@34.171.207.218:26656,7ab572034a2d1d9d67e31dbac43c4554e0e53ba5@104.198.160.158:26656,75855dec829d40f105299f09dc64f05b44057a3a@34.134.75.248:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $CONFIG_TOML
sed -i.bak -e "s/^seeds =.*/seeds = \"$SEEDS\"/" $CONFIG_TOML
external_address=$(wget -qO- eth0.me)
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $CONFIG_TOML
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0002uom"|g' $CONFIG_TOML
sed -i 's|^prometheus *=.*|prometheus = true|' $CONFIG_TOML
sed -i -e "s/^filter_peers *=.*/filter_peers = \"true\"/" $CONFIG_TOML
```
### Port ayarları
```
sed -i.bak -e "s%:1317%:${MANTRA_PORT}317%g;
s%:8080%:${MANTRA_PORT}080%g;
s%:9090%:${MANTRA_PORT}090%g;
s%:9091%:${MANTRA_PORT}091%g;
s%:8545%:${MANTRA_PORT}545%g;
s%:8546%:${MANTRA_PORT}546%g;
s%:6065%:${MANTRA_PORT}065%g" $HOME/.mantrachain/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${MANTRA_PORT}658%g;
s%:26657%:${MANTRA_PORT}657%g;
s%:6060%:${MANTRA_PORT}060%g;
s%:26656%:${MANTRA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${MANTRA_PORT}656\"%;
s%:26660%:${MANTRA_PORT}660%g" $HOME/.mantrachain/config/config.toml
```
### Puring
```
sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.mantrachain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.mantrachain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.mantrachain/config/app.toml
```
### Servis olusturalım
```
sudo tee /etc/systemd/system/mantrachaind.service > /dev/null <<EOF
[Unit]
Description=Mantra node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.mantrachain
ExecStart=$(which mantrachaind) start --home $HOME/.mantrachain
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### Snap atalım...
```
...
```
### Servisi ve nodu başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable mantrachaind
sudo systemctl restart mantrachaind
sudo journalctl -u mantrachaind -fo cat
```
### cüzdan olusturalım
```
mantrachaind keys add cüzdan-adı
```

### Validator olusturalım
Not: cüzdan ve moniker adınızı yazınız....
```
mantrachaind tx staking create-validator \
--amount 1000000uaum \
--from cüzdan-adınızı-yazınız \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(mantrachaind tendermint show-validator) \
--moniker "Adınızı-yazınız" \
--identity "" \
--details "corenode.info" \
--chain-id mantra-hongbai-1 \
--gas auto --gas-adjustment 1.5 \
--fees 50uaum \
-y
```
