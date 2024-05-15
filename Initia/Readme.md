<h1 align="center"> INITIA


![image](https://github.com/molla202/pokemon/assets/91562185/c0d15ba5-72dd-4dcf-9766-3a4e72e42627)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://twitter.com/0G_labs)<br>
 * [Discord](https://discord.gg/initia)<br>

## FAUCET 

https://faucet.testnet.initia.xyz/

## Explorer

https://scan.testnet.initia.xyz/initiation-1

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |
| System	| Ubuntu 22.04 OR 20.04 |

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

### 🚧Dosyaları çekelim
```
git clone https://github.com/initia-labs/initia
cd initia
git checkout v0.2.14
make build
```

```
mkdir -p $HOME/.initia/cosmovisor/genesis/bin
mv /root/initia/build/initiad $HOME/.initia/cosmovisor/genesis/bin/
```
### 🚧System link
```
sudo ln -s $HOME/.initia/cosmovisor/genesis $HOME/.initia/cosmovisor/current -f
sudo ln -s $HOME/.initia/cosmovisor/current/bin/initiad /usr/local/bin/initiad -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/initiad.service > /dev/null << EOF
[Unit]
Description=initia node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.initia"
Environment="DAEMON_NAME=initiad"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.initia/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable initiad.service
```
### 🚧İnit
NOT: node adınızı yazınız.
```
initiad config set client chain-id initiation-1
initiad config set client node tcp://localhost:15657
initiad config set client keyring-backend test
```
```
initiad init NODE-ADI-YAZ --chain-id initiation-1
```
### 🚧Genesis addrbook
```
rm ~/.initia/config/genesis.json
curl -Ls https://raw.githubusercontent.com/molla202/pokemon/main/genesis.json > $HOME/.initia/config/genesis.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Initia/addrbook.json > $HOME/.initia/config/addrbook.json
```
### 🚧Port Ayarları
```
echo "export N_PORT="15"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:1317%:${N_PORT}317%g;
s%:8080%:${N_PORT}080%g;
s%:9090%:${N_PORT}090%g;
s%:9091%:${N_PORT}091%g;
s%:8545%:${N_PORT}545%g;
s%:8546%:${N_PORT}546%g;
s%:6065%:${N_PORT}065%g" $HOME/.initia/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${N_PORT}658%g;
s%:26657%:${N_PORT}657%g;
s%:6060%:${N_PORT}060%g;
s%:26656%:${N_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${N_PORT}656\"%;
s%:26660%:${N_PORT}660%g" $HOME/.initia/config/config.toml
```
### 🚧Seed
```
PEERS="a63a6f6eae66b5dce57f5c568cdb0a79923a4e18@peer-initia-testnet.trusted-point.com:26628,439fe02b731d7f99a62e44ac5b2e1b02353ca631@38.242.251.179:39656,4db605b6f399a173cfc30e843a7d6a10cd3222a3@158.220.86.6:17956,fd14410d3d6ba362a20d47c02e077da86017cadf@65.21.244.157:17956,a8638b4701f2d11e9269dfd4c2ed0509bd7b12d9@194.163.191.117:39656,0ce5a28686d961d0f1315069c03adb74c6fccc80@37.60.244.91:24556,de31968f3b35942b5a1123998ff0c4ebd3c3aae5@88.99.193.146:26656,f396faca04598721481e714dcb0e3c8ed05a406c@49.12.209.114:15656,fd06e3e5f03b31757ee2ce78d0bf85bb1c71a2d9@65.109.166.136:26656,0d5b90a3b620a7e602f099eb4da99fc03995874e@165.22.245.86:17956,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,7033bed7fa79360e24d5d0cf2f5fee8a683766a9@154.26.129.223:17956,1376a7400ee5400e226ebab384ad89de408163dc@62.171.179.87:13656,23251217584bc066c8027cc735ca1b2893896178@185.197.251.195:17956,277ae7258c9ac789262ef125cfdbf1c02958510a@37.27.71.199:22656,32fece76b6d278672fb73059764f5d6f77086f3a@148.251.3.125:19656,c612c1c6ad4a59fb62a31428782921591e8bb684@42.117.19.109:10656,fa69efe26762f987a1e1eaf4ea053b35380838dc@80.65.211.232:17956,0d6437ca9242b5878f6c784b88e918ba12f12c08@89.58.63.240:53456,f24e92c2b15ea8f212ec63ebae5451d8fcc7da8b@81.0.248.152:39656,ba053d26fe5c30842ddcc2c34c9893d78204ced0@157.90.154.36:17956,32f59b799e6e840fb47b363ba59e45c3519b3a5f@136.243.104.103:24556,5c2a752c9b1952dbed075c56c600c3a79b58c395@195.3.221.9:26686,862d16bec51e4e2751b00605416df94b7440b7f3@49.13.147.156:39656,1813a8de79d48674f184553800122f7bf794cd57@213.199.52.16:26656,a633694e4f10060023b3c8319ae130fa927f706b@207.180.251.85:17956,22c876f711032026c54d2ccfe81cb2cfe1ec9ac1@37.60.243.170:26656,15a9693fbcdd9d8aea48030be3b520b1d69e8d66@193.34.213.228:14656,98f0f8e9209aa0a8abad39b94b0d2663a3be24ec@95.216.70.202:26656,c2a36ef8b4aaef3acc7d7cbfd77d10cf4cedaa3d@77.237.235.205:53456,8999ddce339185140913a64c623d0cb2a0e104f5@185.202.223.117:17956,04538a79c786a781345533aecff034379023e661@65.108.126.173:53456,670d532665a0f93ccbba6d132109c207301d6353@194.163.170.113:17956,4d98be9bf94c8ec06f7bbd96a9b4de507d2035b8@37.60.252.43:39656,7d097908682ef4f4e168f2136da2612ec43da27c@85.215.181.21:26656,7f194243f4d9ffbe15412fc5a11eec5c914c9300@167.86.114.207:17956,a3f2bd6fcf79eec06a5f384b3edaf1fe6e4ac9ce@82.208.22.54:17956,6dbb770a4b19f685c1cfe3a16738022eb9ca12e2@101.44.82.135:53456,ef4a25ea7000773cb6094dd5d905686ab7426541@158.220.122.90:14656,2bc4ca9a821b56e5786378a4167c57ef6e0d174f@167.235.200.43:17956,e3ee807b6f4e5a5f76e3e3b73da23a07488f01fb@5.75.170.27:17956,9228bbd89be619dd943e44633585c1657051a7d0@173.212.193.103:17956,cbba1ec1e228e01b31d22864c36fb7039088a5aa@194.163.152.41:53456,ae241bcfd5fffef3173c5bd4c72b0b384db5db88@49.13.213.52:26656,a3660a8b7a0d88b12506787b26952930f1774fc2@65.21.69.53:48656,e3ac92ce5b790c76ce07c5fa3b257d83a517f2f6@178.18.251.146:30656,2692225700832eb9b46c7b3fc6e4dea2ec044a78@34.126.156.141:26656,2a574706e4a1eba0e5e46733c232849778faf93b@84.247.137.184:53456,40d3f977d97d3c02bd5835070cc139f289e774da@168.119.10.134:26313,1f6633bc18eb06b6c0cab97d72c585a6d7a207bc@65.109.59.22:25756,4a988797d8d8473888640b76d7d238b86ce84a2c@23.158.24.168:26656,e3679e68616b2cd66908c460d0371ac3ed7795aa@176.34.17.102:26656,d2a8a00cd5c4431deb899bc39a057b8d8695be9e@138.201.37.195:53456,329227cf8632240914511faa9b43050a34aa863e@43.131.13.84:26656,517c8e70f2a20b8a3179a30fe6eb3ad80c407c07@37.60.231.212:26656,07632ab562028c3394ee8e78823069bfc8de7b4c@37.27.52.25:19656,028999a1696b45863ff84df12ebf2aebc5d40c2d@37.27.48.77:26656,3c44f7dbb473fee6d6e5471f22fa8d8095bd3969@185.219.142.137:53456,8db320e665dbe123af20c4a5c667a17dc146f4d0@51.75.144.149:26656,c424044f3249e73c050a7b45eb6561b52d0db456@158.220.124.183:53456,767fdcfdb0998209834b929c59a2b57d474cc496@207.148.114.112:26656,edcc2c7098c42ee348e50ac2242ff897f51405e9@65.109.34.205:36656,140c332230ac19f118e5882deaf00906a1dba467@185.219.142.119:53456,4eb031b59bd0210481390eefc656c916d47e7872@37.60.248.151:53456,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@178.170.47.171:26656,ffb9874da3e0ead65ad62ac2b569122f085c0774@149.28.134.228:26656" && \
SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.initia/config/config.toml
```
### 🚧Gas pruning ayarı
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $HOME/.initia/config/app.toml
```
### 🚧Pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.initia/config/app.toml
```
### 🚧Snap (opsiyonel)
```
initiad tendermint unsafe-reset-all --home $HOME/.initia
curl -o - -L http://37.120.189.81/initia_testnet/initia_snap.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart initiad
```
### 🚧Log
```
sudo journalctl -u initiad.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
initiad keys add cuzdan-adini-yaz
```
- Eski cüzdan import ederkene bele
```
initiad keys add wallet --recover
```

### 🚧Validator oluşturma

NOT: cüzdan adını moniker adınızı yazınız
```
initiad tx mstaking create-validator \
  --amount=5000000uinit \
  --pubkey=$(initiad tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=initiation-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --node=http://localhost:15657 \
  --gas-adjustment 1.4 \
  --gas auto \
  --gas-prices 0.15uinit \
  -y
```
### Edit validator
```
initiad tx mstaking edit-validator \
--moniker "isim-yaz" \
--from cüzdan-adi-yaz \
--gas-adjustment 1.4 \
--gas auto \
--gas-prices 0.15uinit \
-y
```
### Kendine delege
NOT: 
```bash
initiad tx mstaking delegate $(initiad keys show wallet --bech val -a)  miktar000000uinit --from wallet --gas-adjustment 1.4 --gas auto --gas-prices 0.15uinit --node=http://localhost:15657 -y
```
### Unjail
```
initiad tx slashing unjail --from wallet --chain-id initiation-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.15uinit --node=http://localhost:15657 -y
```
### Ödülleri çek
```
initiad tx distribution withdraw-rewards $(initiad keys show wallet --bech val -a) --commission --from wallet --chain-id initiation-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.15uinit --node=http://localhost:15657 -y
```
### Oy kullan
```
initiad tx gov vote 75 yes --from wallet --chain-id initiation-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.15uinit --node=http://localhost:15657 -y
```



