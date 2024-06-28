<h1 align="center"> 0G

![image](https://github.com/molla202/0G/assets/91562185/6eca238f-cd35-411b-9c5a-857fbd80dd33)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://twitter.com/0G_labs)<br>
 * [0G Website](https://0g.ai/)<br>
 * [0G Blog](https://blog.0g.ai/)<br>
 * [0G gitbook/docs](https://zerogravity.gitbook.io/0g-doc/)<br>
 * [0G Telegram](https://t.me/web3_0glabs)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/0G%20Testnet.)<br>


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
cd $HOME
rm -rf $HOME/0g-chain
mv .0gchain .0gchain1
git clone -b v0.2.3 https://github.com/0glabs/0g-chain
cd 0g-chain
git checkout tags/v0.2.3
make install
```

```
mkdir -p $HOME/.0gchain/cosmovisor/genesis/bin
mv /root/go/bin/0gchaind $HOME/.0gchain/cosmovisor/genesis/bin/
```
### 🚧System link
```
sudo ln -s $HOME/.0gchain/cosmovisor/genesis $HOME/.0gchain/cosmovisor/current -f
sudo ln -s $HOME/.0gchain/cosmovisor/current/bin/0gchaind /usr/local/bin/0gchaind -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/0gchaind.service > /dev/null << EOF
[Unit]
Description=0gchaind node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.0gchain"
Environment="DAEMON_NAME=0gchaind"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.0gchain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable 0gchaind.service
```
### 🚧Node ayarları
```
0gchaind config chain-id zgtendermint_16600-2
0gchaind config keyring-backend os
0gchaind config node tcp://localhost:56657
```
### 🚧İnit
NOT: node adınızı yazınız.
```
0gchaind init NODE-ADI-YAZ --chain-id zgtendermint_16600-2
```
### 🚧Genesis addrbook
```
rm ~/.0gchain/config/genesis.json
curl -Ls https://github.com/0glabs/0g-chain/releases/download/v0.2.3/genesis.json > $HOME/.0gchain/config/genesis.json
```
### 🚧Seed
```
PEERS="32d204e5c80363a8c596892d20eb1d9f42a05e4a@107.175.84.69:13456,5668354296fb6c4b9fc39f551b6422a58761d0a3@84.247.143.248:26656,15b386d82e2a13bae9a55b986979c2da2c12d3f0@195.7.6.41:26656,1f432f187b9da847675cb52e13d5f1a89c53f589@45.149.206.73:13456,71a17bb1a991204c2ecf5f77f83fe8f398074761@164.68.118.141:26656,7e422c8e75d9bf8a917a61e053456c2925a8d25c@1.196.157.77:61656,05c41a56942d13a319998bb8478ddc8b3cd45148@84.247.162.17:26656,257c4351b7ed57da0487c82b911438428cc900ad@185.249.225.194:26646,a27707a810ce702ae84a6ddb28d9d2a860eb3381@82.180.147.22:13456,a14e7a1b278e4d100faba03c8258ac76b29ce9f8@45.8.22.87:26656,2fb36033e2554c3398c161e21ebb891089573943@100.42.184.2:26646,5866445694b6dbaf73ea56de2a0c14734b614df9@157.90.209.40:34656,b9d070fd993fd06d7687ca869126dc8410f2bcbd@194.163.158.212:26646,735f23d5efd113a3e83827648bdd93e33461c1e9@91.205.104.75:26656,00e4f43c6822d503092ffefff4d13db26b2877a2@38.242.158.147:26656,c68a84b468bcfd48132933939477048badbddad7@148.113.17.55:21156,4a8fc8683839779b518bd9bb2d5ec17573907928@94.130.22.56:26656,c1afab610218ee977eaa25a1cec31164633af5ef@65.108.106.238:26656,765db6021066802d2a02e3254b4f181789265888@185.217.125.71:13456,9ccad19eef98add6039f46d2584e639849a0641b@84.247.177.152:26656,274bd722e375b753f3f98911a239280638d218c0@158.220.92.15:26656,a00e92d848ad4b7673ec8b9e6f756772aa3d311c@111.9.3.46:26656,dfe97a268bf07c6b5bae38b63e0f282ac49de6e2@158.220.81.224:26656,0b1f5de86fbe43bacfc6c536cf06b5266cf70e95@88.218.93.179:26656,70bb178db05022235c642bfc0dae7246dfaa4d0e@207.244.234.6:13456,e7eb077736db50e9857b43c624e1caf3b592c218@154.12.245.173:13456,21bf421c20930fd7195b41d1399884c6e693aff9@157.90.213.97:34656,0bbb84898c25b4747b354c2b8e739b42f6fc8222@188.40.23.168:26656,381a4c37a92319d4df6a68cca11219d3d38f6a62@37.60.247.233:26656,30785c3c90316e4045f0126f7506e09234f28f8a@84.247.190.63:26646,d08764ae3f8c05297d905cffbf18a0d8ff93c169@37.27.127.220:16656,ea21d6d027a496e232f227a56b3a49a80fab5eda@45.8.22.47:26656,93a3e682f9d125f9ff59cd4805b2d21c19900382@195.7.6.250:26656,95994c0fbc5821fd835b207a570c85bb654ea803@194.163.183.37:26646,ab02f756e616565fa9c3160ed3dd8ab57a29e892@100.42.181.230:26656,bf6e25f4926811c9fc50b3c7692ab96002db19ee@94.130.54.140:34656,bed108e9ce56d84a574fa02df90c734281ae19ef@162.55.65.137:27856,94e4d0eeb4108eb594b490192193cbafc118f68b@138.201.8.241:34656,f751dd07516a28076f6f802c16cc12a62e0380b8@168.119.15.124:34656,bbc62ae5338d7bb55a9b2b4cd9788c8c68c95fd6@178.18.240.50:26646,f837a6e4f6104258672b553f0d18dd38241f05f7@100.42.187.120:13456,4314f3a6423019732a9cca2343bb008554023829@156.67.81.43:26656,5dfcc526fb1de5d6a933430c094e2a67e32ef215@45.136.19.8:26656,8114a86109547c98a80aaef23da7f3f772f0a249@170.205.30.194:26656,9a7a05d063ff0ff1bdf95b6e6249ae9355999335@74.48.84.252:26656,aace7e9336db972587ccf2bafe7478a694832551@161.97.134.211:26646,c104c0604745090235592fcdd18fa3fd6c7b4c0f@88.99.166.253:26656,0d417133b03ff339663bd95211bba643a81a889c@45.8.150.43:13456,f5401bdc053cd5cdbe10c5da154532cdf7885e95@116.202.76.232:26656,d6265d755a2f7a30e9682c8ea3c4d727ec73cf65@65.21.237.124:12656,dd05d10402ce1da08ffd34ffe9007e101775e597@116.202.126.222:26656,8b11dde06b5e0f834e2186dfeca0bd94ac3ba04c@188.40.197.62:26656,d2f847a340a79b915fa4450b09391cef89712da6@185.187.169.75:26656,fe0c5f032af87fd8babd90a59f9a2358264b63fe@100.42.183.60:13456,4d6b7d0aa6841f00450601a47f17a665ab6908ff@198.13.49.7:13456,8fa3dccf745f8f66409065405dd502eab78b4a7c@88.198.52.50:34656,84d2ddc866ff9ac61299d5c4036a9d9b442838bb@178.63.52.95:34656,6d43071195747850156aed1223c5fae438e65733@61.10.9.34:26656,fe72d1209a7f27eedfabb39555cbedc31c338724@157.90.213.57:34656,6970d09a9e004f6132b30db6eb5e27b6bd53a1d8@158.220.89.199:26656,3a7fe7a54b2519a18f84c221ac00b9c717dc6e39@84.247.161.190:26656,5c491bab67d7c9d778485dbfa9ecf527b20ebba1@85.190.242.209:13456,1e8c341beb96d92b8214f5acaaa615388a1691b9@148.251.121.170:26656,dbfb5240845c8c7d2865a35e9f361cc42877721f@78.46.40.246:34656,e1442cf0e54629ad8a673d6e09231e573efa2591@45.10.160.156:26656,0de64b5c0013dc6e43fb5f02b443790eb0f5135e@45.159.231.194:26656,16dbdba70d0727c2680b71194860828e4ae54c6d@207.148.64.35:26656,dc496afcecc672ef94770cf5b9c1c269676def76@188.40.197.61:26656,1165660e47b970274ec470a08c77c9b6078aef7c@43.163.7.162:26656,4b14fefa7b9bdad4e5d70fb987679f6e1da74fc9@194.163.184.126:26646,423b16c0067faf4553f643cba7eb72368c4b5a30@78.46.69.209:26656,38bb469b5568a94ab78cdc9bd1b946e46a688ba6@110.168.248.175:13456,297b01e38df8030f34006d9ffda989765251b1cc@75.119.159.155:26656,787c2d69d9069616a0926de033d9b828f3fec177@100.42.178.228:26656,6cc6d95c210893dca5beffd6854d1490a46fa76f@188.40.197.45:26656,e23db79fe3a7da70288be8fbd3d5f2e2729a6b43@176.57.189.28:26646,39dd0efa0bedd2daadac85edf2c5e3351ffc08e7@15.152.71.57:26656,4448f5b5ef56502201bb7d99a7f5a4d86bfb933e@45.8.22.109:26656,81cab2b9f090f01e4a543426a34a38a6ef72176a@185.135.81.50:26656,6dbb0450703d156d75db57dd3e51dc260a699221@152.53.47.155:13456,a44f41eb95507a3215400ec1fdf73e80c257cfc7@62.146.176.63:13456,051258e69c19d9e261100619cc0cd8bea66d4b2e@158.220.114.24:26656,c6cf6d62d87728be39663d4457b374b8b93f647d@85.190.242.211:13456,d768d5292222b43148bc933631df4a34a5e5c926@85.190.243.137:26656,7cfe0d1ed8245ff5f2b5ecfcfd47c1d5a5edbffa@185.190.140.203:26656,5dc3b4e87b243bb88f857c025ba57eeaa9048c7e@194.163.159.121:26656,1241461c30efc6cb62dede354d72ef56b1387e46@31.220.75.213:26656,7cf4c84a6e44e919a74f26c04c3bf231fd2d4d03@136.243.93.159:34656,e904f7423d036a4df66dce08a6ddc658cbff16ea@138.201.224.86:26656,ff5ebf4b036164aa41df114c9713f0f83ffa4370@148.251.46.18:34656,2037186fdcb85e1c33e89bc30ca343ab07159e37@149.50.101.203:46656,a8bbdbfb9956562d656635ce6adab590b73fad1b@89.116.26.27:26656,d4218027889dd6d78ea92294126b5450b7a81351@109.123.240.174:26656,908a7a4f23d8a0933dbf11cbb0dbfe36e16f7d03@185.209.228.241:26646,4fefdadc4e00007a1a761908245782f72aa86c79@194.163.143.27:26656,b6a05c26f8d2d18e0e77b2e991845eb43115714c@144.76.30.120:34656,3cbf64cbc60c4204d922f16914045d7ac1546af6@176.9.65.237:26656,cb28b52b07c2080228a2268cbed187fbb15e6dbe@185.218.125.156:26646,296cc6b80d0dc97a8db6e643eda2b816e1b33bfc@38.242.193.45:26656,bbd5279708fb63f19cda1a6f8fff48a02586b0b8@45.8.22.151:26656,70fcfe3b7faa483dca4f0e7a7738abb9095601cb@213.199.44.41:26656,6e15ceca919446925e7d1aea1dab1f282a22d010@159.69.136.118:34656,71e01e28fdf9c09dbd5229ecdf3d97c584c89385@149.50.96.112:26656,8336a508a250320739d1295fca7be2a895ec42c8@94.130.64.31:34656,3250ca81674715bf9d223119c04d0c019435bd58@176.9.9.8:26656,01de8b4415ea4469c6a144747b8740f5204bab77@148.251.179.244:25656,4f995dd9c7db43f32ee271cb5047d96086e0e69a@37.27.106.27:47656,1d2a604475ca45d28f305316af39bd4d389caba9@184.174.39.213:13456,f7bc8ee1b20a8575a5d09a06faa4a617d452dca6@5.9.142.119:26656,6d460eff7daa57e525090ab88557672a318ef8bf@161.97.173.129:26646,d17b27dbf66ed4c4f48227371ab1be6399fa6cbe@75.119.158.44:26646,d5e294d6d5439f5bd63d1422423d7798492e70fd@77.237.232.146:26656,a73cf8432a9693ecfbb821ee5c05c22d491b095c@100.42.179.70:13456,4797c8bbb87cef85695d9c3b2232105c1a606668@168.119.10.33:26656,c8d5e7036beec6cd24cc43430b79dfd748c1cbd3@147.45.41.75:26656,df4cc52fa0fcdd5db541a28e4b5a9c6ce1076ade@37.60.246.110:13456,0d7251a7d6cfb4a20b6e49d3af66e15a7b60a828@152.53.46.223:13456,47fa754501e17d4334fcdc690c4602c98987a7b7@100.42.179.68:13456,edf498fc9eb6642f64a1cfbc1e5be110439ab0f9@86.48.7.249:26656,9e1028551ee7c0a20c12b108b17ad229b4d4d270@212.20.42.79:26651,8756782a6776237e42c5958deec3fa46a24668bb@75.119.128.3:26656,21f7a37859880f4f0d9a8eae35a16490acf343a9@37.27.71.178:16656"
SEEDS="81987895a11f6689ada254c6b57932ab7ed909b6@54.241.167.190:26656,010fb4de28667725a4fef26cdc7f9452cc34b16d@54.176.175.48:26656,e9b4bc203197b62cc7e6a80a64742e752f4210d5@54.193.250.204:26656,68b9145889e7576b652ca68d985826abd46ad660@18.166.164.232:26656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Gas pruning ayarı
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.0gchain/config/app.toml

sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0ua0gi"|g' $HOME/.0gchain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.0gchain/config/config.toml
```
### indexer null
NOT: stroge node kurucaksanız null yapmamanız gerekebilir.
```
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Port Ayarları
```
echo "export G_PORT="56"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:1317%:${G_PORT}317%g;
s%:8080%:${G_PORT}080%g;
s%:9090%:${G_PORT}090%g;
s%:9091%:${G_PORT}091%g;
s%:8545%:${G_PORT}545%g;
s%:8546%:${G_PORT}546%g;
s%:6065%:${G_PORT}065%g" $HOME/.0gchain/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${G_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.0gchain/config/config.toml
```
### 🚧Snap
```
sudo systemctl stop 0gchaind
cp $HOME/.0gchain/data/priv_validator_state.json $HOME/.0gchain/priv_validator_state.json.backup
curl -L http://37.120.189.81/0g_testnet/0g_snap.tar.lz4 | sudo lz4 -dc - | sudo tar -xf - -C $HOME/.0gchain
mv $HOME/.0gchain/priv_validator_state.json.backup $HOME/.0gchain/data/priv_validator_state.json
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart 0gchaind
```
### 🚧Log
```
sudo journalctl -u 0gchaind.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
0gchaind keys add cuzdan-adini-yaz --eth
```
- Eski cüzdan import ederkene bele
```
0gchaind keys add wallet --eth --recover
```
### 🚧Cüzdan evm adresi alma
NOT:wallet adınızı yazınız
```
echo "0x$(0gchaind debug addr $(0gchaind keys show wallet-adınızı-yazınız -a) | grep hex | awk '{print $3}')"
```
> evm scan :   https://scan-testnet.0g.ai
> evm için private key alma mm ekleme aynı cüzdanı. cüzdna adınızı yazınız.
```
0gchaind keys unsafe-export-eth-key cüzdan-adi-yaz
```
### FAUCET
NOt: faucet suan 
https://faucet.0g.ai/

### 🚧Validator oluşturma
NOT: discorddan rollerinizi de alın ki kanallar açılsın

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2b73ebc0-0880-4237-be41-aeb739f2d325)


NOT: cüzdan adını moniker adınızı yazınız
```
0gchaind tx staking create-validator \
  --amount=1000000ua0gi \
  --pubkey=$(0gchaind tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=zgtendermint_16600-2 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --node=http://localhost:56657 \
  -y
```
### Test dosya yuklemesi deneme

https://scan-testnet.0g.ai/tool


- adresine gidiyoruz cüzdanımızı bağlıyoruz. ağı otomatik ekler. sonra herhangi ufak bir resim dosya seçiyouruz ve upload ediyoruz onay verıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/36d5d3ee-85a2-4d7a-ae56-8784b0fa8c1c)


### Kendine delege
NOT: wallet kısmına cuzdan adı yazınız 2yerede. miktar kısmınada sayıyı yazın 1 dane edeceksenız mıktarı sil 1 yaz olmassa 1 sıfır falan dusur
```bash
0gchaind tx staking delegate $(0gchaind keys show wallet --bech val -a)  miktar000000ua0gi --from wallet -y
```


