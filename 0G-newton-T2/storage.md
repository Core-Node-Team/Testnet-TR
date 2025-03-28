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
cd
systemctl stop zgsd
mv 0g-storage-node 0g-storage-nodeydk4
```
```
git clone https://github.com/0glabs/0g-storage-node.git
cd $HOME/0g-storage-node
git fetch --all --tags
git checkout v0.8.7
```
### Build edelim
👉Not: uzun sürer.
```
git submodule update --init
cargo build --release
```
```
$HOME/0g-storage-node/target/release/zgs_node --version
```

👉NOT: servise private keyi yazın. rpc kendinizinkini kullanıcaksanız değiştirin.

👉NOT: 2 çeşit çalıştırma yapmışlar turbolu versiyonuda var. `--config config-testnet-standard.toml`  YERİNE `--config config-testnet-turbo.toml` yazmanız yeterli.

## Servisi kuralım
```
sudo tee /etc/systemd/system/zgsd.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=root
WorkingDirectory=$HOME/0g-storage-node/run
ExecStart=$HOME/0g-storage-node/target/release/zgs_node --config config-testnet-standard.toml --miner-key Private-key-yaz --blockchain-rpc-endpoint https://evmrpc-testnet.0g.ai/
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
```
curl -X POST http://localhost:5678 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"zgs_getStatus","params":[],"id":1}'  | jq
```


### 👉 Güncelleme


- öncelikle durdurduktan sonra ayarlarınızın olduğu config.toml dosyasının yedeğini alalım. (nerde run klasörünün içinde)
- güncelleme ile birlikte artık ayarlayacağımız tek şey miner key ve rpc onuda zaten serviste belirtiğimiz için aslında extra artık ayar yapmıyoruz.(ister kendi rpclerini isterseniz değiştirip size air rpcyi kullanabilirsiniz)
- Ancak yeni contratlr olduğu için hata verebilir. bu yüzden bazı data dosyalarını silmek yada isim değiştirerek deneyebilirsiniz.  run klasörünün içinde aşağıdaki gibi bende yeni sürümde eski config dosya ile hata verdi. çokda irdelemedim yeni contrattan çalışsın :D

![image](https://github.com/user-attachments/assets/ae523437-7f93-4ad3-9b8f-ca75646c531d)



👉 NOT: kısa özet geçersek yedek alıyoruz. duruduruyoruz güncelliyoruz. dosya isimlerini değiştiriyoruz servisi düzeltip giriyoruz ve başlatıyoruz.( sorun yoksa değişiklik yapılan dosyalarıda silebilirsiniz daha sonra emin olunca)

```
systemctl stop zgsd
```

```
cd
systemctl stop zgsd
cp -r 0g-storage-node 0g-storage-nodeydk060
cd $HOME/0g-storage-node
git fetch --all --tags
git checkout v0.8.7
git submodule update --init
cargo build --release
```

```
sudo tee /etc/systemd/system/zgsd.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=root
WorkingDirectory=$HOME/0g-storage-node/run
ExecStart=$HOME/0g-storage-node/target/release/zgs_node --config config-testnet-standard.toml --miner-key Private-key-yaz --blockchain-rpc-endpoint https://evmrpc-testnet.0g.ai/
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
```
curl -X POST http://localhost:5678 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"zgs_getStatus","params":[],"id":1}'  | jq
```
