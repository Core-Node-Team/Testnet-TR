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
| CPU |	6|
| RAM	| 16+ GB |
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
PEERS="56c86f460fd6b566e598be16328e23ac0c8e9b60@81.17.101.100:53456,598157a19c31aabac15047c965e9fe4fb0e28ac6@144.91.109.167:26656,22eab5cec333a7bf42c624a5f0a93236866c75f1@158.220.100.155:26656,6d5436d16dc2cbd79b7c5cea9d294a6c4c919424@213.199.54.87:53456,63ab5e25e8bcb6d06b6355c5074d28a8e59de106@173.249.23.220:14656,cea76d6adcadd2ed767beaa1646698fae5b6b21d@213.199.50.157:53456,249646ca0f525656c7085b36f66b2fc1a90100e2@161.97.158.236:53456,12cd2a5f22782094cc90470def2fc665050a551d@62.169.20.176:53456,1847ef0cb094bde6c305b242f5e9cb740ae7628b@185.252.232.26:14656,9fc67f4588ae642413cafd1922fe96699aed5704@81.17.102.18:53456,ca5d0237c47ac684cf1b985124bb74b60ecb32f8@144.91.72.215:39656,0146f6e189b4152cf27c110991b8d13c738807ac@5.161.233.155:15656,a919fa81b40a7312eb96082acf1ece0358b164e6@62.171.139.83:14656,41121fc2b74bae55a76f1aa592efcc4c083945f9@62.169.20.209:53456,421e7eda7975e66fffc0d65da0474dd80a883f6e@185.230.138.64:14656,4befc5f9928c7b10d9bf86439d23ef5b08c564f7@5.189.187.42:14656,b0894b3fc0fef262b3de0d0433f3ec118e8f592d@89.58.58.180:53456,b24bf0d7a4bc0fd3a969500ce34dca4628b26b77@62.171.145.224:14656,8e43839ca6041e14b013b84631a5a34f383cbd44@155.133.27.223:14656,96e561c9d8bc3cf7d039a4f19debb620498736e3@62.169.20.172:53456,d01b0e7d01371388ca455c94a1298513eaf8d664@81.17.102.23:53456,17efe50d1511fedb07d566bb46c7d867c53be8e2@38.242.237.80:14656,0823bda8a95938b8530032467f514fd853d58932@194.34.232.169:14656,028c3db8c2658887f5714432c21cb53d8c8aa0be@155.133.27.151:14656,d9d295e179cd2603f2ea03e7e00a38ef3c1b5795@183.80.124.21:10656,66abd758f6971eb8227fc54d11cb56ca1ca280e6@65.109.113.251:13656,7827b14abdd185a544a371fdfa5645ef439258a9@185.245.182.186:14656,b9b043fb2f836c0dafe9faa287a5f49c4b05cd13@46.38.241.12:53456,f396faca04598721481e714dcb0e3c8ed05a406c@49.12.209.114:15656,8871661c5ce2f90be39a6bc5f65c4112327d4906@185.135.137.183:26656,398fca7aab6856631becc4034284c2cdddeed7a6@127.0.0.1:26933,bc5f3e27e89125431293aa1cf6d92cccb419cd4a@158.220.102.219:17956,4c7d65bee0ff5fb9ebb3ec8aca477f77a6e30305@194.163.152.237:53456,9ea146b73504a8cb2d8269f50b736c1d3e4f54a4@154.12.229.0:53456,69376ad6f9433cb4d32f1f6dd36a2eab3d8c1a39@135.181.134.118:53456,7d0f01b958c52cdebe2f6704ca69b4dd100a931b@167.86.88.100:14656,4a6d51ee908eb624feddc1a2297d499b68017be0@173.212.243.179:14656,504940507764ca6d39d6facd249d01143d5241d3@95.217.95.10:14656,ec009acf130d529ea6031117db47f5a8274f41e0@155.133.27.234:14656,f773345d464203b9c4928c8b145acbea4b6a8acf@5.189.174.117:14656,27c9c8f9966b8fd34b13d4b738efd8dc7918f419@156.67.24.125:53456,df76857e532cb93aac68798d805d4460c7765cd1@37.27.108.81:26656,f194cb15d21e5f55a7528f6755b887cad0950997@149.50.107.249:14656,57671760b7e2f7d14f23b43559542a4b18dabb4b@38.242.215.207:14656,6ba0f79c18652cfb4c27531bd62eeb60fdc0f997@213.199.50.221:53456,8a059d3aa383ff746f5713e0a4b5a0fc8ddcd110@164.68.119.228:14656,e8f8ab37193b8585ee9db63b9ed4102b75fdaa47@213.199.63.22:39656" && \
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



