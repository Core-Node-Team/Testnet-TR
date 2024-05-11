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
peers="58a9487bdccb32f19a6c1b8eef587600c45ec34e@65.108.72.253:19656,40358f86068ce8a1f50846dcc180d1b053800fad@213.130.141.113:43456,575e98598e9813a26576759c7ef70fd38d2516a4@65.109.113.251:15656,aeaf101d54d47f6c99b4755983b64e8504f6132d@65.21.202.124:28656,626e61e17710deded49dfdb35fc81d2966c23684@207.244.250.211:43456,baaf8bc7b7bd8afde6a0f5bd6b51ea43d11dfb69@109.123.253.194:43456,ded39754d1df6bb7c3c748dab8ead58d7b5ccb7f@161.97.125.154:43456,4f84487af5e8a86baa7e4e428ca7156ae5bc3ab7@148.251.235.130:24656,ef5cc77b61ac1f8ec1724201de296216bb21be70@152.53.35.92:43456,e049e45e6806eb725cb6cdcca34e18430bfcd61c@38.242.223.240:43456,b82ac298366a89db5ab9e4e4d3cc9849a7a3ec9a@65.109.30.150:47656,70807903180371f9cd3a10a63b025d15c6605125@195.26.255.109:25556,e4d5ae4b3488c7d02d500d1755a1bd8c4d2a6e0c@161.97.125.152:43456,6265418e025e1ac43c8e0cab04aee95942e1ad5c@94.72.100.234:38656,fb00754dfca0882bca348190cf551c600ea359e9@195.26.243.208:26656,005613e82207786c6cf57a9b13e36b7b48883a11@37.27.37.250:26656,df2a56a208821492bd3d04dd2e91672657c79325@158.220.126.137:27656,db4d6530e66b63d811a19d65610e5cd32e4c06d1@174.138.89.139:26656,d4da1eed4eccb4cf321e29c51b0009099bc37639@86.48.0.13:43456,180fd5343226141a7c036ac9a4ee1b22ca345030@194.163.152.2:43456,82af620ee9eeb2d2902ae66188eb4aa163ca8562@135.181.35.159:63656,d64670be24be087c6782a17b548a1579ef3b9bf4@213.199.49.222:26656,6e412a6daba08614f9c04248fcf29e20fc41a92c@161.97.125.153:43456,4039ed4d7d6185430fc81964f6525aaea5bc8235@158.220.124.182:43456,bcd4aa8f1d022af244c8af4dba98a5e14c05a229@185.250.37.11:43456,50d9887ebf0da0c55ca5d3957ce1dcbf682d0a58@35.201.179.244:43456,f315edae9ff8543c50e764627a6495dfdaceb3bb@37.60.224.165:63656,c996c86238d486c8e611d2d358d4d8d8f4fe773f@156.67.29.102:26656,c2e70f94ed3f7fa027ffad7f051c4d4688be1ee6@195.26.255.211:10056,7b6124a87c22dabf609e634b9903853f4b138c2c@118.158.252.167:43456,fcbeb77b49bf0570f657083ab075aff3195c7baa@65.108.74.113:63656,6a3a13d7631823eb6dcd00882243c913c819a125@38.242.196.100:26656,50bbe1817db21ef3eb7a03bb18398a114a033d60@5.252.53.247:26656,264493e01774cccdb9baabee4af7146acbec67f2@65.21.193.80:63656,8c2fab16c566a6d94386af3e0afe35e76201cdbb@162.55.135.238:43456,a075e9b57f25f06d32d3885adfc968d932e2c028@158.220.93.206:43456,268c40d80ce63bb6022f81cddba357a61cb9a9fb@135.181.60.240:12656,8a93e10a54205c84dadafa4a3345cf37523fcdb0@37.27.28.44:26656,f82affdd395fac532cfee5acf6ce910e9475b2a5@158.220.90.74:43456,e3e75c5d96309bcd0fefc9bc634598a20d5177c7@194.163.168.41:63656,52ef8683f4484c2f30423db415c807335e481094@149.102.133.39:43456,e78a440c57576f3743e6aa9db00438462980927e@5.161.199.115:26656,ed0fb297a9c8475bb4afacafdea5cf70aa2792d6@65.109.115.15:63656,e3f6f7701541bd2ea183a34b061e33bfaf69ae3d@144.91.69.202:63656,613a65fe67918a5912f0cc22ef535ed1a8f0e824@65.109.112.148:4476,a1675e9aa8466d2d484b469f587df544da021f24@94.72.114.46:43456,b87d19d4df13b015bc0b3fe817d22c0ea311538f@94.72.105.63:26656,03e597ca88c7693dd4001ebf1c6c64259d0e1a91@95.217.214.245:26656,9edebd34e1e9ea8e9efebd6e60038ce424dc4341@62.169.31.211:43456"
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





