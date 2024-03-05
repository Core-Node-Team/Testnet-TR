

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/0d7cf06e-61ae-41ba-a430-77170de2b1e4)


* [Twitter](https://twitter.com/quicksilverzone)
* [Telegram](https://t.me/quicksilverzone)
* [Discord](https://discord.gg/DBg2Vr3x)
* [Website](https://quicksilver.zone/)
* [Docs](https://docs.quicksilver.zone/)
* [Github](https://github.com/ingenuity-build/)
* [Quicksilver Liquid Staking Protocol](https://app.quicksilver.zone/)

### System

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	8+ vcpu|
| ✔️RAM	| 32+ GB |
| ✔️Storage	| 600+ GB SSD |
| ✔️UBUNTU | 22 OR 20 |

<table data-full-width="false"><thead><tr><th align="center">Chain-ID</th><th align="center">Latest Version</th><th align="center">Custom Port</th></tr></thead><tbody><tr><td align="center"><mark style="color:orange;">quicksilver-2</mark></td><td align="center"><mark style="color:green;">v1.2.17</mark></td><td align="center"><mark style="color:yellow;">111</mark></td></tr></tbody></table>

### Auto Script

```
curl -sSL -o quick.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Mainnet/quick.sh && chmod +x quick.sh && bash ./quick.sh
``` 

### Update
```
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
```
### Go
```
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.20.11.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)

```
### Download 
```
cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.4.7
```
```
make build
```
### Cosmovisor
```
mkdir -p $HOME/.quicksilverd/cosmovisor/genesis/bin
mv build/quicksilverd $HOME/.quicksilverd/cosmovisor/genesis/bin/
rm -rf build
```
### Create application symlinks
```
sudo ln -s $HOME/.quicksilverd/cosmovisor/genesis $HOME/.quicksilverd/cosmovisor/current -f
sudo ln -s $HOME/.quicksilverd/cosmovisor/current/bin/quicksilverd /usr/local/bin/quicksilverd -f
```

### install Cosmovisor
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### Create service
```
sudo tee /etc/systemd/system/quicksilver.service > /dev/null << EOF
[Unit]
Description=quicksilver node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.quicksilverd"
Environment="DAEMON_NAME=quicksilverd"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.quicksilverd/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable quicksilver.service
```

### Set node configuration
```
quicksilverd config chain-id quicksilver-2
quicksilverd config keyring-backend file
quicksilverd config node tcp://localhost:11157
```
### Initialize the node
```
quicksilverd init $MONIKER --chain-id quicksilver-2
```
### Download genesis and addrbook
```
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Mainnet/genesis.json > $HOME/.quicksilverd/config/genesis.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Mainnet/addrbook.json > $HOME/.quicksilverd/config/addrbook.json
```
### Add seeds
```
sed -i -e "s|^seeds *=.*|seeds = \"400f3d9e30b69e78a7fb891f60d76fa3c73f0ecc@quicksilver.rpc.kjnodes.com:11159\"|" $HOME/.quicksilverd/config/config.toml
```
### Set minimum gas price
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.0001uqck\"|" $HOME/.quicksilverd/config/app.toml
```
### Set pruning
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.quicksilverd/config/app.toml
```
### Set custom ports
```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:11158\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:11157\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:11160\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:11156\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":11166\"%" $HOME/.quicksilverd/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:11117\"%; s%^address = \":8080\"%address = \":11180\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:11190\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:11191\"%; s%:8545%:11145%; s%:8546%:11146%; s%:6065%:11165%" $HOME/.quicksilverd/config/app.toml
```

### Start service and check the logs
```
sudo systemctl start quicksilver.service && sudo journalctl -u quicksilver.service -f --no-hostname -o cat
```


# Faydalı Linkler

## [Komutlar](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Ortak-Komutlar.md)
## [Node Yedekleme ve Taşıma](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Yedekleme%20ve%20Ta%C5%9F%C4%B1ma.md)
## [Port Değiştirme](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Port%20de%C4%9Fi%C5%9Ftirme.md)
## [Sync-Peer-FAQ](https://github.com/Core-Node-Team/Cosmos-Aglarinda-Node-Calistirmak/blob/main/Sync-Peer%20Nedir.md)


<div align="center">

# Core Node 

#  [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)|[Web Site](https://corenode.info/)  

![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

## Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.
#

</div>
