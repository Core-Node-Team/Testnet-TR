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
| Storage	| - GB SSD |

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make pkg-config libssl-dev lz4 gcc unzip protobuf-compiler -y
sudo apt install libssl-dev
sudo apt install pkg-config
sudo apt install protobuf-compiler
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
git clone https://github.com/0glabs/0g-da-node.git
```
```
cd && cd 0g-da-node
```
```
cargo build --release
```
```
cd dev_support
./download_params.sh
```
```
sudo cp -R /root/0g-da-node/dev_support/params /root/0g-da-node/target/release
```
### BLS key olusturalım
```
cd
cd 0g-da-node
```
```
cargo run --bin key-gen
```
NOT: bi key cıktısı vericek kaydedin..
### Servis oluşturalım
```
sudo tee /etc/systemd/system/da.service > /dev/null <<EOF
[Unit]
Description=DA Node
After=network.target

[Service]
User=root
WorkingDirectory=$HOME/0g-da-node/target/release
ExecStart=$HOME/0g-da-node/target/release/server --config $HOME/0g-da-node/config.toml
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
### Düzenleme
```
nano $HOME/0g-da-node/config.toml
```
NOT: altakini düzenleyip içine yapıstıralım ctrl xy enterla kaydedip çıkalım
```
log_level = "info"

data_path = "./db/"

# path to downloaded params folder
encoder_params_dir = "params/" 

# grpc server listen address
grpc_listen_address = "0.0.0.0:34000"
# chain eth rpc endpoint
eth_rpc_endpoint = "http://ognode-sunucu-ipsi-yaz:56545"
# public grpc service socket address to register in DA contract
# ip:34000 (keep same port as the grpc listen address)
# or if you have dns, fill your dns
socket_address = "sunucuipsiyaz:34000"

# data availability contract to interact with
da_entrance_address = "0xDFC8B84e3C98e8b550c7FEF00BCB2d8742d80a69"
# deployed block number of da entrance contract
start_block_number = 802

# signer BLS private key
signer_bls_private_key = "bls key yaz"
# signer eth account private key
signer_eth_private_key = "private key yaz"

# whether to enable data availability sampling
enable_das = "false"
```

![image](https://github.com/user-attachments/assets/2ab7c0f5-9463-4ea5-ab28-c231011853da)

### Başlatalım
```
sudo systemctl daemon-reload && \
sudo systemctl enable da && \
sudo systemctl start da
```
```
sudo journalctl -u da -f -o cat
```
