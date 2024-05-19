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
PEERS="ee0391af866b10486cfe91b4c211c29ab683a1da@104.237.13.109:26656,5e9fb9fa15fad5356828ed4832ed58bf80177719@161.97.118.3:14656,1ae804e6a624d37d4affe9c2e29f83faf4fefc90@161.97.87.25:14656,4327ae81c914589505c00513e775a89529e404b3@62.171.140.24:14656,700d1cad3393cdd1f3568be70baed0b8f04122ff@164.68.101.191:14656,3371c3f698f81eb568e6613764d028c5855f5694@149.50.109.43:14656,7b90ef26e3f30cc9c5cb90c81551c8e49e679081@149.50.113.241:14656,e8e5ce53a6323d9b40b67a06260ec69c4131c249@95.111.244.126:14656,67ae4c930efe1fca234985c0ef734aa340a9cb91@149.50.113.112:14656,c383adc0bdc15d6cf374436a4a960ba51517fd3e@109.123.250.81:14656,61a09591dd9cc1af0ab469dce9b90ad3d543fc52@38.242.232.255:14656,a69e1d850f5f59256a0ca8724b5ab8797d7761c1@144.91.120.68:14656,6bb30c44a34ff30c377c08a88f6b21feb65a165f@75.119.130.9:14656,7d91fedde0045743424aa053cb7e21c9b61f7e5d@173.212.245.129:14656,d2db1174d2fc5896db9a41002ee13d39d8ce8ae6@185.187.170.164:39656,e28ea35b16700e093100f1e50c8586a7ee5b2f9e@149.50.114.198:14656,1305cc1a3344208094584f51319bf9a5ae7bc86d@84.54.23.60:14656,f80d21f9d75a415ddab3609550445de97bd10edf@38.242.139.87:15656,afc82f6ab6d3dd1a07ca4988c58d82d1dfcac8df@84.46.250.62:14656,a29ecdcfe85c537409638ce80a1ab8079154b1ab@149.50.113.114:14656,456d3bc6e7fe1648d7b91ed1c66437f8a5558387@144.91.73.210:14656,0efa5534ab76164eeb0e1ef75457224a96533e66@173.212.231.142:14656,7d18af48a2ae59e6eef166d06c80d627b3bc9ae8@149.50.111.9:14656,ab357b1da9bf92dd06293162a88006c31ecef67b@149.50.113.64:14656,c8590bbaa90f6a78cd30b87bd0858c6902571e08@144.91.110.68:14656,ab014c2c73879262047eb013112c849604a6abff@149.50.112.206:14656,4f759cf0eab30fc951639b4464e740d32154e1c6@38.242.255.128:14656,cfc84b99280b42544b209aa9ec9ef004b95d43b5@149.50.111.19:14656,98708cc69f95f3ce3f76f3628cf7ee02e8c351e3@161.97.122.23:14656,8e8537bacf66e9bdf15872a4e070362c2ded00fe@89.117.60.190:14656,9e752866b2a726bb819212e462c31a20399a99b4@194.34.232.228:14656,165a919c2003096914367c5439c4f58fdc32acf7@167.86.101.31:39656,e9c5c14880533618f3c3678ae8c5461a06ff8fc2@207.180.226.186:14656,d871096b11164134099df23f9736d60a394a6900@5.182.33.223:39656,4f0c17cb438655e867aaec8e66097dbd8c528d64@149.50.111.245:14656,e38e75368d186c6db5754ee6ff9072e3fb52233a@89.117.63.148:14656,808feaceaa7cf76bd016a5160c55f3036eb8ba33@51.158.124.170:26656,9452a5cb394de7f0826097e76f3cea57a9e97376@37.60.230.87:14656,4a2859f2bf1cd3e2e06b481d7c2e7492a2a9b5a9@89.117.59.250:14656,55c1ef27565a4e7f96940e794e25352a41030406@31.220.74.139:14656,912f4b4d6fc74b3c7949fced37fc524c00f7eb11@5.189.133.252:14656,9715203053d49b9261c9e3dfbd0d08eff7cbc7d2@149.50.114.39:14656,d18577a2ca0c624c36558959ba976261926d0cba@85.190.254.224:14656,398fca7aab6856631becc4034284c2cdddeed7a6@127.0.0.1:26933,3effeb341c41d7f97faa2eb0bf7742bd1267e276@84.247.164.238:14656,0dc541c0ae36e5f270a014f4de88826b71bf39fe@167.86.92.194:14656,ada26902631661fd5b9374f932d7228200aa831a@38.242.243.197:14656,aee7083ab11910ba3f1b8126d1b3728f13f54943@initia-testnet-peer.itrocket.net:11656,a8f3e2d4197b34c11228809d0f785a952905b262@43.131.12.180:26656,4b879d5b09b96e16aaecd6d251e47d73228ca21c@81.17.97.133:26656,9c0417a610846b3a7fd27ac3afbf3b52b527807c@43.157.82.7:26656,7317b8c930c52a8183590166a7b5c3599f40d4db@185.187.170.186:26656,35e4b461b38107751450af25e03f5a61e7aa0189@43.133.229.136:26656,6a64518146b8c902ef5930dfba00fe61a15ec176@43.133.44.152:26656,a45314423c15f024ff850fad7bd031168d937931@162.62.219.188:26656,7cc5b2d92b104108412855d2ee67abfecb2befc7@162.62.219.229:26656,8d46bc1a91bef7ba96fa7aa3bca2ea92b43bccaa@162.62.121.154:26656,8935e4f97a81ace79680f6ca1d2a46c60ddb5a90@43.155.173.100:26656" && \
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



