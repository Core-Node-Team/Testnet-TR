# Dymension
![1500x500](https://user-images.githubusercontent.com/91562185/234884978-f1a6b9f1-5939-422c-af5d-ca66a9feb758.jpg)

## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 500 GB SSD |


# update ve kütüphane kuruyoruz
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y  
```
# go kuruyoruz
```
sudo rm -rvf /usr/local/go/
wget https://golang.org/dl/go1.19.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
rm go1.19.3.linux-amd64.tar.gz
```


# cüzdan adı ve node adını değiştirin.
```
echo "export WALLET="cüzdan-adı"" >> $HOME/.bash_profile
echo "export MONIKER="node-adı"" >> $HOME/.bash_profile
echo "export DYMENSION_CHAIN_ID="froopyland_100-1"" >> $HOME/.bash_profile
echo "export DYMENSION_PORT="33"" >> $HOME/.bash_profile
source $HOME/.bash_profile


cd $HOME
rm -rf dymension
git clone https://github.com/dymensionxyz/dymension.git --branch v1.0.2-beta
cd dymension
make install


dymd config node tcp://localhost:${DYMENSION_PORT}657
dymd config chain-id froopyland_100-1
dymd init $MONIKER --chain-id froopyland_100-1


wget -O genesis.json https://raw.githubusercontent.com/molla202/Dymension-Froopyland/main/genesis.json --inet4-only
mv genesis.json ~/.dymension/config

wget -O addrbook.json https://raw.githubusercontent.com/molla202/Dymension-Froopyland/main/addrbook.json --inet4-only
mv addrbook.json ~/.dymension/config

sed -i 's/seeds = ""/seeds = "284313184f63d9f06b218a67a0e2de126b64258d@seeds.silknodes.io:26157,92308bad858b8886e102009bbb45994d57af44e7@rpc-t.dymension.nodestake.top:666,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:20556"/' ~/.dymension/config/config.toml


sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${DYMENSION_PORT}317\"%;
s%^address = \":8080\"%address = \":${DYMENSION_PORT}080\"%;
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${DYMENSION_PORT}090\"%; 
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${DYMENSION_PORT}091\"%; 
s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:${DYMENSION_PORT}545\"%; 
s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:${DYMENSION_PORT}546\"%" $HOME/.dymension/config/app.toml


sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${DYMENSION_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${DYMENSION_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${DYMENSION_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${DYMENSION_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${DYMENSION_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${DYMENSION_PORT}660\"%" $HOME/.dymension/config/config.toml


sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.dymension/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.dymension/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.dymension/config/app.toml


sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.0udym"/g' $HOME/.dymension/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.dymension/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.dymension/config/config.toml


sudo tee /etc/systemd/system/dymd.service > /dev/null <<EOF
[Unit]
Description=Dymension node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which dymd) start --home $HOME/.dymension
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF



sudo systemctl daemon-reload
sudo systemctl enable dymd
sudo systemctl restart dymd && sudo journalctl -u dymd -fo cat
```
# cüzdan olusturuyoruz yada import ediyoruz
```
dymd keys add cüzdan-adı 
```
```
dymd keys add cüzdan-adı --recover
```
# hiç bişi değiştirmiyoruz olduğu gibi en başta ayarladık zaten
```
dymd tx staking create-validator \
  --amount 1000000udym \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \ 
  --commission-rate "0.05" \
  --min-self-delegation "1" \
  --pubkey  $(dymd tendermint show-validator) \
  --moniker $MONIKER \
  --chain-id froopyland_100-1 \
  -y
  ```
## delege
```
dymd tx staking delegate valoper-adres 450000000udym --from cüzdan-adı --chain-id froopyland_100-1 --gas-adjustment 1.8 -y
```
## Silme Kodu
 ```
sudo systemctl stop dymd
sudo systemctl disable dymd
sudo rm -rf /etc/systemd/system/dymd.service
sudo rm $(which dymension)
sudo rm -rf $HOME/.dymension
sudo rm -rf $HOME/dymension
sed -i "/DYMENSİON_/d" $HOME/.bash_profile
 ```
