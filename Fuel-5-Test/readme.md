
![image](https://github.com/molla202/Fuel-5-Test/assets/91562185/78fdb772-86c3-4e90-a17d-57edcd51e01c)



🌟 [Fuel Twitter](https://twitter.com/fuel_network)

🌟 [Fuel Discord](https://discord.gg/fuelnetwork)

🌟 [Fuel Site](https://fuel.network/)

🌟 [Fuel Doc](https://docs.fuel.network/)

🔥 [CoreNode Telegram](https://t.me/corenode)

🔥 [CoreNode Twitter](https://twitter.com/corenodehq)

💬 Sorularınız için yukarıdaki adreslerden ulaşabilirsiniz.


 ## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️ CPU |	2+ |
| ✔️ RAM	| 2+ GB |
| ✔️ Storage	| 80GB+ SSD |

## 💬 Herhangi bir teşvik bulunmamaktadır.

### 🚧 Update ve güncellemeler
```
sudo apt update && sudo apt upgrade -y
sudo apt install screen curl tar wget jq build-essential make clang pkg-config libssl-dev cmake gcc -y
```
```
ufw allow 22
ufw allow 4000
ufw allow 30333
```
### 🚧Rust kuruyoruz.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
👉NOt: 1 diyoruz.
```
source ~/.profile
```
```
source ~/.cargo/env
```
### 🚧Fuel kurulum
👉NOt: bişi sorucak y yes deyin
```
curl https://install.fuel.network | sh
```
```
source /root/.bashrc
```
### 🚧Key oluşturma
```
fuel-core-keygen new --key-type peering
```
👉Not: çıkan çıktıyı kaydedin. bir tuşa basarak geçin..

### 🚧Varyasyon atayalım
👉Not: bize burda sepolia RPC lazım. https://app.infura.io/ sitesinden ekliyoruz... rpc nasıl alınırla ilgili daha önce örnek vardı biz sepolia alıcaz unutmayın. örnek [BURADA](https://github.com/Core-Node-Team/Testnet-TR/blob/main/Mangata/RPC-Alma.md)
```
Nodeadı=Adınızı yazınız
RPCsep=Sepolia rpcnizi yazınız
PRivkey=yukarıda çıktı aldığımzda kaydedin dediğimiz kısımda yazıor."secret": bele başlıyor.
```
👉ÖRNEK:
```
Nodeadı=CoreNode
RPCsep=https://sepolia.infura.io/v3/hebele-hübele-api
PRivkey=7e4868e36e890dsdsadadbb7f246b74bacc9bcfjhkıadhsakgdoasdjasdhasdhhaoıdasdashoıdh
```
### 🚧Gerekli dosyaları çekelim
```
mkdir -p /root/fuel-test
```
```
wget -O /root/fuel-test/chainConfig.json http://37.120.189.81/fuel/chainConfig.json
```
### 🚧Servis oluşturalım

```
sudo tee /etc/systemd/system/fueld.service > /dev/null << EOF
[Unit]
Description=Fuel Service
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
Type=simple
Restart=always
RestartSec=120
ExecStart=/root/.fuelup/bin/fuel-core run \
--service-name $Nodeadı \
--keypair $PRivkey \
--relayer $RPCsep \
--ip 0.0.0.0 \
--port 4000 \
--peering-port 30333 \
--db-path  /root/.fuel_beta5 \
--chain /root/fuel-test/chainConfig.json \
--utxo-validation \
--poa-instant false \
--enable-p2p \
--min-gas-price 1 \
--max-block-size 18874368  \
--max-transmit-size 18874368 \
--reserved-nodes /dns4/p2p-beta-5.fuel.network/tcp/30333/p2p/16Uiu2HAmSMqLSibvGCvg8EFLrpnmrXw1GZ2ADX3U2c9ttQSvFtZX,/dns4/p2p-beta-5.fuel.network/tcp/30334/p2p/16Uiu2HAmVUHZ3Yimoh4fBbFqAb3AC4QR1cyo8bUF4qyi8eiUjpVP \
--sync-header-batch-size 100 \
--enable-relayer \
--relayer-v2-listening-contracts 0x557c5cE22F877d975C2cB13D0a961a182d740fD5 \
--relayer-da-deploy-height 4867877 \
--relayer-log-page-size 2000


[Install]
WantedBy=multi-user.target
EOF
```

### 🚧Başlatalım
```
sudo systemctl daemon-relod
sudo systemctl enable fueld
sudo systemctl restart fueld
```
### Loglar
```
journalctl -u fueld -fo cat
```

