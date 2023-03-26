<h1 align="center"> Gitopia Testnet Kurulum Rehberi </h1>
<div align="center">


  ![image](https://user-images.githubusercontent.com/108215275/227787597-34a08c0a-9c2d-45ce-8e1c-775796de67d1.png)


 <h1>
 
   Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
 </h1>
  
</div>


# Sunucu güncellemesi ve gerkli kütüphanelerin kurulması
```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go kurulumu
```
cd $HOME
wget -O go1.19.1.linux-amd64.tar.gz https://golang.org/dl/go1.19.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz && rm go1.19.1.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version
```


# Gitopia binary kurulumu
```
cd $HOME 
rm -rf gitopia
curl https://get.gitopia.com | bash
git clone -b v1.2.0 gitopia://gitopia/gitopia
cd gitopia 
make install
```

# İnitalize
> <MONİKER> yerine kendi monikerinizi yazın
```
gitopiad init <MONİKER> --chain-id gitopia-janus-testnet-2
```

# Genesis ve Addrbook
```
wget -O $HOME/.gitopia/config/addrbook.json "http://65.108.6.45:8000/gitopia/addrbook.json"
wget https://server.gitopia.com/raw/gitopia/testnets/master/gitopia-janus-testnet-2/genesis.json.gz
gunzip genesis.json.gz
mv genesis.json $HOME/.gitopia/config/genesis.json
```
# Seed ve Peer
```
SEEDS="399d4e19186577b04c23296c4f7ecc53e61080cb@seed.gitopia.com:26656"
PEERS=""
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.gitopia/config/config.toml
```
# Puruning
> Disk yerini azaltmak için
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.gitopia/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.gitopia/config/app.toml
```
# İndexeri kapatmak
> Disk yerini azaltmak için
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.gitopia/config/config.toml
```
# Minimum gas price
```
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0utlore\"/" $HOME/.gitopia/config/app.toml
```

# Prometheus
```
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.gitopia/config/config.toml
```

# Service Dosyası
```
sudo tee /etc/systemd/system/gitopiad.service > /dev/null <<EOF
[Unit]
Description=gitopia
After=network-online.target

[Service]
User=$USER
ExecStart=$(which gitopiad) start --home $HOME/.gitopia
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
# Başlatma
```
sudo systemctl daemon-reload
sudo systemctl enable gitopiad
sudo systemctl restart gitopiad 
```
# Loglar
```
sudo journalctl -u gitopiad -f -o cat
```
# Cüzdan oluştuma
> `<cüzdanismi>` yazan yere kendi belirlediğiniz cüzdan isminizi yazın.
```
gitopiad keys add <cüzdanismi>
``` 
> Mnemonic kaydetmeyi ve saklamayı unutmayın
 
> ## Cüzdanınızı recover etmek için
```
gitopiad keys add <cüzdanismi> --recover
``` 
# Validatör
> ### Eğer daha önce başka bir sunucuda validatör oluştusuysanız ve yeni sunucuya taşımak istiyorsanız bu adımı yapmayın.
> ### [Node Taşıma](https://github.com/Core-Node-Team/Cosmos-Aglarinda-Node-Calistirmak/blob/main/Yedekleme%20ve%20Ta%C5%9F%C4%B1ma.md)
 
> ### Arkadaşlar validatör oluşturmadan önce nodenizin ağ ile senkronize olması gerekiyor.
> ### [Senkronizasyon Nedir](https://github.com/Core-Node-Team/Cosmos-Aglarinda-Node-Calistirmak/blob/main/Sync-Peer%20Nedir.md)

> ### Bu komutta `<cüzdanismi>`ve `<MONİKER>` kısımlarını değiştirmeyi unutmayın.
> ### Bu komuta isteğe bağlı `--website`, `--identity` ve `--details`  flaglrını da ekleyebilirsiniz.
```
gitopiad tx staking create-validator \
  --amount 8000000utlore \
  --from <cüzdanismi> \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.06" \
  --min-self-delegation "1" \
  --pubkey  $(gitopiad tendermint show-validator) \
  --moniker <MONİKER> \
  --chain-id gitopia-janus-testnet-2
```






