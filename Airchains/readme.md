<h1 align="center"> Airchain </h1>


![image](https://github.com/molla202/Airchain/assets/91562185/64b9e7f3-4739-4774-b421-635e224dcd4f)




 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Airchain Website](https://www.airchains.io)<br>
 * [Blockchain Explorer](https://testnet.airchains.io)<br>
 * [Discord](https://discord.gg/jsy8ZqrD)<br>
 * [Twitter](https://twitter.com/airchains_io)<br>

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

### 🚧Go kurulumu
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
### 🚧Dosyaları çekelim
```
wget https://github.com/airchains-network/junction/releases/download/v0.1.0/junctiond
chmod +x junctiond
```
```
mkdir -p $HOME/.junction/cosmovisor/genesis/bin
mv $HOME/junctiond $HOME/.junction/cosmovisor/genesis/bin
```
```
sudo ln -s $HOME/.junction/cosmovisor/genesis $HOME/.junction/cosmovisor/current -f
sudo ln -s $HOME/.junction/cosmovisor/current/bin/junctiond /usr/local/bin/junctiond -f
```
### 🚧Cosmovisor kuralım
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/junctiond.service > /dev/null << EOF
[Unit]
Description=junction node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.junction"
Environment="DAEMON_NAME=junctiond"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.junction/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
### 🚧Etkinleştirelim
```
sudo systemctl daemon-reload
sudo systemctl enable junctiond
```
### 🚧İnit
```
junctiond init node-adi-yaz --chain-id junction
```
### 🚧Genesis ve addrbook
```
curl -L https://raw.githubusercontent.com/molla202/Airchain/main/addrbook.json > $HOME/.junction/config/addrbook.json
curl -L https://raw.githubusercontent.com/molla202/Airchain/main/genesis.json > $HOME/.junction/config/genesis.json
```
### 🚧Port
```
echo "export J_PORT="63"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:1317%:${J_PORT}317%g;
s%:8080%:${J_PORT}080%g;
s%:9090%:${J_PORT}090%g;
s%:9091%:${J_PORT}091%g;
s%:8545%:${J_PORT}545%g;
s%:8546%:${J_PORT}546%g;
s%:6065%:${J_PORT}065%g" $HOME/.junction/config/app.toml
```
### Port
```
sed -i.bak -e "s%:26658%:${J_PORT}658%g;
s%:26657%:${J_PORT}657%g;
s%:6060%:${J_PORT}060%g;
s%:26656%:${J_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${J_PORT}656\"%;
s%:26660%:${J_PORT}660%g" $HOME/.junction/config/config.toml
```
### 🚧Seed ve Peer
```
peers="1918bd71bc764c71456d10483f754884223959a5@35.240.206.208:26656,48887cbb310bb854d7f9da8d5687cbfca02b9968@35.200.245.190:26656,de2e7251667dee5de5eed98e54a58749fadd23d8@34.22.237.85:26656,8b72b2f2e027f8a736e36b2350f6897a5e9bfeaa@131.153.232.69:26656,d92c7efcb453ba2edab6d80ad6e3b692e3a7e4f5@49.13.120.225:26656,5c5989b5dee8cff0b379c4f7273eac3091c3137b@57.128.74.22:56256,e09fa8cc6b06b99d07560b6c33443023e6a3b9c6@65.21.131.187:26656,0305205b9c2c76557381ed71ac23244558a51099@162.55.65.162:26656,3e5f3247d41d2c3ceeef0987f836e9b29068a3e9@168.119.31.198:56256,086d19f4d7542666c8b0cac703f78d4a8d4ec528@135.148.232.105:26656,eb4d2c546be8d2dc62d41ff5e98ef4ee96d2ff29@46.250.233.5:26656,7d6694fb464a9c9761992f695e6ba1d334403986@164.90.228.66:26656,b2e9bebc16bc35e16573269beba67ffea5932e13@95.111.239.250:26656,23152e91e3bd642bef6508c8d6bd1dbedccf9e56@95.111.237.24:26656,c1e9d12d80ec74b8ddbabdec9e0dad71337ba43f@135.181.82.176:26656,3b429f2c994fa76f9443e517fd8b72dcf60e6590@37.27.11.132:26656,84b6ccf69680c9459b3b78ca4ba80313fa9b315a@159.69.208.30:26656,e78a440c57576f3743e6aa9db00438462980927e@5.161.199.115:26656,49fb1316b22c71e455720af15dd552dafb9af39a@5.189.151.175:26656,e831fa909cce0d1807cfcf417e28e782530f5c94@161.97.66.254:26666,db38d672f66df4de01b26e1fa97e1632fbfb1bdf@173.249.57.190:26656,08a0014125bded5fe76b9dc3275b0a58b6841b43@116.203.184.36:26656,6025c1523ad0cd6926ef277cfcf46d82ebb43c21@116.203.24.46:26656,fed2e80e159a23bf9f71f980b501c2304cec2f6d@185.194.216.61:17656,1ad9bdeac0b06f585a9c64261d0705c4cbfd28e7@144.91.99.93:26656,a6384bd23bd728ffa9a8452b12fc865dadf51672@81.200.154.160:26656,5b31fdf605645b44ad615c8b79b1550540895fe5@35.214.147.230:26656,6a3a13d7631823eb6dcd00882243c913c819a125@38.242.196.100:26656,42897b24165bb42b23f1052792f673165b2b0b21@141.95.151.163:26656,c97c7a9c11cf3cb059ce89c36f7ff219daa3ada4@195.26.246.26:26656,7d162ef2392d25720d7cdb2cfdf2ccf146e32bac@49.13.234.149:26656,5a161464aa73571f1b7e22204bcf3bdb6fb71f3b@195.26.241.184:26656,bff7c802021ed3b4aaf222da9d42280bfc5dad88@65.109.139.181:26656,c284cbda3ab197001136c39c9df8e45af2038513@34.93.143.222:26656,449297568d9d6d4aa51a93f7a1b1e92e1ec38619@65.108.242.9:26656,3e182e463425dfa6d4cef83f4bdd67c98c36eba3@195.26.243.208:47656,beec52199d4b28cab6fc3b2f2a2718c6667ac46a@37.27.19.95:26656,226b9c42e81cddd185d435348cd89f87fee37279@135.181.42.46:26656,479b63df84e247c55e80cccd9abbf7100a334fcc@65.108.156.83:26656,976a0fe0a0fa205478beb66addaae3842907c3f6@37.27.48.77:32656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.junction/config/config.toml
seeds="2d1ea4833843cc1433e3c44e69e297f357d2d8bd@5.78.118.106:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.junction/config/config.toml

```

### 🚧Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.junction/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.junction/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.junction/config/app.toml
```
### 🚧Gas ve index ayarı
```
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.025amf"|g' $HOME/.junction/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.junction/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.junction/config/config.toml
```
### Snap 
```
mantrachaind tendermint unsafe-reset-all --home $HOME/.mantrachain
if http://37.120.189.81/airchain_testnet/air_snap.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl -L http://37.120.189.81/airchain_testnet/air_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.junction
    else
  echo no have snap
fi
```
### 🚧Başlatalım
```
sudo systemctl daemon-reload && sudo systemctl start junctiond && sudo journalctl -u junctiond -f --no-hostname -o cat
```
### Log
```
sudo journalctl -u junctiond -f --no-hostname -o cat
```
### Cüzdan olusturma
```
junctiond keys add cüzdan-adi-yaz
```
### Cüzdan import
```
junctiond keys add cüzdan-adi-yaz --recover
```
### Validator oluştur
Not: pubkey alalım
```
junctiond comet show-validator
```

```
nano $HOME/validator.json
```
Not: alttaki kodu düzenleyin sonra üsteki kodu yazıp düzenlediğinizi içine yapıstırın. eğer vali kurarken hata alırsanız. size önerdiği kodu tekrar içine yapıstırıp düzenleyin tabi eskilerini silerek :D
```
{
	"pubkey": <validator-pub-key>,
	"amount": "1000000amf",
	"moniker": "<validator-name>",
	"identity": "optional identity signature (ex. UPort or Keybase)",
	"website": "validator's (optional) website",
	"security": "validator's (optional) security contact email",
	"details": "validator's (optional) details",
	"commission-rate": "0.1",
	"commission-max-rate": "0.2",
	"commission-max-change-rate": "0.01",
	"min-self-delegation": "1"
}
```
```
junctiond tx staking create-validator $HOME/validator.json --from cüzdan-adi --chain-id junction --fees 5000amf
```







