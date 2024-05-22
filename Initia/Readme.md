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
SEEDS="cd69bcb00a6ecc1ba2b4a3465de4d4dd3e0a3db1@initia-testnet-seed.itrocket.net:51656"
PEERS="4512eea4775c650616f08f30ba03ce68be2eac01@34.230.84.121:26656,943ec566c3e2a5ca9d4ee86e4ae169c01169f079@185.255.131.115:14656,acd56cc6b824e6b30e678dbe6e66225e0ca9e68d@138.201.80.27:26656,eec4634dd1b8c101ac9dc982c0cd998c9388e425@104.237.3.169:26656,bd2b0c2eaac896997290b5afea348a44a1290f11@31.220.75.118:26656,59a61b5317bf221490262f738d53d027f55b82da@149.50.112.233:14656,c09a9d33c1edbfb9406612d45237a8a59e5c67ad@148.251.185.41:56116,21cd203eb451f85dce0b87e5d08ffe4d8db24713@34.126.129.53:26656,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@178.170.47.171:26656,673773bbbc4f7a7360d238fca9e987629809dab4@38.242.248.49:14656,41453d8197207ce8834a672896eddf941f5b745e@125.131.208.75:26656,e6296063871abeeabb3e5b8b164e6ef6b03e7fb4@188.166.174.11:15656,5abd21da8d7500cf49fcc1015a148163a8577cea@82.208.20.7:15656,bbed6acb41d66403e27294471f742d56b7929740@195.189.98.8:26656,ab4b72f78bd3f9ba9e63735dcf9e269f59cedc67@136.243.44.52:26656,90a735bf21ee4364f3d021958d67915df52b431a@49.12.172.92:26656,cb69794d171f371f6a6f37c095660a9e94369bcf@84.247.174.127:36656,ceef2cf926dc117f952957f0c2cde4ecf4da7b24@195.14.6.50:26019,6a0ac37ec7b235e457a483dc57b2e73b8a77fd5e@51.210.222.92:26656,10b173a6c692fc1d258c10689e7adbc6d0b22ce3@162.55.242.213:55656,fd9bccd8e9238bc191dcfc9913dc66fb63f92e78@135.181.35.159:15656,8f3ea9750508380a9a14832d692028922762ac69@167.86.117.246:53456,424ab537edaa7cb9e4e05d200a28a7af7a69ee65@35.198.111.193:26656,53eebd12c81059727c4a711084b6037451bdafb6@34.89.130.124:26656,52d95d395e78eb56570ffbd166b885150be8ff8a@3.79.247.232:26656,49086fc53330ea2d9048a856d9b0ccf5aa2033d4@3.90.202.132:26656,fa3dda208e8a290d40cb7ad429cfbe7344cb0051@85.10.211.215:28012,c99f1967ebcd5edb8eb9e624712e7372384a5917@57.129.28.107:46656,382628d247097430b306d53380291a95a2de91fa@95.217.119.251:26656,a98e47c02763d05f2a9623cb67e8e40e0d06504a@5.9.70.180:15674,a253b0f63f4810912d3135abc48da31b31e006fa@176.57.184.150:14656,1e1217e9d116f73932576c4816b3627732eda224@158.220.102.59:53456,94370d1dc52f47946710cc7a8b7ee98d75cb1293@38.242.229.92:26656,093e1b89a498b6a8760ad2188fbda30a05e4f300@35.240.207.217:26656,e32bd26d023e826bc40b2aca6814c1e0ab58544b@161.97.104.138:14656,96cf198e4e75189dcfda0a3f100f0aa6d99086c9@37.27.118.145:27656,2c65ce29c84d2af258bc7387d5189eaf6714df4b@185.217.127.124:13666,60a02209caf4e59206efa0b95cfdbe6b3d4cf186@211.219.19.141:28656,8e81b96d6290a6d785e19ae6e956a67e450cbd1d@37.60.228.43:26656,1677252f64d728aa9598cb7365f74af7c862d9df@65.109.57.221:25756,95da65376c0dfc8ef6f185a51b5877f81e0f6034@158.220.98.216:26656,e44e11c6f229a571f4239781f249a25e4257c179@185.84.224.160:25756,469967ee5ff89f8a0c05639a00aa7e262122d4c7@138.201.125.81:26656,2d4364da9999be2a17489ec9164de2dc3921b87e@147.45.41.136:26656,3130c3879bb50e444f6a885589456d3c36893500@178.63.95.125:26656,2e928bbe8400829c601d2779322e7360813fb21d@45.94.58.48:14656,fc70a6617be84c05480a59abfa4e57977d0db0f6@65.108.120.125:26656,1ebe1f045363a0e1dc20623c76aa801f243ce8db@77.90.13.87:26656,f3b498ad5bfb1bf36aff8d19aefb14d2ef03522f@185.208.206.179:53456,fb2f56d7540f25937dc7ee69ddbbbb33875b7321@176.57.184.248:15656,d0986153807d60e409ed20331b5ea00962ca1db0@37.27.100.172:27656,da7bf8f0e3f06553c2a36e285d71ac8dd5760639@45.88.188.32:14656,188681345599b0f836b620defabc6c407f5ba4f3@185.182.184.136:26656,3a8aaf2a38dfdb5bff1285bf427eea3661efcd9a@192.145.37.169:26656,fcff7c0ecfe76357a0c0eadd114fedb400371ffd@194.163.162.30:15656,6fa951edd7ee1e69dfe6fd7480be4ebaa9a0daf3@37.27.32.135:15656,8c7585098b9f8689f8ac455f1bb6704edf5bc3b8@65.109.58.86:25756,d28bfda9dbdf2fb9c75fbda1a74723c284eb8af6@65.108.0.32:46656,02676301c22f3fe352c144ef8ad1fb9ec11df21d@94.130.11.241:26656,fbba83eed4ed6fa29973d2791de4ad39d8839365@84.247.162.231:26656,e16268b46131287a709b5751d786d9c333d628b0@158.220.105.55:53456,2c756c13fefe75dfc5f8d2e930d51e3222293f55@149.50.114.135:14656,d99bd5c2618436847d411ac1c895a1822dbc7777@65.109.95.40:26656,8117c19d4db31962bb1ba23aeb6d8ef94b83599e@156.67.29.164:26656,27443666b62f04130453b54f6be3c0c002748d0a@95.217.151.58:14656,86c6907bd2a1d7cfec4c7a6ad1e4690d4fae3b62@149.50.114.8:14656,789714bc84b72d694ffb69fb532c6b670b778ddf@89.116.31.21:26656,e838948adde1779e16f70ebd7f1b46b38710bb22@207.188.6.109:26691,9d641880ef9f004497d358a24f466e97379aefce@193.233.75.208:26656,3b944bcae9db0b88d8419adde8e26188a6a5ef5d@65.109.59.22:25756,62875f209eef78f4927dbd36860ac6d254ad392a@176.9.183.45:33656,3f485e77240d0c47252fadbc95470315d10cd7e1@135.181.246.31:25756,46531763cbc22ca800dc0e3022c650319184f16d@51.222.244.157:17256,b982d7817f2e789199ab51bca789d503cab24b90@94.232.244.18:33756,aee7083ab11910ba3f1b8126d1b3728f13f54943@initia-testnet-peer.itrocket.net:11656,5e41963e9fad73d407e2f3421899c2e9b2a99e1c@95.216.160.158:11656,e28158351c02d073cd55c931ccc933261dc7c45f@185.205.244.64:15656,dcf2afb3d1d01a2a128a4c6a1f85109dbf571276@5.104.81.63:15656,43c95291a5c5138056915e612786dd1c1134f621@62.169.21.107:11656,753900db8b7b9dca9973a8215f99a4234e26cd89@94.72.105.230:656,4ed36ef632b25e371d41e780ec3cda977fb5839a@91.229.245.139:51656,2cf0ce4693b46101a8fb1f24f2c10ae81a4f2ef6@185.236.233.67:51656,edcc2c7098c42ee348e50ac2242ff897f51405e9@65.109.34.205:36656,d9b8e50ac286b2e647e4b627935cd225b4c6ceaf@109.199.97.152:656,bb1d8c80b4829a7c3cea01b059ab60da3329456d@109.123.253.67:1565" && \
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



