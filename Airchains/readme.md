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
peers="47f61921b54a652ca5241e2a7fc4ed8663091e89@airchains-testnet-peer.itrocket.net:19656,e78a440c57576f3743e6aa9db00438462980927e@5.161.199.115:26656,747b20b00224128bb3a3022cfa557fa105a8e41d@84.247.140.127:43456,f786dcc80601ddd33ba98c609795083ba418d740@158.220.119.11:43456,0b1159b05e940a611b275fe0006070439e5b6e69@[2a03:cfc0:8000:13::b910:277f]:13756,c8f6b1a795a6d9cd2ec39faf277163a9711fc81b@38.242.194.19:43456,552d2a5c3d9889444f123d740a20237c89711109@109.199.96.143:43456,cc27f4e54a78b950adaf46e5413f92f5d53d2212@209.126.86.186:43456,f5b69a02abeb3340ccd266f049ed6aabc7c0ea88@94.72.114.150:43456,43ab9af9fabe523a0a8794ae779100c50d1383e6@5.189.142.177:17656,db38d672f66df4de01b26e1fa97e1632fbfb1bdf@173.249.57.190:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.junction/config/config.toml
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
junctiond tendermint unsafe-reset-all --home $HOME/.junction
curl -L http://37.120.189.81/airchain_testnet/air_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.junction
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
junctiond tx staking create-validator $HOME/validator.json --from cüzdan-adi --chain-id junction --fees 5000amf --node http://localhost:63657
```
### Kendinize stake
```
junctiond tx staking delegate $(junctiond keys show cüzdan-adi-yaz --bech val -a) 1000000amf --from cüzdan-adi-yaz --chain-id junction --fees 5000amf --node=http://localhost:63657 -y
```
### Jailden çıkma
```
junctiond tx slashing unjail --from cüzdan-adi-yaz --chain-id junction --fees 5000amf --node=http://localhost:63657 -y
```





