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
sudo apt install curl git wget htop tmux build-essential jq make pkg-config libssl-dev lz4 gcc unzip -y
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
👉Not: 1 seçelim
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
git clone -b v0.3.2 https://github.com/0glabs/0g-storage-node.git
```
### Build edelim
👉Not: uzun sürer.
```
cd $HOME/0g-storage-node
git submodule update --init
cargo build --release
```
### varyasyonları atayalım
👉Not: bişi değişmicek
```
export ZGS_LOG_DIR="$HOME/0g-storage-node/run/log"
export ZGS_LOG_CONFIG_FILE="$HOME/0g-storage-node/run/log_config"
export LOG_CONTRACT_ADDRESS="0x8873cc79c5b3b5666535C825205C9a128B1D75F1"
export MINE_CONTRACT="0x85F6722319538A805ED5733c5F4882d96F1C7384"
export ZGS_LOG_SYNC_BLOCK=802
export WATCH_LOOP_WAIT_TIME_MS=1000
```
### 1.private key alalım validator çalışan yerden
👉NOT: bu kısım node çalıştırdığınız sunucudaki cüzdanınızın privatesini almak içindir.
```
0gchaind keys unsafe-export-eth-key Cüzdan-adını-yaz
```
👉Not: aynı zamanada validator çalıştırdığınız sunucuda port açmak gerek nasıl `nano /root/.0gchain/config/app.toml` kodunu girin `56545` pornun başında şöledir `127.0.0.1:56545` bunu `0.0.0.0:56545` yapıyoruz `ctrl xy enterla kaydet çık`. sonra `systemctl daemon-reload && systemctl restart 0gchaind` girelim. sonra port sorgulama koduyla `sudo lsof -i -P -n | grep LISTEN` bakalım biraz bekledikten sonra `56545` portu ogchainde `*:56545` gibi gorunecek tamamsın.

👉Not: üsteki kısım nodunuzun vali olan sunucusunda altaki kısım storage kurulu olan yerde düzenlenip girilcek private-yaz yerine yaz
```
sed -i 's|^miner_key = ""|miner_key = "'"private-yaz"'"|' $HOME/0g-storage-node/run/config.toml
```
### Ayarlamaları yapalım
```
ZGS_IP=$(wget -qO- eth0.me)
```
```
sed -i '
s|# network_dir = "network"|network_dir = "network"|g
s|# network_enr_tcp_port = 1234|network_enr_tcp_port = 1234|g
s|# network_enr_udp_port = 1234|network_enr_udp_port = 1234|g
s|# network_libp2p_port = 1234|network_libp2p_port = 1234|g
s|# network_discovery_port = 1234|network_discovery_port = 1234|g
s|# rpc_enabled = true|rpc_enabled = true|g
s|# db_dir = "db"|db_dir = "db"|g
s|# log_config_file = "log_config"|log_config_file = "log_config"|g
s|# log_directory = "log"|log_directory = "log"|g
s|# watch_loop_wait_time_ms = 500|watch_loop_wait_time_ms = 15000|g
s|network_enr_address = ""|network_enr_address = "'"$ZGS_IP"'"|g
' $HOME/0g-storage-node/run/config.toml
```
```
sed -i '
s|^log_sync_start_block_number = .*|log_sync_start_block_number = '"$ZGS_LOG_SYNC_BLOCK"'|g
s|^log_config_file = .*|log_config_file = "'"$ZGS_LOG_CONFIG_FILE"'"|g
s|^log_directory = .*|log_directory = "'"$ZGS_LOG_DIR"'"|g
s|^mine_contract_address = .*|mine_contract_address = "'"$MINE_CONTRACT"'"|g
s|^log_contract_address = .*|log_contract_address = "'"$LOG_CONTRACT_ADDRESS"'"|g
s|^watch_loop_wait_time_ms = .*|watch_loop_wait_time_ms = '"$WATCH_LOOP_WAIT_TIME_MS"'|g
' $HOME/0g-storage-node/run/config.toml
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
### Eğer port 8545 farklı ise değişecek mesela bizim port 56545 ozaman 56545 yazacağız
👉NOT: aynı sunucuda çalıştırıyorsanı elleşcek yer yok
```
JSON_PORT=8545
```
```
BLOCKCHAIN_RPC_ENDPOINT="http://$(wget -qO- eth0.me):$JSON_PORT"
sed -i 's|^blockchain_rpc_endpoint = ".*"|blockchain_rpc_endpoint = "'"$BLOCKCHAIN_RPC_ENDPOINT"'"|' $HOME/0g-storage-node/run/config.toml
echo "export BLOCKCHAIN_RPC_ENDPOINT=\"$BLOCKCHAIN_RPC_ENDPOINT\"" >> ~/.bash_profile
echo "BLOCKCHAIN_RPC_ENDPOINT: $BLOCKCHAIN_RPC_ENDPOINT"
```
### Rpc oalrak kullanılacak og node aynı sunucuda değil ise bu
👉NOT: buraya ip yaz yazan yere og nodun kurulu olduğu sunucu ipsi yazılacak. tabi sunucunuzda 8545 yerine yada hangi portta ise o portuda ufw allow PORT yazarak açın. portuda yazıcanız altaki ilk satırda
```
BLOCKCHAIN_RPC_ENDPOINT="http://buraya-ip-yaz:PORT"
sed -i 's|^blockchain_rpc_endpoint = ".*"|blockchain_rpc_endpoint = "'"$BLOCKCHAIN_RPC_ENDPOINT"'"|' $HOME/0g-storage-node/run/config.toml
echo "export BLOCKCHAIN_RPC_ENDPOINT=\"$BLOCKCHAIN_RPC_ENDPOINT\"" >> ~/.bash_profile
echo "BLOCKCHAIN_RPC_ENDPOINT: $BLOCKCHAIN_RPC_ENDPOINT"
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
tail -f -n 20 "$ZGS_LOG_DIR/$(ls -Art $ZGS_LOG_DIR | tail -n 1)"
```
YADA
```
tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)
```
Direk eşleşmeyi tx üzerinden takip etmek için
```
tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d) | grep tx_seq
```
