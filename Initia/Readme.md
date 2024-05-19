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
git checkout v0.2.15
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
PEERS="9ea146b73504a8cb2d8269f50b736c1d3e4f54a4@154.12.229.0:53456,12cd2a5f22782094cc90470def2fc665050a551d@62.169.20.176:53456,4c7d65bee0ff5fb9ebb3ec8aca477f77a6e30305@194.163.152.237:53456,0864b4f2cafb87dd500feca0a689af2c6381deb3@109.123.251.247:26656,398fca7aab6856631becc4034284c2cdddeed7a6@127.0.0.1:26933,b9b043fb2f836c0dafe9faa287a5f49c4b05cd13@46.38.241.12:53456,0cb2a1a4f900976326d5ff6fadb4d9366fd48a39@149.50.114.176:14656,94b871cc4d5fed2becf98e3a9079b3c823803618@167.86.92.18:14656,5b558b5ab6690b3532b1fdcd43bf59f28605f729@167.86.98.12:14656,800c76ee5b4787709aba1e7c9e758e6c9c76f583@161.97.104.116:14656,96e561c9d8bc3cf7d039a4f19debb620498736e3@62.169.20.172:53456,a7df17cccd0f110bde9d6b4fd6d5830fe7a21351@62.171.189.105:14656,79409f3bc53f29bd9d55858214aef99dfa747b4e@49.13.95.31:26656,bf5aa5fad3956681d8b10f7e0ecdc84d90a863d8@38.242.231.235:14656,b24bf0d7a4bc0fd3a969500ce34dca4628b26b77@62.171.145.224:14656,22eab5cec333a7bf42c624a5f0a93236866c75f1@158.220.100.155:26656,6ba0f79c18652cfb4c27531bd62eeb60fdc0f997@213.199.50.221:53456,8a059d3aa383ff746f5713e0a4b5a0fc8ddcd110@164.68.119.228:14656,9fc67f4588ae642413cafd1922fe96699aed5704@81.17.102.18:53456,1847ef0cb094bde6c305b242f5e9cb740ae7628b@185.252.232.26:14656,56c86f460fd6b566e598be16328e23ac0c8e9b60@81.17.101.100:53456,673f3d15203fc3eea005988cc3867efcc1a880bf@38.242.131.106:14656,733c02627df3250fd4c16d94ebb4d594dda5f695@88.99.60.182:26656,6d5436d16dc2cbd79b7c5cea9d294a6c4c919424@213.199.54.87:53456,fb9b8686b0d8a8b7aa49f553043c2ae45914875e@158.220.96.77:14656,cea76d6adcadd2ed767beaa1646698fae5b6b21d@213.199.50.157:53456,d01b0e7d01371388ca455c94a1298513eaf8d664@81.17.102.23:53456,c77b39e4fbf543ae33b957652e43844e6e9c2799@161.97.101.39:14656,51302cdac2b87f7323b60876fd223baffe1940cb@161.97.66.136:14656,0823bda8a95938b8530032467f514fd853d58932@194.34.232.169:14656,f194cb15d21e5f55a7528f6755b887cad0950997@149.50.107.249:14656,fdb9fcba07c457990dcef5df940c2a2543296f73@149.50.113.221:14656,249646ca0f525656c7085b36f66b2fc1a90100e2@161.97.158.236:53456,bf6824d6e3bbb3dda6ec67a87f26813b46558329@156.67.24.250:14656,37fd5564ebfebe7eb498a1ebcf8eb12d206ad7d9@149.50.111.81:14656,69ddeb50710ab156d62694f4f3d9786b340e8167@135.181.34.78:26656,504940507764ca6d39d6facd249d01143d5241d3@95.217.95.10:14656,2f13795b17aca8760f7201b3808759b8ae2cddd3@185.252.232.138:14656,b1a79250e763e41fe02a501a12f4533cd3a4203f@149.50.109.244:14656,27c9c8f9966b8fd34b13d4b738efd8dc7918f419@156.67.24.125:53456,be799b844a3db22708959f49f2a7b2548a6d1984@95.111.250.15:14656,b83f763ffb3ec27a09c8765e1e0130bb146a2abe@62.171.187.30:14656,57671760b7e2f7d14f23b43559542a4b18dabb4b@38.242.215.207:14656,41121fc2b74bae55a76f1aa592efcc4c083945f9@62.169.20.209:53456,647691545d19d3ed8e95d855e83ff85ed745193b@75.119.159.237:14656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.initia/config/config.toml
```
### 🚧Gas pruning ayarı
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $HOME/.initia/config/app.toml
```
### 🚧Pruning indexer
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.initia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.initia/config/app.toml
sed -i "s/^indexer *=.*/indexer = \"null\"/" $HOME/.initia/config/config.toml
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



