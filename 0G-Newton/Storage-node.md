<h1 align="center"> 0G

![image](https://github.com/molla202/0G/assets/91562185/6eca238f-cd35-411b-9c5a-857fbd80dd33)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://twitter.com/0G_labs)<br>
 * [0G Website](https://0g.ai/)<br>
 * [0G Blog](https://blog.0g.ai/)<br>
 * [0G gitbook/docs](https://zerogravity.gitbook.io/0g-doc/)<br>
 * [0G Telegram](https://t.me/web3_0glabs)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/0G%20Testnet.)<br>


## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
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
### Rust kuralım
Not: 1 seçelim
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source ~/.profile
```
```
source ~/.cargo/env
```
### Repoyu çekelim
```
git clone -b v0.2.0 https://github.com/0glabs/0g-storage-node.git
```
### Build edelim
Not: uzun sürer.
```
cd $HOME/0g-storage-node
git submodule update --init
sudo apt install cargo
cargo build --release
```
### varyasyonları atayalım
Not: bişi değişmicek
```
echo 'export LOG_CONTRACT_ADDRESS="0xb8F03061969da6Ad38f0a4a9f8a86bE71dA3c8E7"' >> ~/.bash_profile
echo 'export MINE_CONTRACT="0x96D90AAcb2D5Ab5C69c1c351B0a0F105aae490bE"' >> ~/.bash_profile
echo 'export ZGS_LOG_SYNC_BLOCK="479806"' >> ~/.bash_profile
echo 'export BLOCKCHAIN_RPC_ENDPOINT="http://0.0.0.0:16545"' >> ~/.bash_profile
```
```
source ~/.bash_profile
```
```
echo -e "LOG_CONTRACT_ADDRESS: $LOG_CONTRACT_ADDRESS\nMINE_CONTRACT: $MINE_CONTRACT\nZGS_LOG_SYNC_BLOCK: $ZGS_LOG_SYNC_BLOCK\nBLOCKCHAIN_RPC_ENDPOINT: $BLOCKCHAIN_RPC_ENDPOINT\n\033[33mCoreNode Community\033[0m"
```

### 1.private key alalım validator çalışan yerden
```
PRIVATE_KEY=$(0gchaind keys unsafe-export-eth-key wallet) &&
sed -i 's|^miner_key = ""|miner_key = "'"$PRIVATE_KEY"'"|' $HOME/0g-storage-node/run/config.toml
```
### Ayarlamaları yapalım
```
sed -i '
s|# network_dir = "network"|network_dir = "network"|
s|# network_enr_tcp_port = 1234|network_enr_tcp_port = 1234|
s|# network_enr_udp_port = 1234|network_enr_udp_port = 1234|
s|# network_libp2p_port = 1234|network_libp2p_port = 1234|
s|# network_discovery_port = 1234|network_discovery_port = 1234|
s|# rpc_enabled = true|rpc_enabled = true|
s|# db_dir = "db"|db_dir = "db"|
s|# log_config_file = "log_config"|log_config_file = "log_config"|
s|# log_directory = "log"|log_directory = "log"|
' $HOME/0g-storage-node/run/config.toml
```
```
sed -i '
s|^network_boot_nodes = \".*\"|network_boot_nodes = \["/ip4/54.219.26.22/udp/1234/p2p/16Uiu2HAmTVDGNhkHD98zDnJxQWu3i1FL1aFYeh9wiQTNu4pDCgps","/ip4/52.52.127.117/udp/1234/p2p/16Uiu2HAkzRjxK2gorngB1Xq84qDrT4hSVznYDHj6BkbaE4SGx9oS"\]|
s|^log_contract_address = ".*"|log_contract_address = "'"$LOG_CONTRACT_ADDRESS"'"|
s|^mine_contract_address = ".*"|mine_contract_address = "'"$MINE_CONTRACT"'"|
s|^log_sync_start_block_number = .*|log_sync_start_block_number = '"$ZGS_LOG_SYNC_BLOCK"'|
' $HOME/0g-storage-node/run/config.toml
```
```
sed -i "s|^blockchain_rpc_endpoint = \".*\"|blockchain_rpc_endpoint = \"$BLOCKCHAIN_RPC_ENDPOINT\"|" $HOME/0g-storage-node/run/config.toml
```
## Servisi kuralım
```
sudo tee /etc/systemd/system/zgsd.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=root
WorkingDirectory=$HOME/0g-storage-node/run
ExecStart=$HOME/0g-storage-node/target/release/zgs_node --config $HOME/0g-storage-node/run/config.toml
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable zgsd
sudo systemctl restart zgsd
```

# check your log list
```
ls ~/0g-storage-node/run/log/
```
# check your last log
```
tail -f ~/0g-storage-node/run/log/zgs.log.$(date +%Y-%m-%d)
```
