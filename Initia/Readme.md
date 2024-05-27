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
SEEDS="cd69bcb00a6ecc1ba2b4a3465de4d4dd3e0a3db1@initia-testnet-seed.itrocket.net:51656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:25756"
PEERS="377ebad64f21273af6259573d7722ca158630f6e@158.220.105.35:26656,1c425e0fa43437c0819a0e578921ee6f5c49719c@194.233.80.111:26656,e313cd21cb01570ddb6951f3d31c7d95e0febdf3@46.250.239.84:26656,e53d0fbc86b130a5af5c2afd7d4cd35aff078d39@152.42.162.103:17956,5f84b7cfe6eea7d6f73c8a3139c185d6e7d5aeb4@82.208.22.3:26656,600d189ba0dc26fddf448a3c67a2c41980f7e43e@185.252.234.22:26656,aaf1b60eaaa98d478204158c97d060dd4f16030e@34.30.236.36:26656,8a4a405803abf35007fa157bedd061cdaf42055e@38.58.177.61:26656,592fe0962103fb917a30f23a9bd01c6611fe6c4b@38.242.193.129:26656,504d4bdf202a989094f9e4ceecad65c0c677205d@49.13.136.252:26656,bc9b180a09cc2ce4c1a7559a78fed5c0b7f9bd07@143.110.231.93:51656,04faa7ae532bb0ec9e8c6bd96c5dc3ef30d38afa@195.179.225.242:26657,d76820c0890379eb75e3c27ea881167f97f3ca70@95.216.43.37:26656,e1565dae77be5898ae7dbec98baa307e6ccd3ca6@45.94.58.162:26656,934ea819dcae58c39fe4f6ce5113a1efd45d1249@84.247.141.35:26656,ec5f36d85e5834e8894c06a0d22cd68546e31613@148.113.6.172:26656,63092791a9237f8e1df6a0f6e96bf1702571a3bf@31.220.94.225:17956,024b615f6a5e5a03e3a5929be65c06c0e8eaa706@217.76.51.182:17656,1409825f99073ddd376e4579f594053ed2bd45f3@194.163.183.197:26656,4e6e831b40b8a8f3511efec9115cfb505c69427a@37.27.124.171:27656,e00aa27181096f33f54cd1a5dc2c837c92b0e236@193.24.211.113:53456,0c1d69c97a188371f5e221a6f8a51f48b338a111@95.179.162.99:17956,9c3ec4d1c63facd3c27f4375577bbfc3b216f188@45.10.154.165:26656,79d78fdbd7bc49e9648b24b40bfa97eea89357d9@38.242.217.43:26656,7ff5d3df64af24efe038ed6b2839e667138b2c49@199.247.1.54:17956,559d789683630924a0cd027288e511e968b0107e@45.84.138.98:26656,436e16fae87b9daa35fffc737b7a7ddaf252814e@65.21.74.125:27656,2b64551cd989319bcd16c8c1ed78ba1596ab59d8@82.208.20.187:26656,ea450f5bdc17d1c8ba3d6329f42e460394248f1d@195.179.225.248:26657,c6ab82d70d76e65f6d7cb87c96b8767cd1f1c27b@38.242.216.119:26656,16c283b5a5d2edfec8370300c48b87fc0a5d6e86@161.97.175.6:26656,ac11cab298a8a1ad60172be762a1d0adcc9f5a56@157.230.121.204:21356,bd1d52103cdac46903eee12c4c7c793d2d1be603@136.244.80.167:17956,292cb203a4eb763ff3c6831584168602ad0f88eb@89.117.62.43:26656,5a32a7b6b3967f867f9136fecc11cd805def19e9@152.53.14.247:17956,f4e17f407bdae3aaccec2315e98caf422fbbd993@161.97.136.152:26656,557dcf2b571ee27225e56a3cf766abaeb23e9ff3@38.242.250.253:26656,a11c27af1f3ad80e57b9ca991961952039c95213@84.247.169.234:656,c04526a0a50bd2d40aa957b9d6d6b1a0492f133a@146.190.132.179:26656,472ce2964c5c6bb208fe046cace029bd4d608948@195.179.225.245:26657,a585397ecd22b21eaf3210fa83912ba9ae1fed78@193.24.211.114:53456,12b6e980f446f7e0b53d9895cc42bc315a20d3c1@91.207.54.99:26656,9fd7a23c2b726d1dc114ff10a60074c0c2e6e7fd@46.4.55.46:35656,32756a5b2576d48561d20e93544290019418d2a2@45.8.132.174:26656,6f06f63189972ba97c883a970af237703aefcde1@89.117.58.216:26656,27b3fe56a5f429d270ad72f395b271636e1ff775@45.77.142.182:17956,2067bc8d5d8ecc24caf9944b9f30768c00403057@62.171.168.50:17956,4397a889e2e893ff2d4e8ef4a2bd8341857f783f@195.179.230.152:25756,5f74a73f53e1f8950af27645a2a6bfe8026ec75f@136.244.87.208:17956,8172084c682d6af8bd19ab72a26d850ac1899454@158.220.89.125:11656,46531763cbc22ca800dc0e3022c650319184f16d@51.222.244.157:17256,32f766cfe87f1e73f91842c5de31dded7d0bcf86@93.159.130.40:37656,2874182e1ab50acb17aba223d2f99cf3de0cc71d@185.185.82.177:26656,5cdb3d6f05fbb0433fd90711d5bd3e9438a2714a@3.79.247.232:26656,ced0575dd32a9c91981100731a7e3bda504927c0@16.63.234.103:26656,0940d8b2e54d7e435c26c4913a3c22862cb6ab9a@129.153.79.186:17956,3d6b49134755b051576909693bd8cab02fd7ebf5@194.242.57.210:26656,e420cecc58552c067a4477984c665c2967524e9c@89.117.61.243:26656,ac7fef7983d18c4992419cda3a0c0d31017a90ad@82.208.22.2:26656,1d604f6de4b6d999e53ebebd3993dfd6d7a1cf01@38.242.229.145:26656,33d0af5236224a7dac61447b71f5be723544778d@38.242.207.19:17956,da80a0d5c3bb6db38e393acc15f8a4ca8bf0e6a7@104.236.199.180:26656,5a96e49cf4d3642b9b65ef916ac5f5e4cab32b1f@167.99.62.81:26656,3991f29e438c42ef9099255f6686c727af87af86@164.68.100.13:26656,8e8a54d1516c198a153c2cf961c613d67eb39f4a@139.226.81.144:26656,bed55ace8bd4dfc3de2e50e4f96636cc24ce1728@38.242.148.54:26656,5af4465b2a9cc7be2589ccbca20098a207698780@37.60.224.144:26656,239e93323630132ed79a88e4879533c5d3c6459b@38.242.223.157:26656,ae63298bec8b6726fed75236650890bc6e36dd59@95.179.242.133:17956,0d45af8c184a44f27d2e1ad2868a42557a3717f3@82.208.21.186:26656,6bf030a784c59e41fbc97cd1c4162300f6ed234c@49.12.60.107:26656,de5c01d058ac0c7d473fe1acc3239e679fb7cd8b@193.24.211.116:53456,4512eea4775c650616f08f30ba03ce68be2eac01@34.230.84.121:26656,2284949b8fd2fdeffcc76d5ce94a3812a6e2a6b1@37.60.246.110:53456,e022e7c0862fb485cd0edc468e63f0631097ad47@195.179.225.246:26657,2be9a85da71eed4cf8f7c8a58704b6f5dfbc197d@38.242.142.201:26656,1c8d92917894ae3af31a83c9c34b846f73fca002@85.208.51.55:17956,d498b0da96ece837d5ceea439e7cbb251ac2bb17@156.67.28.230:47937,13308b676c6e05ef712eb396beb8bc7a89f7947f@38.242.212.130:26656,77888f7a3d6fbff15c5e89c507f61e03d76e00b0@194.163.139.5:17956,15dadcdb79ad05ef7b3cf8d0cc9cf270c005f191@88.99.219.120:56116,59fb8058c2a682e96f529056d0b1bd8f40cfff7f@38.242.214.145:26656,ff51be9ed2abde1a52555f42bb2a168cc23ceabd@161.97.151.81:26656,981f96730c07ac803c5533a9e172edefcab2c36b@95.179.249.104:17956,b71d2e3d8c2c65c0af6de44a8a839e945161ddcb@194.163.189.67:26656,852e401036d85708b8744ee073d094e9950418c1@171.240.247.214:36656,15ca91dae661d4e686446adb6764c7243410e51a@195.179.225.244:26657,aad76cf3eead0bf91db056586ed59ab1e394dfab@194.60.201.244:26656,a95ff2a5d20c8ee460fe0b3eecf4ed86d6aba602@94.232.244.108:26656,fbe5451f029754f99f714e18989ee252dea3f30a@94.232.244.12:26656,b61db65540f125795d1b06eafb8b3580d948075f@164.68.127.220:14656,65c3089c05957dff757ff4ecdacb078097352ea7@195.179.230.151:25756,f587d09754197a00ef026fe2e3e1936113554bd7@5.180.24.17:26656,31de0f9d8d100bd8f94987f54efcaa28415e2806@162.0.226.227:26656,49f0693bfb3ef396324635b3d0ba77cd79e280ff@195.179.225.240:26657,a867d1eda5af3225aaef0e98f7bcaa352a1e1f5b@38.242.138.70:26656,1677252f64d728aa9598cb7365f74af7c862d9df@65.109.57.221:25756" && \
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
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" $HOME/.initia/config/app.toml
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



