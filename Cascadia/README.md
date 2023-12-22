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


### Güncelleme v0.2.0
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.2.0.sh | bash
```



# Cosmovisor setup

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
# Useful Commands

##

## Key

### Add New Key

```
cascadiad keys add wallet
```

### Recover Existing Key

```
cascadiad keys add wallet --recover
```

### List All Keys

```
cascadiad keys list
```

### Delete Keys

```
cascadiad keys delete wallet
```

### Query Wallet Balance

```
cascadiad q bank balances $(cascadiad keys show wallet -a)
```

##

## Validator

### Create New Validator

```
cascadiad tx staking create-validator \
--amount 1000000aCC \
--pubkey $(cascadiad tendermint show-validator) \
--moniker "MONIKER_NAME" \
--identity "KEYBASE_ID" \
--details "DETAILS" \
--website "WEBSITE_URL" \
--chain-id cascadia_11029-1 \
--commission-rate 0.05 \
--commission-max-rate 0.20 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--gas-prices 0.1aCC \
-y
```

### Edit Existing Validator

```
cascadiad tx staking edit-validator \
--new-moniker "MONIKER_NAME" \
--identity "KEYBASE_ID" \
--details "DETAILS" \
--website "WEBSITE_URL" \
--chain-id cascadia_11029-1 \
--commission-rate 0.05 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--gas-prices 0.1aCC \
-y
```

### Validator Details

```
cascadiad q staking validator $(cascadiad keys show wallet --bech val -a)
```

### Validator Unjail

```
cascadiad tx slashing unjail --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices  -y
```

### Jail Reason

```
cascadiad query slashing signing-info $(cascadiad tendermint show-validator)
```

### List All Active Validators

```
cascadiad q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_BONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```

### List All Inactive Validators

```
cascadiad q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_UNBONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```

## Token

### Send Token

```
cascadiad tx bank send wallet <TO_WALLET_ADDRESS> 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Delegate

```
cascadiad tx staking delegate <TO_VALOPER_ADDRESS> 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Delegate To Yourself

```
cascadiad tx staking delegate $(cascadiad keys show wallet --bech val -a) 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Redelegate

```
cascadiad tx staking redelegate <FROM_VALOPER_ADDRESS> <TO_VALOPER_ADDRESS> 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Redelegate From Your Validator To Another

```
cascadiad tx staking redelegate $(cascadiad keys show wallet --bech val -a) <TO_VALOPER_ADDRESS> 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Unbond Tokens From Your Validator

```
cascadiad tx staking unbond $(cascadiad keys show wallet --bech val -a) 1000000aCC --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Withdraw Rewards From All Validators

```
cascadiad tx distribution withdraw-all-rewards --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Withdraw Commission And Rewards From Your Validator

```
cascadiad tx distribution withdraw-rewards $(cascadiad keys show wallet --bech val -a) --commission --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

## Governance

### List All Proposals

```
cascadiad query gov proposals
```

### View Proposal By ID

```
cascadiad query gov proposal <ID>
```

### Vote Yes

```
cascadiad tx gov vote <ID> yes --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Vote No

```
cascadiad tx gov vote <ID> no --from wallet --chain-id cascadia_11029-11 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Vote Abstain

```
cascadiad tx gov vote <ID> abstain --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

### Vote No With Veto

```
cascadiad tx gov vote <ID> no_with_veto --from wallet --chain-id cascadia_11029-1 --gas-adjustment 1.5 --gas auto --gas-prices 0.1aCC -y
```

## Configuration Settings

### Pruning

```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.cascadiad/config/app.toml
```

### Enable Indexer

```
sed -i -e 's|^indexer *=.*|indexer = kv|' $HOME/.cascadiad/config/config.toml
```

### Disable İndexer

```
sed -i -e 's|^indexer *=.*|indexer = null|' $HOME/.cascadiad/config/config.toml
```

### Change Default Port

> #### CUSTOM\_PORT=119

```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${CUSTOM_PORT}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${CUSTOM_PORT}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${CUSTOM_PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${CUSTOM_PORT}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${CUSTOM_PORT}66\"%" $HOME/.cascadiad/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${CUSTOM_PORT}17\"%; s%^address = \":8080\"%address = \":${CUSTOM_PORT}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${CUSTOM_PORT}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${CUSTOM_PORT}91\"%" $HOME/.cascadiad/config/app.toml
```

### Set Minimum Gas Price

```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml
```

### Enable Prometheus

```
sed -i -e s/prometheus = false/prometheus = true/ $HOME/.cascadiad/config/config.toml
```

### Reset Chain Data

```
cascadiad tendermint unsafe-reset-all --keep-addr-book --home $HOME/.cascadiad --keep-addr-book
```

## Status And Control

### Sync Status

```
cascadiad status 2>&1 | jq .SyncInfo
```

### Validator Status

```
cascadiad status 2>&1 | jq .ValidatorInfo
```

### Node Status

```
cascadiad status 2>&1 | jq .NodeInfo
```

### Validator Key Control

```
[[ $(cascadiad q staking validator $(cascadiad keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = $(cascadiad status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
```

### Query TX

```
cascadiad query tx <TX_ID>
```

### Get Node Peer

```
echo $(cascadiad tendermint show-node-id)@$(curl -s ifconfig.me):$(cat $HOME/.cascadiad/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')
```

### Get Live Peers

```
curl -sS http://localhost:11957/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"' | awk -F ':' '{print $1":"$(NF)}'
```

## Service Management

Reload Service Configuration

```
sudo systemctl daemon-reload
```

Enable Service

```
sudo systemctl enable cascadiad
```

Disable Service

```
sudo systemctl disable cascadiad
```

Start Service

```
sudo systemctl start cascadiad
```

Stop Service

```
sudo systemctl stop cascadiad
```

Restart Service

```
sudo systemctl restart cascadiad
```

Check Service Status

```
sudo systemctl status cascadiad
```

Check Service Logs

```
sudo journalctl -u cascadiad -f --no-hostname -o cat
```

## Remove Node

```
sudo systemctl stop cascadiad && sudo systemctl disable cascadiad && sudo rm /etc/systemd/system/cascadiad.service && sudo systemctl daemon-reload && rm -rf $HOME/.cascadiad && rm -rf $HOME/cascadiad && sudo rm -rf $(which cascadiad)
```
