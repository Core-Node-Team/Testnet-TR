<h1 align="center"> Cascadia | Devnet </h1>

<div align="center">

![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/e8021857-3241-492d-a10b-9df8dda62f0b)



#  | [Twitter](https://twitter.com/CascadiaSystems) | [Discord](https://discord.gg/cascadia) | [Website](https://www.cascadia.foundation/) | [Telegram](https://t.me/+Tf6pQQSA7IkxNmU5) |

</div>

# Sunucu Güncelleyin
```
sudo apt-get update -y && sudo apt-get upgrade -y
```
# Kütüphaneleri Kurun
```
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go Kurulumu
```
cd
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile &&  . $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
```
# Binary Kurulumu
```
git clone https://github.com/CascadiaFoundation/cascadia.git
cd cascadia
git checkout v0.1.2
make install
```

# İnitalize
> #### MONİKER yerine hendi isminizi yazmayı unutmayın
```
cascadiad init MONIKER --chain-id cascadia_6102-1
```
# Yapılandırma Dosyası
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml
```
```
peers="001933f36a6ec7c45b3c4cef073d0372daa5344d@194.163.155.84:49656,f78611ffa950efd9ddb4ed8f7bd8327c289ba377@65.109.108.150:46656,783a3f911d98ad2eee043721a2cf47a253f58ea1@65.108.108.52:33656,6c25f7075eddb697cb55a53a73e2f686d58b3f76@161.97.128.243:27656,8757ec250851234487f04466adacd3b1d37375f2@65.108.206.118:61556,df3cd1c84b2caa56f044ac19cf0267a44f2e87da@51.79.27.11:26656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:55656,f075e82ca89acfbbd8ef845c95bd3d50574904f5@159.69.110.238:36656,63cf1e7583eabf365856027815bc1491f2bc7939@65.108.2.41:60556,d5ba7a2288ed176ae2e73d9ae3c0edffec3caed5@65.21.134.202:16756"
```
```
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.cascadiad/config/config.toml
```
# Genesis ve Addrbook
```
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Cascadia/genesis.json > $HOME/.cascadiad/config/genesis.json
```
```
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Cascadia/addrbook.json > $HOME/.cascadiad/config/addrbook.json
```


# Puruning ve İndexer
> ### İkisi de opsiyoneldir. Daha az depolama alanı kullanımı sağlar aynı zamanda daha fazla cpu ve ram gücü tüketir
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.cascadiad/config/app.toml
 ```
 ```
 sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.cascadiad/config/config.toml
 ```
 # Service Oluşturun
 ```
sudo tee /etc/systemd/system/cascadiad.service > /dev/null <<EOF
[Unit]
Description=Cascadia Node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which cascadiad) start --home $HOME/.cascadiad
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
# Node Başlatın
```
sudo systemctl daemon-reload
sudo systemctl enable cascadiad
sudo systemctl start cascadiad
```
# Log ve Sync
> ## `sudo journalctl -u cascadiad -fo cat` komutu ile logları takip edebilirsiniz.


> ### Validatör oluşturmadan önce sync olmayı beklemelisiniz.  Loglardaki `height` ulaştığınız blok yüksekliğidir. Bunu [Explorerdaki]() blok yüksekliği ile karşılaştırın.

# Cüzdan
> ### Şifre oluşturmanızı isteyecek
> ### Mnemonic kaydetmeyi ve saklamayı unutmayın.
```
cascadiad keys add wallet
```
> ### [Discordda](https://discord.gg/cascadia) `#faucet` kanalından test tokenlarını alın

# Validatör
> ### MONİKER yerine kendi isminizi yazmayı unutmayın


> ### Bu komuta isteğinize göre `--website` `--identity` `--details` flaglarını ekleyebilirsiniz
```
cascadiad tx staking create-validator \
  --amount 1000000000000000000aCC \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.06" \
  --min-self-delegation "1" \
  --pubkey  $(cascadiad tendermint show-validator) \
  --moniker MONİKER \
  --chain-id cascadia_6102-1 \
  --gas auto \
  --fees 300000000aCC \
  -y
  ```
#
#
# Faydalı Linkler

## [Komutlar](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Ortak-Komutlar.md)
## [Node Yedekleme ve Taşıma](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Yedekleme%20ve%20Ta%C5%9F%C4%B1ma.md)
## [Port Değiştirme](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Port%20de%C4%9Fi%C5%9Ftirme.md)
## [Sync-Peer-FAQ](https://github.com/Core-Node-Team/Cosmos-Aglarinda-Node-Calistirmak/blob/main/Sync-Peer%20Nedir.md)
