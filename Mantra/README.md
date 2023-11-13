
![image](https://github.com/molla202/MantraChain/assets/91562185/fd76840c-6f3f-4fdb-8650-58e84ae353fa)

`Form` : https://docs.google.com/forms/d/e/1FAIpQLSc_UdA4YX2DNWp-056m4qF9KfIFjCCp1aBylpksM2WtuFVeow/viewform

`Faucet` : https://faucet.testnet.mantrachain.io

`Discord` : https://discord.gg/tSgpKbaP

`Explorer` : https://testnet.itrocket.net/mantra/staking

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
echo "export MANTRA_CHAIN_ID="mantrachain-testnet-1"" >> $HOME/.bash_profile
echo "export MANTRA_PORT="22"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Dosyaları çekelim
```
cd $HOME
sudo wget -O /usr/lib/libwasmvm.x86_64.so https://github.com/CosmWasm/wasmvm/releases/download/v1.3.0/libwasmvm.x86_64.so
wget https://testnet-files.itrocket.net/mantra/mantrachaind-linux-amd64.zip
unzip mantrachaind-linux-amd64.zip
rm mantrachaind-linux-amd64.zip
mv mantrachaind $HOME/go/bin
```
### İnit işlemi
Not: adınızı yazmayı unutmayınız
```
mantrachaind config node tcp://localhost:${MANTRA_PORT}657
mantrachaind config keyring-backend os
mantrachaind config chain-id mantrachain-testnet-1
mantrachaind init "buraya-yazılacak" --chain-id mantrachain-testnet-1
```
```
### Genesis ve adressbook indirelim
wget -O $HOME/.mantrachain/config/genesis.json https://testnet-files.itrocket.net/mantra/genesis.json
wget -O $HOME/.mantrachain/config/addrbook.json https://testnet-files.itrocket.net/mantra/addrbook.json

### Seed ve peer ayarları
SEEDS="a9a71700397ce950a9396421877196ac19e7cde0@mantra-testnet-seed.itrocket.net:22656"
PEERS="1a46b1db53d1ff3dbec56ec93269f6a0d15faeb4@mantra-testnet-peer.itrocket.net:22656,cc5c6065230c8108a8bbb7c2799de486cb70dfea@37.27.19.208:22656,c2320758ffefd5531758a3351b9b4dbd0adda4c1@31.220.95.65:22656,c4bec34390d2ab1004b9a25580c75e4743e033a1@65.108.72.253:22656,e6921a8a228e12ebab0ab70d9bcdb5364c5dece5@65.108.200.40:47656,2d2f8b62feee6b0fcbdec78d51d4ba9959e33c87@65.108.124.219:34656,4a22a9cbabe4313674d2058a964aef2863af9213@185.197.251.195:26656,c0828205f0dea4ef6feb61ee7a9e8f376be210f4@161.97.149.123:29656,30235fa097d100a14d2b534fdbf67e34e8d5f6cf@65.21.133.86:21656,11979cc25839ee3fde69d40138c0afa8ade1dc0e@161.97.141.80:656,d21ee7be993180e93fa02b8a764c569a26830322@194.233.92.184:22656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.mantrachain/config/config.toml

### Port ayarları
sed -i.bak -e "s%:1317%:${MANTRA_PORT}317%g;
s%:8080%:${MANTRA_PORT}080%g;
s%:9090%:${MANTRA_PORT}090%g;
s%:9091%:${MANTRA_PORT}091%g;
s%:8545%:${MANTRA_PORT}545%g;
s%:8546%:${MANTRA_PORT}546%g;
s%:6065%:${MANTRA_PORT}065%g" $HOME/.mantrachain/config/app.toml

sed -i.bak -e "s%:26658%:${MANTRA_PORT}658%g;
s%:26657%:${MANTRA_PORT}657%g;
s%:6060%:${MANTRA_PORT}060%g;
s%:26656%:${MANTRA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${MANTRA_PORT}656\"%;
s%:26660%:${MANTRA_PORT}660%g" $HOME/.mantrachain/config/config.toml

### Puring
sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.mantrachain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.mantrachain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.mantrachain/config/app.toml

### Gas ve prometeus ayarları
sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.0001uaum"/g' $HOME/.mantrachain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.mantrachain/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.mantrachain/config/config.toml
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
mantrachaind tendermint unsafe-reset-all --home $HOME/.mantrachain
if curl -s --head curl https://testnet-files.itrocket.net/mantra/snap_mantra.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl https://testnet-files.itrocket.net/mantra/snap_mantra.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.mantrachain
    else
  echo no have snap
fi
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
--chain-id mantrachain-testnet-1 \
--gas auto --gas-adjustment 1.5 --fees 50uaum \
-y
```
