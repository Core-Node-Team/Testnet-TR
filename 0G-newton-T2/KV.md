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
sudo apt install curl git wget htop tmux build-essential jq make pkg-config libssl-dev cmake lz4 gcc unzip -y
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

### 4. set vars
NOT: storage nodu için 2 ip port yazıyoruz böle virgülle > http://STORAGE_NODE_IP:5678,http://STORAGE_NODE_IP:5679

NOT: burayada json rpc soracak  normal nodunuzun ipsi > http://NODE_IP:56545

   ```bash
   read -p "Enter json-rpc: " BLOCKCHAIN_RPC_ENDPOINT && echo "Current json-rpc: $BLOCKCHAIN_RPC_ENDPOINT" &&
   read -p "Enter storage node urls: " ZGS_NODE && echo "Current storage node urls: $ZGS_NODE" &&
   echo 'export ZGS_LOG_SYNC_BLOCK="802"' >> ~/.bash_profile
   echo "export ZGS_NODE=\"$ZGS_NODE\"" >> ~/.bash_profile
   echo 'export LOG_CONTRACT_ADDRESS="0x8873cc79c5b3b5666535C825205C9a128B1D75F1"' >> ~/.bash_profile
   echo 'export MINE_CONTRACT="0x85F6722319538A805ED5733c5F4882d96F1C7384"' >> ~/.bash_profile
   echo "export BLOCKCHAIN_RPC_ENDPOINT=\"$BLOCKCHAIN_RPC_ENDPOINT\"" >> ~/.bash_profile
   ```
```
   source ~/.bash_profile
   ```
```
   echo -e "\n\033[31mCHECK YOUR STORAGE KV VARIABLES\033[0m\n\nZGS_NODE: $ZGS_NODE\nLOG_CONTRACT_ADDRESS: $LOG_CONTRACT_ADDRESS\nMINE_CONTRACT: $MINE_CONTRACT\nZGS_LOG_SYNC_BLOCK: $ZGS_LOG_SYNC_BLOCK\nBLOCKCHAIN_RPC_ENDPOINT: $BLOCKCHAIN_RPC_ENDPOINT\n\n" "\033[3m\"Bu Bir Amme Hizmetidir\" - CoreNode Community\033[0m"
   ```

### 5. Dosyaları çekelim
   ```bash
   cd $HOME
   git clone https://github.com/0glabs/0g-storage-kv.git
   cd $HOME/0g-storage-kv
   git fetch
   git checkout tags/v1.1.0-testnet
   git submodule update --init
   sudo apt install cargo
   ```
### 5-2. Kuralım
   ```bash
   cargo build --release
   ```

### 6. config dosyası olusturalım
   ```bash
   cp /$HOME/0g-storage-kv/run/config_example.toml /$HOME/0g-storage-kv/run/config.toml
   ```

### 7. config dosyası güncelleyelim
   ```bash
   sed -i '
   s|^\s*#\?\s*rpc_enabled\s*=.*|rpc_enabled = true|
   s|^\s*#\?\s*rpc_listen_address\s*=.*|rpc_listen_address = "0.0.0.0:6789"|
   s|^\s*#\?\s*db_dir\s*=.*|db_dir = "db"|
   s|^\s*#\?\s*kv_db_dir\s*=.*|kv_db_dir = "kv.DB"|
   s|^\s*#\?\s*log_config_file\s*=.*|log_config_file = "log_config"|
   s|^\s*#\?\s*log_contract_address\s*=.*|log_contract_address = "'"$LOG_CONTRACT_ADDRESS"'"|
   s|^\s*#\?\s*zgs_node_urls\s*=.*|zgs_node_urls = "'"$ZGS_NODE"'"|
   s|^\s*#\?\s*mine_contract_address\s*=.*|mine_contract_address = "'"$MINE_CONTRACT"'"|
   s|^\s*#\?\s*log_sync_start_block_number\s*=.*|log_sync_start_block_number = '"$ZGS_LOG_SYNC_BLOCK"'|
   s|^\s*#\?\s*blockchain_rpc_endpoint\s*=.*|blockchain_rpc_endpoint = "'"$BLOCKCHAIN_RPC_ENDPOINT"'"|
   ' $HOME/0g-storage-kv/run/config.toml
   ```

### 8. servis olusturalım
   ```bash
   sudo tee /etc/systemd/system/zgskv.service > /dev/null <<EOF
   [Unit]
   Description=ZGS KV
   After=network.target
   
   [Service]
   User=$USER
   WorkingDirectory=$HOME/0g-storage-kv/run
   ExecStart=$HOME/0g-storage-kv/target/release/zgs_kv --config $HOME/0g-storage-kv/run/config.toml
   Restart=on-failure
   RestartSec=10
   LimitNOFILE=65535
   
   [Install]
   WantedBy=multi-user.target
   EOF
   ```

### 9. baslatalım
   ```bash
   sudo systemctl daemon-reload && \
   sudo systemctl enable zgskv && \
   sudo systemctl start zgskv && \
   sudo systemctl status zgskv
   ```

### 10. loglara bakalım
   ```bash
   sudo journalctl -u zgskv -fn 100 -o cat
   ```
![image](https://github.com/user-attachments/assets/61b02b54-5311-4660-8226-664874b0a6bd)


### silmek tamamen
   ```bash
   sudo systemctl stop zgskv
   sudo systemctl disable zgskv
   sudo rm -rf /etc/systemd/system/zgskv.service
   sudo rm -rf 0g-storage-kv
   ```
