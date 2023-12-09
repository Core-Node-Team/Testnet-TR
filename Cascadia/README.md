![image](https://github.com/molla202/Cascadia/assets/91562185/ad3e3dfe-b3dd-46a2-a49f-49a2409d603b)

- Cascadia is a hybrid, layer-1 appchain building incentive layers for distributed networks. As trailblazers of the neo-cybernetic movement, we're committed to developing innovative solutions to web3's problems via social and artificial intelligence. Cascadia seeks to create a unique value proposition by diving deeper than the consensus layer, to explore emergent behaviors and incentive alignment within complex adaptive systems.



- Cascadia's anticipated success can be attributed to the unwavering commitment of over five hundred global contributors. We're immensely proud of our talented and diverse community and are confident that together, we'll redefine what's possible with blockchain technology.

 * [Twitter](https://twitter.com/CascadiaSystems) 
 * [Discord](https://discord.gg/cascadia)
 * [Website](https://www.cascadia.foundation/)
 * [Docs](https://cascadia.gitbook.io/gitbook/)
 * [Github](https://github.com/CascadiaFoundation)
 * [Telegram](https://t.me/+Tf6pQQSA7IkxNmU5)
 * [Turkish Telegram](https://t.me/CascadiaTR)
 * [Faucet](https://www.cascadia.foundation/faucet)

<table data-full-width="false"><thead><tr><th align="center">Chain-ID</th><th align="center">Latest Version</th><th align="center">Custom Port</th></tr></thead><tbody><tr><td align="center"><mark style="color:orange;">cascadia_11029-1</mark></td><td align="center"><mark style="color:green;">0.1.9</mark></td><td align="center"><mark style="color:yellow;">40</mark></td></tr></tbody></table>

> #### Hardware Requirements

<table data-header-hidden data-full-width="false"><thead><tr><th width="247">Hardware Requirements</th><th></th></tr></thead><tbody><tr><td>Minimum</td><td>4CPU 8RAM 100GB</td></tr><tr><td>Recommended</td><td>8CPU 32RAM 200GB</td></tr></tbody></table>

### Update
```
apt update && apt upgrade -y
apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
```
### Go
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
### Setup
```
cd $HOME || return
rm -rf $HOME/cascadia
git clone https://github.com/cascadiafoundation/cascadia.git
cd $HOME/cascadia || return
git checkout v0.1.9

make install
```

### Prepare binaries for Cosmovisor
```
mkdir -p $HOME/.cascadiad/cosmovisor/genesis/bin
mkdir -p ~/.cascadiad/cosmovisor/upgrades
mv ~/go/bin/cascadiad ~/.cascadiad/cosmovisor/genesis/bin
```
### Set vars
Not: write moniker and wallet name
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="test"" >> $HOME/.bash_profile
echo "export CASCADIA_CHAIN_ID="cascadia_11029-1"" >> $HOME/.bash_profile
echo "export CASCADIA_PORT="40"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Create application symlinks
```
sudo ln -s $HOME/.cascadiad/cosmovisor/genesis $HOME/.cascadiad/cosmovisor/current -f
sudo ln -s $HOME/.cascadiad/cosmovisor/current/bin/cascadiad /usr/local/bin/cascadiad -f
```

### Download and install Cosmovisor (Install Cosmovisor and create a service)
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### Create service
```
sudo tee /etc/systemd/system/cascadiad.service > /dev/null << EOF
[Unit]
Description=cascadia node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --chain-id cascadia_11029-1
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.cascadiad"
Environment="DAEMON_NAME=cascadiad"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.cascadiad/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```

### Config and init app
```
cascadiad config node tcp://localhost:${CASCADIA_PORT}657
cascadiad config keyring-backend os
cascadiad config chain-id cascadia_11029-1
cascadiad init $MONIKER --chain-id cascadia_11029-1
```
### Download genesis and addrbook
```
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/genesis.json > $HOME/.cascadiad/config/genesis.json
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/addrbook.json > $HOME/.cascadiad/config/addrbook.json
```
### Set seeds and peers
```
SEEDS=""
PEERS="21ca2712116138429aed3d72422379397c53fa86@65.109.65.248:34656"
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.cascadiad/config/config.toml
```
### Set custom ports in app.toml
```
sed -i.bak -e "s%:1317%:${CASCADIA_PORT}317%g;
s%:8080%:${CASCADIA_PORT}080%g;
s%:9090%:${CASCADIA_PORT}090%g;
s%:9091%:${CASCADIA_PORT}091%g;
s%:8545%:${CASCADIA_PORT}545%g;
s%:8546%:${CASCADIA_PORT}546%g;
s%:6065%:${CASCADIA_PORT}065%g" $HOME/.cascadiad/config/app.toml
```
### Set custom ports in config.toml file
```
sed -i.bak -e "s%:26658%:${CASCADIA_PORT}658%g;
s%:26657%:${CASCADIA_PORT}657%g;
s%:6060%:${CASCADIA_PORT}060%g;
s%:26656%:${CASCADIA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${CASCADIA_PORT}656\"%;
s%:26660%:${CASCADIA_PORT}660%g" $HOME/.cascadiad/config/config.toml
```
### Config pruning
```
sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.cascadiad/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.cascadiad/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.cascadiad/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.cascadiad/config/app.toml
```
### Set minimum gas price, enable prometheus and disable indexing
```
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.025aCC"|g' $HOME/.cascadiad/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.cascadiad/config/config.toml
```
### Reset and download snapshot
```
cascadiad tendermint unsafe-reset-all --home $HOME/.cascadiad --keep-addr-book

URL=https://snapshots-testnet.stake-town.com/cascadia/cascadia_11029-1_latest.tar.lz4
curl -L $URL | lz4 -dc - | tar -xf - -C $HOME/.cascadiad
[[ -f $HOME/.cascadiad/data/upgrade-info.json ]] && cp $HOME/.cascadiad/data/upgrade-info.json $HOME/.cascadiad/cosmovisor/genesis/upgrade-info.json
```
### Enable and start service
```
sudo systemctl daemon-reload
sudo systemctl enable cascadiad
sudo systemctl restart cascadiad && sudo journalctl -u cascadiad -fo cat
```
### Wallet
```
cascadiad keys add wallet-name
```
OR İMPORT
```
cascadiad keys add wallet-name --recover
```
### Validator
```
cascadiad tx staking create-validator \
--amount=1000000000000000000aCC \
--pubkey=$(cascadiad tendermint show-validator) \
--moniker="$MONIKER" \
--identity="" \
--website="" \
--details="" \
--chain-id=cascadia_11029-1 \
--commission-rate=0.05 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.1 \
--min-self-delegation=1 \
--from=$WALLET \
--gas-prices=7aCC \
--gas-adjustment=2.5 \
--gas=auto \
-y
```
### Delete
```
cd $HOME
sudo systemctl stop cascadiad
sudo systemctl disable cascadiad
sudo rm /etc/systemd/system/cascadiad.service
sudo systemctl daemon-reload
rm -f $(which cascadiad)
rm -rf $HOME/.cascadiad
rm -rf $HOME/cascadia
```

# Manuel Installation Standart setup (port 119)

### Prepare Server

```bash
sudo apt-get update && sudo apt-get upgrade -y

sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y


cd $HOME
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && source $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
```

### Install Binary

```bash
cd $HOME || return
rm -rf $HOME/cascadia
git clone https://github.com/cascadiafoundation/cascadia.git
cd $HOME/cascadia || return
git checkout v0.1.9
make install
```

### Initalize

```bash
cascadiad config chain-id cascadia_11029-1
cascadiad config keyring-backend test
cascadiad config node tcp://localhost:11957
cascadiad init $MONIKER --chain-id cascadia_11029-1
```

### Config

```bash
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/genesis.json > $HOME/.cascadiad/config/genesis.json
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/addrbook.json > $HOME/.cascadiad/config/addrbook.json
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml

SEEDS=""
PEERS="21ca2712116138429aed3d72422379397c53fa86@65.109.65.248:34656"
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.cascadiad/config/config.toml

sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:11958\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:11957\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:11960\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:11956\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":11966\"%" $HOME/.cascadiad/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:11917\"%; s%^address = \":8080\"%address = \":11980\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:11990\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:11991\"%; s%:8545%:11945%; s%:8546%:11946%; s%:6065%:11965%" $HOME/.cascadiad/config/app.toml

sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.cascadiad/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.cascadiad/config/config.toml

sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.cascadiad/config/app.toml

sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.cascadiad/config/config.toml
```

### Download Snapshot

```bash
sudo apt install liblz4-tool -y
URL=https://snapshots-testnet.stake-town.com/cascadia/cascadia_11029-1_latest.tar.lz4
curl -L $URL | lz4 -dc - | tar -xf - -C $HOME/.cascadiad
```

### Create Service

```bash
sudo tee /etc/systemd/system/cascadiad.service > /dev/null <<EOF
[Unit]
Description=Cascadia Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which cascadiad) start --chain-id cascadia_11029-1 --home $HOME/.cascadiad
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable cascadiad
```

### Start Node And Foolow Logs

```bash
sudo systemctl start cascadiad && sudo journalctl -u cascadiad -fo cat
```

### **Continue To** [**Become A Validator**](installation.md#become-a-validator)
