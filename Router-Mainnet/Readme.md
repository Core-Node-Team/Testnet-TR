<h1 align="center"> Router Chain


![image](https://github.com/user-attachments/assets/815488dc-99dc-4dad-a127-6aeba6afd9ff)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://x.com/routerprotocol)<br>
 * [Twitter-TR](https://x.com/RouterTurkiye)<br>
 * [Router Website](https://discord.gg/rKf9UYMNWC)<br>
 * [Router Stake](https://hub.routerprotocol.com/staking)<br>
 * [Router Hub/Token-Migrate](https://hub.routerprotocol.com/token/migrate)<br>
 * [Router gitbook/docs](https://docs.routerprotocol.com/networks)<br>
 * [Router Blockchain Explorer](https://explorer.corenodehq.com/Router%20Mainnet.)<br>


## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	8|
| RAM	| 32+ GB |
| Storage	| 1 tB nvme |

### 💻 Public RPC And Explorer

https://router-rpc.corenode.info/

https://router-api.corenode.info/

https://explorer.corenodehq.com/Router%20Mainnet.

Token migrate : https://hub.routerprotocol.com/token/migrate

Stake : https://hub.routerprotocol.com/staking

### 🚧 Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip gcc clang cmake build-essential -y
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

### 🚧 Dosyaları çekelim
```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.1.1/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz
```
```
git clone https://github.com/router-protocol/routerd-libs.git
```
```
echo "/root/routerd-libs" | sudo tee /etc/ld.so.conf.d/routerd-libs.conf
sudo ldconfig
```
```
wget https://github.com/CosmWasm/wasmvm/releases/download/v1.5.2/libwasmvm.x86_64.so
```
```
cp libwasmvm.x86_64.so /lib
cp libwasmvm.x86_64.so /lib64
```
### 🚧 Dosya yollarını oluşturalım
```
mkdir -p $HOME/.routerd/cosmovisor/genesis/bin
mv routerd $HOME/.routerd/cosmovisor/genesis/bin/
```

### 🚧 Sistem linkleri
```
sudo ln -s $HOME/.routerd/cosmovisor/genesis $HOME/.routerd/cosmovisor/current -f
sudo ln -s $HOME/.routerd/cosmovisor/current/bin/routerd /usr/local/bin/routerd -f
```
### 🚧 Cosmovisor kurulum
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧 Servis oluşturalım
```
sudo tee /etc/systemd/system/routerd.service > /dev/null << EOF
[Unit]
Description=router node service
After=network-online.target
 
[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.routerd"
Environment="DAEMON_NAME=routerd"
Environment="UNSAFE_SKIP_BACKUP=true"
 
[Install]
WantedBy=multi-user.target
EOF
```
### 🚧 Servisi başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable routerd
```
### 🚧 Init işlemi ve ağ ayarları
```
routerd config chain-id router_9600-1
routerd config keyring-backend file
routerd config node tcp://localhost:12457
```
```
routerd init $MONIKER --chain-id router_9600-1
```
### 🚧 Genesis ve adressbook indirelim
```
curl -Ls http://37.120.189.81/router_mainnet/genesis.json > $HOME/.routerd/config/genesis.json
curl -Ls http://37.120.189.81/router_mainnet/addrbook.json > $HOME/.routerd/config/addrbook.json
```

### 🚧 Seeds
```
sed -i -e "s|^seeds *=.*|seeds = \"11956b7fa4428725ade3ae4a1793c1e07e7ca25c@65.21.221.110:12456\"|" $HOME/.routerd/config/config.toml
```
### 🚧 Gas ayarı
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0route\"|" $HOME/.routerd/config/app.toml
```
### 🚧 Pruning
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.routerd/config/app.toml
```
### 🚧 Port ayarı (124)
```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:12458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:12457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:12460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:12456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":12466\"%" $HOME/.routerd/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:12417\"%; s%^address = \":8080\"%address = \":12480\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:12490\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:12491\"%; s%:8545%:12445%; s%:8546%:12446%; s%:6065%:12465%" $HOME/.routerd/config/app.toml
```
### 🚧 Snap
```
curl -L http://37.120.189.81/router_mainnet/router_snap.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.routerd
[[ -f $HOME/.routerd/data/upgrade-info.json ]] && cp $HOME/.routerd/data/upgrade-info.json $HOME/.routerd/cosmovisor/genesis/upgrade-info.json
```
### 🏆 Başlatalım
```
sudo systemctl start routerd && journalctl -u routerd -fo cat
```
```
journalctl -u routerd -fo cat
```



















