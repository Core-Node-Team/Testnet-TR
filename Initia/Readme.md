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
PEERS="fa1a2737a2f971afb76f96677265288b9322db56@38.242.217.29:15656,3d1420fe98bfc8928d1bbd1cf2843bce00139a1e@84.46.247.4:14656,9f0ae0790fae9a2d327d8d6fe767b73eb8aa5c48@176.126.87.65:22656,ce4eb94dbb0abb8496347f4480d15027ab817088@31.220.76.14:26656,68bde047e9e4626e6d701cb784036959d9e75e3a@185.216.75.49:14656,92ad95d40cdb179fd5d6ab4b28a2e111cebb7386@149.50.111.209:14656,733b32a845afe208ae2f0ac525a2dcf2ed6799a9@161.97.105.175:14656,90e783357d29891e420939559a975d4fe4a494cc@185.223.93.191:26656,26fc32867cf3a5130cc2739a65804c51ed1afd0b@45.85.147.100:14656,2bcda81635d22fad329291d6ec6b45e0f821adc1@149.50.111.20:14656,1e387f4bd869f4e072f6b1c5add05011202feb91@195.179.229.53:26656,5a32a7b6b3967f867f9136fecc11cd805def19e9@152.53.14.247:17956,651f2535f76ed483e1c3c4adcca158a77d3c9afc@149.50.113.80:14656,6ad7310bc734115fb528bcda08d5995e4fc82803@194.195.87.173:14656,10144d4bc16ae03c0bc0674a1883a1298cd578de@83.171.249.192:14656,b23e5306b35d7039796069fa9c9b0ab2a883f2b1@84.247.162.207:27656,67b6ad099601545159704d6ae0fd37358c2c80aa@23.22.190.44:26656,161aac538322bb660dba7e5893a3d70602bdebac@95.216.2.176:26656,439f3f661eb1412133f4b310e1309b191a682367@86.48.1.138:14656,4478d15c1ef48f3a1b4e5036625df45ffa634f22@149.50.109.40:14656,de31968f3b35942b5a1123998ff0c4ebd3c3aae5@88.99.193.146:26656,6a6d164766341e4e4f56d0359f130a757f21851a@95.217.148.179:29656,8d2c34e523566e64988a9a40f364a0f08993d601@149.50.112.39:14656,57a9c6967bb9a0885b090d4a7108ff516fbc1be8@88.198.50.206:26656,0b108b734b37f3cee0217c6a65e8d5bff35fb45a@142.132.146.185:50156,04473116e3a85f144bad880b2275effb4220d763@149.50.114.165:14656,eddbd4b58fc21afa52329e42e920cf35cf10bf5e@94.72.116.120:14656,96f24b01f232135b7acd4a8b5e93572eb9d7a8cf@149.50.112.136:14656,269b6646a4102bebe4944ba2c6bd578745068e87@89.117.55.82:14656,86a96159def49322d7a3497138bd708a11ca3c79@149.50.111.144:14656,b49f285388716964f177bface1841522a6bb385a@149.50.111.150:14656,1c323cfcbb9f74d2260af06dcc8cae3c792d689d@149.50.113.198:14656,b2f6fd85e7ebf4eca72bfe24cbb482cf512644ae@161.97.83.155:14656,8d1ae8f595567ebcebb36484b2b4fa5a2bb33aca@84.46.251.85:14656,41453d8197207ce8834a672896eddf941f5b745e@125.131.208.75:26656,ca5600a076e5b165173a6e99614cbb964efd177e@178.254.39.176:16656,67c0f5b2e50a53a15d7f9cf34cacb1cb49b5dafd@194.163.191.73:14656,29ed6548da79f47c194449afa797c6389da1099a@149.50.113.169:14656,72b8b9f0e826fa9be3f5ab55f56e67d409f0cef8@185.197.250.199:51656,cd32aeb3f5d9a474128f75bdf5cd216c24dbfb65@75.119.131.26:14656,17b0fb616bae3fc2e6babf717e2ec132353142db@51.195.88.136:15674,6f06f63189972ba97c883a970af237703aefcde1@89.117.58.216:26656,0f1151f23c08acde3019196280f902ae0ae62bb3@51.83.236.99:26656,1eccf0b75519cdaa402a87469e25faab8d67b62d@185.192.97.24:26656,8db320e665dbe123af20c4a5c667a17dc146f4d0@149.50.96.153:26656,0f5e3f72b1dc6d657d65f4f6b74f0f32b69758fd@213.239.218.219:50156,e420cecc58552c067a4477984c665c2967524e9c@89.117.61.243:26656,c04526a0a50bd2d40aa957b9d6d6b1a0492f133a@146.190.132.179:26656,2b86a844710e83178ec33311c228e6a4b53a560a@5.78.105.174:44656,303155b38cb9f7d4d264c1f51379088e11d53e5b@45.10.154.243:33756,492474b468643c36883fa4b6fa47af2b5c2b8c19@193.46.243.32:14656,74ea98d53e1442f67d7aff05a2c597f4aa0d98c4@89.117.61.168:26656,b5a6a4e83f23035ceb245abda0cefceb8b49d5c5@164.68.100.187:15656,024b615f6a5e5a03e3a5929be65c06c0e8eaa706@217.76.51.182:17656,31de0f9d8d100bd8f94987f54efcaa28415e2806@162.0.226.227:26656,4692780b85a00b74d6332218ef989101b58e5b45@149.50.107.87:14656,f3c82922f38adc2271f4a8b4ccb90680eb048b11@149.50.113.42:14656,0168b241db9dd3ab64f3c9144f18b45170a1426a@84.54.23.111:17956,d704d363fb7e6c19df7f2e57b41e54d34ebb4bac@103.219.171.22:26656,1409825f99073ddd376e4579f594053ed2bd45f3@194.163.183.197:26656,b65c692cd179c9bd3e99c3a9d8ccfa7b2e3ec556@167.86.123.182:14656,b73ae4b3df5ea0c7827254f20b9cbc608f0dc69d@195.201.197.160:26656,0b81a3126dc9e3545c54a3fe7ddfc7dad01de448@149.50.113.244:14656,1902ac5c3388a2473e86e78acea67c24fc907ac4@149.50.109.19:14656,b9561cc582b2686d7e66816af6730d700f282fbe@65.108.201.18:51656,d9eaca310f734e7fe252408d48187452796d350c@157.173.192.85:656,c2912cdba5d52b835790b000709635286aba2c47@38.242.228.252:26656,32756a5b2576d48561d20e93544290019418d2a2@45.8.132.174:26656,a5ef95fb339efb76f9e9028000861bb99521511e@89.117.60.193:14656,e1e8624f456c6871e640975b6d961b6ead032cd7@38.242.240.202:26656,9c3ec4d1c63facd3c27f4375577bbfc3b216f188@45.10.154.165:26656,0f4ff5974f188dcad6d8d14abcd425d20adf2a14@194.242.57.198:14656,0028900e524f551614c4128aade4bf49f8988328@38.242.147.101:26656,81e87a0ac2e7665aa8e118509978b68869c1e720@159.89.108.133:26656,31f11dba738bcf979f1077f894f9d46f7e70f03d@149.50.109.61:14656,65017c82a3bf6437fc2466c14c0be12f5515aa93@149.50.114.137:14656,21cd203eb451f85dce0b87e5d08ffe4d8db24713@34.126.129.53:26656,bed55ace8bd4dfc3de2e50e4f96636cc24ce1728@38.242.148.54:26656,3b6a4c5ede20a38ad254909ac78ff73e0a4ca3b7@109.199.117.4:19656,cc42341dfd0b1327931cdb89f9bf61a6a9bf3a00@86.48.0.176:14656,557dcf2b571ee27225e56a3cf766abaeb23e9ff3@38.242.250.253:26656,461a060291521556ea8927e0ec1a78e39af5d919@207.180.236.138:26656,ff9dbc6bb53227ef94dc75ab1ddcaeb2404e1b0b@162.55.65.140:26656,b631f4a06b679e1979ff8974744b6d4e1dfcd0de@88.180.180.141:26656,6e2155096cdc1c178740415affc256882c44f671@38.242.255.182:14656,8f9f905d14b6283f9ab971b52e846202a41ad7f1@65.109.117.113:25756,06675e0711f347a6d63abf23d9dbee10c474208b@149.50.107.88:14656,911e6dc9b21cc37bf6c0b09e86a426304a927cfa@51.91.31.25:26656,c56ab2c4a718d781491218b02ca79bab5fe2f4d6@65.108.69.56:17956,d54ffe3c32de95269d1e05f0b0de22f631474dcd@75.119.139.23:26656,ac42ea16b0cf3d1a3def68fea7714f167baf3ee7@38.242.253.128:39656,50409fa407bc47fee29ce5c440d3e3bf110c2a42@161.97.101.38:14656,04319189c9ec7f7d39aaea2e3eb7153b34d9c754@149.50.114.45:14656,23dcf1e91dbcb6f8ce4daf0e91d5778d086f4045@45.8.133.207:26656,d9b8e50ac286b2e647e4b627935cd225b4c6ceaf@109.199.97.152:656,30444c032b7065451de1d94e6eff6bde1ec082c0@149.50.113.227:14656,a01b70f4e70eb4d0d6d9f43cdb75c032194ca539@45.8.133.210:15656,10f692a91b89c8ad2d7f90d6f1f01886fdaba4ac@173.249.21.251:26656,10f20a0f79f48736dad1e3538861f40d015a584d@167.86.124.160:14656,1c18aa30e98db215c226a5990f83fa868ec6be3d@149.50.113.200:14656,9fdb5d612cfef209e4b3816302943da1e0536ce9@65.108.131.189:26100,d9307b245c045f505edeeb823b9414d1b921727d@109.199.100.50:26656,ff98288d57c5bbb4aa5a1d5783c6b6d3aa152f95@148.113.6.114:26656,34b789bb9c2618418f14d5676d0f8f634f0c1fe8@149.50.114.42:14656,908aecde9bae2e902e0ca20d01dc381b142570d4@158.220.123.94:14656,33d0af5236224a7dac61447b71f5be723544778d@38.242.207.19:17956,3f6682ce84e5316441f4c8c614476d445256261a@194.113.67.157:26656,458777086d62fd0671104d033ea891c585bc7fe8@149.50.109.234:14656,0433409daa3ed448837a5bef5ef434013f1e7993@86.48.5.68:26656,8ce12c76df8416aa8dc9e624fffa39cbbe41391d@149.50.114.193:14656,739cf12fac108e6d0933e6476c43460b6014a93b@167.86.74.206:14656,7dad293c1bbb539b523afdd58f564c74f18e37cf@135.181.238.30:26656,52e94af65a17f46c6c47d6b41dc30a535565b9bb@149.50.111.117:14656,4f3e4826b7496b21eb85d4d9b558c29923787e03@149.50.109.227:14656,a98e47c02763d05f2a9623cb67e8e40e0d06504a@5.9.70.180:15674,7788ae0e47593edba4fb602654961e489c435d97@194.242.57.44:14656,7b14cf28c6f7ebec37a90702ffef009b2cf93106@195.201.169.186:26656,86e1e99ad62b6f5b46bed0001bf947c4255d2dce@144.91.70.205:14656,780d5f14bfc092493a22f0a4a3c55fbe510e5d92@173.249.51.77:14656,0b1613dc0af34bd910f25aeb0bd35c51d6c7a226@164.68.102.43:14656,3faaa07eb466328e75dcf79778c4f550f5fffc1a@94.232.244.80:26656,eafdd2627f19ee8d01a01c70c066d1339c358715@149.50.109.246:14656,297fec5674eec9fbd63b10d6e39c86bd71d6a95e@154.26.130.65:17956,548e26b95b895efc964b08a6b2e991c6d5a6791d@142.132.151.35:15674,b8c2deec30e6956322ed97aa2b2c5ae05f22d87e@51.79.230.130:17956,450b1409f7d4c1f837ba4f33a106735b996d5ee8@149.50.112.35:14656,f0ce538966f453b6b972cbd4f98ab82c2da00422@149.50.109.211:14656,a113be602a379b93604884b17c49275c64661c7a@89.117.60.52:14656,6e2eed68ac5442dc9e8ef5878ce17dda7553e019@173.212.247.166:14656,cbb69270978528e176271520200c9df05101c6b8@149.50.114.240:14656,7a221dacb34a2781c214387f9a9fbc6e3f722d74@149.50.114.138:14656,7aa00d964f3cbc8cefd29fa119aa35420fd12fc5@149.50.109.137:14656,bd4ad0aace54be4115943a0e896ee32cb386a988@185.234.69.39:14656,91a0f975e2cc49d1a90724036a9df7005c7f9e4b@93.188.162.253:26656,3d21bfb9c91be253dbdfaac52588b9e1855fa233@84.46.243.10:14656,e6e71f252fea56684d825b1c47df37d6f5437354@5.9.104.206:26656,a74f835c701ba815aa3b708e4dcb8dc0e1b01a14@144.91.79.33:14656,f587d09754197a00ef026fe2e3e1936113554bd7@5.180.24.17:26656,875ee19218c201f2482e29db67a8cebe072f86b6@183.110.214.229:26656,4b558d7224dca471655bb16eded79d47f0bac5ed@213.199.63.29:39656,8991127b6aba6d834bfcde97130b8970db2db123@43.133.57.18:27656,86ef54e9beb4fd5bdd94d8f26a57b1cf3a3aa269@65.108.129.239:26656,afcad4e5bd4f22449bbd600230224575a6ba190c@149.50.114.37:14656,8dc312bc7caba46f001a73449170d050387c915a@149.50.107.240:14656,3866d5a8fcecc3647511ffd938066a801bf41731@149.50.107.200:14656,6387826b3b325138ba6d11650b1d2fdfdf18a4d2@149.50.111.33:14656,10b173a6c692fc1d258c10689e7adbc6d0b22ce3@162.55.242.213:55656,8c5932cf40c1c3007fbd97c9d21c09821b8a0f52@154.26.138.31:26656,fd53d70bbee23775d2d9142894e4229321eca214@109.199.98.178:16656,f4e17f407bdae3aaccec2315e98caf422fbbd993@161.97.136.152:26656,6d90dd5e75f1fd70915639bab7bf89560f1b952d@149.50.107.31:14656,4b1f84f5d332b7bc60e857f2bfde6361b2168fb3@95.217.100.225:17956,76b0ee2d10ac4f1fef1b210b0364b15f8fa25d72@94.72.116.147:14656,697cd70147c7fcd16cf00ad39fe1217a35e2db15@38.58.183.3:31656,a1910e8378bd6c224d2ab54ed3ad8570da515207@37.27.117.213:37656,e4285d88ae124a6ba1446bdc5340ec8446aa46e8@193.34.213.76:26656,3454bd4fe68948de5c568e214ca50cb049f70710@75.119.133.37:26656,bd225058c6a00d0b92b1d02c0299e83511ddcb54@38.242.193.24:53456,745e4f73e0d77d34dab6f2e2cbac96ac7fc15786@85.190.242.204:26656,cd61235a2b8de8b5f421eeabd1ad5c23371587e8@65.109.30.35:15656,66abd758f6971eb8227fc54d11cb56ca1ca280e6@65.109.113.251:13656,59fb8058c2a682e96f529056d0b1bd8f40cfff7f@38.242.214.145:26656,277a8eb7cd42f96c2339864640d96d3c417e003c@31.220.89.15:26656,c1d07588f2e116090e43dbbd58f34b2b449ca518@194.163.174.193:26656,947868b49bf1821344cb482cf09addfd8c744967@65.109.28.27:51656,a82c32e142fd6535d32f67b7c3f63c26f09c316e@144.91.70.48:14656,0edfd664a49319e71813371ba61aa47716a6dc96@123.101.108.245:53456,c28827cb96c14c905b127b92065a3fb4cd77d7f6@134.209.85.88:25756,5158609391487f6d03d15ccfd5cb863e2272543b@88.99.61.53:37656" && \
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



