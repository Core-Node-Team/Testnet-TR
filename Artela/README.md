
![artela](https://github.com/molla202/Artela/assets/91562185/a7922117-442e-4bbf-b56a-1d11e09670f7)

## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Artela Resmi Websitesi](https://artela.network/)
 * [Artela Resmi Twitter](https://twitter.com/Artela_Network)
 * [Artela Resmi Discord](https://discord.gg/TzmnmuCU)
 * [Artela Dökümantasyon](https://docs.artela.network/develop/node/run-full-node)
 * [Artela Tüm Linkler](https://linktr.ee/artela_network)
 * [Artela EXPLORER](https://test.explorer.ist/artela/staking)


Not: teşvik bilinmiyor...

### Not: faucet almak için cüzdan olusturduktan sonra altaki kodla adresinizi öğrenin Address (EIP-55): adresiniz burda yazıor
```
artelad debug addr art-ile-başlayancüzdan-adresinizi-yazınız
```



### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4 vcpu|
| ✔️RAM	| 8 GB |
| ✔️Storage	| 200+ GB SSD |
| ✔️UBUNTU | 20or22 |


### Update ve gereklilikler
```
apt update && apt upgrade -y
apt install curl iptables build-essential git wget jq make gcc nano tmux htop lz4 nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
```
### Go kurulum
```
ver="1.20.3"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
### Varyasyonlar (moniker ve cüzdan adınızı değiştiriniz)
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="test"" >> $HOME/.bash_profile
echo "export ARTELA_CHAIN_ID="artela_11822-1"" >> $HOME/.bash_profile
echo "export ARTELA_PORT="45"" >> $HOME/.bash_profile
source $HOME/.bash_profile

cd $HOME
rm -rf artela
git clone https://github.com/artela-network/artela
cd artela
git checkout v0.4.7-rc6
make install

artelad config chain-id artela_11822-1
artelad init "$MONIKER" --chain-id artela_11822-1

wget -qO $HOME/.artelad/config/genesis.json https://raw.githubusercontent.com/Core-Node-Team/scripts/main/artela/genesis.json
wget -qO $HOME/.artelad/config/addrbook.json https://raw.githubusercontent.com/Core-Node-Team/scripts/main/artela/addrbook.json


SEEDS="8d0c626443a970034dc12df960ae1b1012ccd96a@artela-testnet-seed.itrocket.net:30656"
PEERS="7999edc7be16d834ef7b1f28104b89d6d5f81eda@66.94.126.195:3456,27545c44ac47b25a4db84d8a7150b1a8c0b7c219@95.216.70.52:3456,a3604f1122ef9f22be159c0ff80e0ab56190cef2@84.247.171.206:3456,27df3ed3007aa55a2a45aa3adf11737bbfcebc74@45.144.234.159:26656,f780514c4530720ee7a52cdd9703ff6bd6bb7a11@184.174.36.49:26656,b15998db899f0b89b45fe8324001e618560f3a50@154.38.180.99:3456,5a30a57992bf0b2d2c5c289a9a7b6d3c9b88a5e0@213.199.56.75:30656,7bb0d044df32335626c072f06452d1f70e16ed5b@161.97.83.205:26656,6406e7f15cab6fbcdb47f0a99155ef61fdef6cad@207.180.240.170:25656,8b7197aef087a286bdb16ea576f193958dc60f6c@173.212.240.21:45656,615efb4ad2cbaebc8433eb4aac11043e60cd675d@109.199.104.0:26656,0c1c43c1b334a03aea9140428593839f1c9b0f24@154.53.58.46:3456,8d7c55651c6a9c0a8b1af8b3e017502b1d36830f@158.220.82.111:3456,e6586cbdd9497d040d512f1115bfcde33e6e256f@37.60.248.9:45656,2585c1d79622e47ff20bef7832d3fd14719fb10d@194.163.165.63:3456,55e03f7dab4288c3dc3e93257f4e063c862f0561@109.199.124.254:26656,fcdc48b1365b1846f0a7249687d110b6ee18517a@158.220.124.179:3456,68731e9ac2073e47f4f02799c87babe8cd098998@84.247.178.62:45656,62ac13c2f93bec58914cd47a164ba1cdd7911218@37.60.228.140:3456,7784eb2838bc05c850f8a968abcad8d2b3f36c25@185.185.83.35:3456,9f59d8759e2a94bf8204bb6c0327d266b98a0308@194.163.167.191:3456,adacfbd6f059e7fdce0aff120c2a275d78569215@2.58.82.7:3456,22586cab75548f16ca0eed7f9a1e1c634ec2d9f2@161.97.156.34:3456,6db6e43852adf05deb46c32837919937826d9b5e@109.199.113.217:30656,a4b81662b44c89696cef0e37bb84a0f921c9e164@37.120.178.205:56656,035a52ede679f50a696fd0b8e1afc52b7ac3dac1@37.60.255.54:3456,e87a90f600dd4e1415f39421d885bde824586c67@161.97.109.65:26656,3ad74c3a5d6cdfa443d587c0afe41595ebca65e7@185.217.125.169:3456,1b65c4da3bdefe93348623b30e318b87bf697220@109.199.102.78:3456,0b47eafd152898fb99fdd6785489684001be1240@37.60.228.141:3456,53ea4c5585b76bb0974fa76ba0a170add3754d88@167.86.127.105:23456,381053f80ab6b88e70a06cd371b4d44b67b01bb0@154.53.62.125:3456,c2cdf5952b6d5fe2cb6189a6433c8fb77422973d@38.242.153.128:26656,adf9061a0ae858f87f4f7930eb948cad08d02eb6@84.247.171.212:3456,bc70a5e753e7cf16d9aa6b6aa0ef8ce195f4cbc0@66.94.122.59:3456,78a145c45a617ec14ae6a9f473c9d72f3a7df5fb@109.199.119.246:30656,63d32bb3d8567191b687d38f69b61db624ad97e3@109.199.124.249:26656,ac017a948dbceaa6d32c22bb66526db9ca32aa02@109.199.105.121:25656,744f6660ee2724776792a39d1535cd2b8582b126@89.58.26.221:56656,d139176263d2744f15ea9ea780be3aa7445b42fc@37.120.191.196:56656,21278ff099053f1c02abf8eac87a6a717996e281@185.252.235.62:26656,b1d5c4ce939bbeb80aaf25c8b1ed57b32a49a0e2@178.18.253.187:45656,e95a746ad42eb2b2cec8a4af68d65bcb45f48825@89.58.16.102:26656,eb6fe7febc3995d3338fd9adb454ff24bed5dfcd@144.126.146.17:3456,f8d09c28488760222ccfd2b0573278cf07090f2c@38.242.198.48:26656,12dd4130981ae90122f0b9497e92925b016f101a@185.209.230.127:45656,b83526e280f1180ffd2a7e648263680ce3d81103@109.199.101.247:3456,08a11bb3d31324f4d134917e86111fbacb9bea58@194.163.162.53:3456,8f3b1b703a716b1779a097f5300965c4758a3520@207.180.229.108:45656,b27334c54889c7d3bf17ede7659afa3fdeea04ba@154.53.63.241:3456"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.artelad/config/config.toml


sed -E 's/^pool-size[[:space:]]*=[[:space:]]*[0-9]+$/apply-pool-size = 10\nquery-pool-size = 30/' ~/.artelad/config/app.toml > ~/.artelad/config/temp.app.toml && mv ~/.artelad/config/temp.app.toml ~/.artelad/config/app.toml


sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.artelad/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.artelad/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.artelad/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.artelad/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.025art"|g' $HOME/.artelad/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.artelad/config/config.toml
sed -i 's|^indexer *=.*|indexer = "null"|' $HOME/.artelad/config/config.toml

# set custom ports in app.toml
sed -i.bak -e "s%:1317%:${ARTELA_PORT}317%g;
s%:8080%:${ARTELA_PORT}080%g;
s%:9090%:${ARTELA_PORT}090%g;
s%:9091%:${ARTELA_PORT}091%g;
s%:8545%:${ARTELA_PORT}545%g;
s%:8546%:${ARTELA_PORT}546%g;
s%:6065%:${ARTELA_PORT}065%g" $HOME/.artelad/config/app.toml

# set custom ports in config.toml file
sed -i.bak -e "s%:26658%:${ARTELA_PORT}658%g;
s%:26657%:${ARTELA_PORT}657%g;
s%:6060%:${ARTELA_PORT}060%g;
s%:26656%:${ARTELA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${ARTELA_PORT}656\"%;
s%:26660%:${ARTELA_PORT}660%g" $HOME/.artelad/config/config.toml

sudo tee /etc/systemd/system/artelad.service > /dev/null << EOF
[Unit]
Description=artela node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which artelad) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

### snap
```
artelad tendermint unsafe-reset-all --home $HOME/.artelad --keep-addr-book

curl -L http://37.120.189.81/artela_testnet/artela_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.artelad
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable artelad
sudo systemctl start artelad
```
### Log
```
sudo journalctl -fu artelad -o cat
```

### Cüzdan olusturma

artelad keys add cüzdan-adı

### validator olusturma
Not: 2 defa faucet alıp yapın.moniker ve cüzdan adınızı yazınız
```
artelad tx staking create-validator \
--amount 950000uart \
--from cüzdan-adınız \
--commission-rate 0.1 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--pubkey $(artelad tendermint show-validator) \
--moniker "moniker-adınız" \
--identity="" \
--website="" \
--details="Mustafa Kemal ATATÜRK❤️" \
--chain-id artela_11822-1 \
--gas auto \
--gas-adjustment 1.4 \
--gas-prices 0.055uart \
--node http://localhost:45657 \
-y
```
### Delege
Not: cüzdan-adınız kısımlarını değiştiriniz.
```
artelad tx staking delegate $(artelad keys show cüzdan-adınız --bech val -a) 1.5art --from cüzdan-adınız --chain-id artela_11822-1 --gas-adjustment 1.4 --gas auto --gas-prices 0.025uart --node http://localhost:45657 -y
```

## Başvuur formu : [TIKLA](https://t.co/EPAoUcWriG)https://t.co/EPAoUcWriG
