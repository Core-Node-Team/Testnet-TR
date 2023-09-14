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
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
```
# go kuruyoruz 
```
ver="1.20.3"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
# Dosyaları çekelim ve yapılandıralım
```
cd $HOME
rm -rf dymension
git clone https://github.com/dymensionxyz/dymension.git
cd dymension
git checkout v1.0.2-beta


make build


mkdir -p $HOME/.dymension/cosmovisor/genesis/bin
mv build/dymd $HOME/.dymension/cosmovisor/genesis/bin/
rm -rf build


sudo ln -s $HOME/.dymension/cosmovisor/genesis $HOME/.dymension/cosmovisor/current -f
sudo ln -s $HOME/.dymension/cosmovisor/current/bin/dymd /usr/local/bin/dymd -f
```
# Cosmovisor ve servis kurulumu
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0


sudo tee /etc/systemd/system/dymd.service > /dev/null << EOF
[Unit]
Description=dymension node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.dymension"
Environment="DAEMON_NAME=dymd"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.dymension/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable dymd
```
# Node kurulumu.
NOT : $MONİKER KISMINA NODE ADINIZI GİRİNİZ.

```
dymd config chain-id froopyland_100-1
dymd config keyring-backend test
dymd config node tcp://localhost:14657


dymd init $MONIKER --chain-id froopyland_100-1


curl -Ls https://raw.githubusercontent.com/molla202/Dymension-Froopyland/main/genesis.json
curl -Ls https://raw.githubusercontent.com/molla202/Dymension-Froopyland/main/addrbook.json


sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@dymension-testnet.rpc.kjnodes.com:14659\"|" $HOME/.dymension/config/config.toml

peers=55730501bda0d20bd0e88163aa948c26a2806367@89.163.157.64:36656,1e92b79a713b18dffd4e075ddfa1dab87dd215a9@70.34.197.147:26656,863978ef83da4b76a8dc61787c8edd2027ab4abf@81.0.220.100:26656,e7857b8ed09bd0101af72e30425555efa8f4a242@148.251.177.108:20556,3410e9bc9c429d6f35e868840f6b7a0ccb29020b@46.4.5.45:20556
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" ~/.dymension/config/config.toml

sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.025udym,0.025uatom\"|" $HOME/.dymension/config/app.toml


sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.dymension/config/app.toml


sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:14658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:14657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:14660\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:14656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":14666\"%" $HOME/.dymension/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:14617\"%; s%^address = \":8080\"%address = \":14680\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:14690\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:14691\"%; s%:8545%:14645%; s%:8546%:14646%; s%:6065%:14665%" $HOME/.dymension/config/app.toml
sudo systemctl start dymd && sudo journalctl -u dymd -f --no-hostname -o cat
```

# cüzdan olusturuyoruz yada import ediyoruz
```
dymd keys add cüzdan-adı 
```
```
dymd keys add cüzdan-adı --recover
```
# cüzdan adı ve moniker girelim
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
