






<h1 align="center"> Symphony </h1>


![image](https://github.com/user-attachments/assets/64839830-41f3-4dd7-b45a-2a52a4cd2641)







 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Symphony Website](https://wardenprotocol.org/)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/Warden%20Testnet)<br>
 * [Discord](https://discord.gg/7rzkxXRK)<br>
 * [Twitter](https://twitter.com/wardenprotocol)<br>
 * [Faucet](https://testnet.ping.pub/symphony/faucet)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 160+ GB SSD |

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

### ➡️ Go Installation
```
cd $HOME
VER="1.22.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```
### 2️⃣ Install node
```
echo "export SYMPHONY_PORT="35"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
cd $HOME
rm -rf symphony
git clone https://github.com/Orchestra-Labs/symphony
cd symphony
git checkout v0.2.1
make build
```
```
mkdir -p ~/.symphonyd/cosmovisor/upgrades/0.2.1/bin
mv $HOME/symphony/build/symphonyd ~/.symphonyd/cosmovisor/upgrades/0.2.1/bin/
```
```
sudo ln -s ~/.symphonyd/cosmovisor/upgrades/0.2.1 ~/.symphonyd/cosmovisor/current -f
sudo ln -s ~/.symphonyd/cosmovisor/current/bin/symphonyd /usr/local/bin/symphonyd -f
```
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
cd
```
### ➡️ Create a service
```
sudo tee /etc/systemd/system/symphonyd.service > /dev/null << EOF
[Unit]
Description=symphony node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --home $HOME/.symphonyd
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=${HOME}/.symphonyd"
Environment="DAEMON_NAME=symphonyd"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.symphonyd/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
### ➡️ Let's activate it
```
sudo systemctl daemon-reload
sudo systemctl enable symphonyd
```
### ➡️ Initialize the node
```
symphonyd config chain-id symphony-testnet-2
symphonyd config keyring-backend test
symphonyd config node tcp://localhost:${SYMPHONY_PORT}657
symphonyd init "NODE-NAME" --chain-id symphony-testnet-2
```
### ➡️ Genesis addrbook
```

```
### ➡️ Port
```
sed -i.bak -e "s%:1317%:${SYMPHONY_PORT}317%g;
s%:8080%:${SYMPHONY_PORT}080%g;
s%:9090%:${SYMPHONY_PORT}090%g;
s%:9091%:${SYMPHONY_PORT}091%g;
s%:8545%:${SYMPHONY_PORT}545%g;
s%:8546%:${SYMPHONY_PORT}546%g;
s%:6065%:${SYMPHONY_PORT}065%g" $HOME/.symphonyd/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${SYMPHONY_PORT}658%g;
s%:26657%:${SYMPHONY_PORT}657%g;
s%:6060%:${SYMPHONY_PORT}060%g;
s%:26656%:${SYMPHONY_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${SYMPHONY_PORT}656\"%;
s%:26660%:${SYMPHONY_PORT}660%g" $HOME/.symphonyd/config/config.toml
```
### ➡️ Peers and Seeds
```
SEEDS="ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:29156"
PEERS="bbf8ef70a32c3248a30ab10b2bff399e73c6e03c@65.21.198.100:24856,f3c40275b0e198bef1c79111a04d0fed572a44da@94.72.100.234:45656,710976805e0c3069662e63b9f244db68654e2f15@65.109.93.124:29256,5660a533218eed9dbbc569f38e6bc44666b1eb17@65.21.10.105:26656,77ce4b0a96b3c3d6eb2beb755f9f6f573c1b4912@178.18.251.146:22656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.symphonyd/config/config.toml
```
### ➡️ Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.symphonyd/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.symphonyd/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" $HOME/.symphonyd/config/app.toml
```
### ➡️ Gas Settings
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0note"|g' $HOME/.symphonyd/config/app.toml
```
### ➡️ Prometheus & Indexer
```
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.symphonyd/config/config.toml
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.symphonyd/config/config.toml
```
### ➡️ Starter Snap (soon)


### ➡️ Let's get started
```
sudo systemctl start symphonyd && sudo journalctl -u symphonyd -f -o cat
```
### ➡️ Log Command
```
journalctl -u symphonyd -f -o cat
```
### ➡️ Create wallet
```
symphonyd keys add wallet-name
```
### ➡️ Import wallet
```
symphonyd keys add wallet-name --recover
```
### ➡️ Create Validator
❗️100000note = 0.1 MLD❗️
```
cd $HOME
```
```
symphonyd tx staking create-validator \
  --amount "90000note" \
  --pubkey $(symphonyd tendermint show-validator) \
  --moniker "myvalidator" \
  --identity "optional identity signature (ex. UPort or Keybase)" \
  --details "validator's (optional) details" \
  --website "validator's (optional) website" \
  --chain-id symphony-testnet-2 \
  --commission-rate "0.05" \
  --commission-max-rate "0.2" \
  --commission-max-change-rate "0.01" \
  --min-self-delegation "1" \
  --fees "800note" \
  --from wallet \
  --node=http://localhost:(whatever you typed in custom_port)657 \
  -y
  ```
### ➡️ Delegate to Yourself
```
symphonyd tx staking delegate $(symphonyd keys show wallet-name --bech val -a) amount0000note \
--chain-id symphony-testnet-2 \
--from "wallet-name" \
--fees "800note" \
--node=http://localhost:${SYMPHONY_PORT}657 \
-y
```
### ➡️ Edit Validator
```
symphonyd tx staking edit-validator \
--chain-id symphony-testnet-2 \
--commission-rate 0.05 \
--new-moniker "validator-name" \
--identity "" \
--details "" \
--website "" \
--security-contact "" \
--from "wallet-name" \
--node http://localhost:${SYMPHONY_PORT}657 \
--fees "800note" \
-y
```
### ➡️ Complete deletion
```
cd $HOME
sudo systemctl stop symphonyd
sudo systemctl disable symphonyd
sudo rm -rf /etc/systemd/system/symphonyd.service
sudo systemctl daemon-reload
sudo rm -f /usr/local/bin/symphonyd
sudo rm -f $(which symphonyd)
sudo rm -rf $HOME/.symphonyd $HOME/symphony
sed -i "/SYMPHONY_/d" $HOME/.bash_profile
```
