

![image](https://user-images.githubusercontent.com/108215275/222752592-efc59a5a-93d2-4ec8-a40f-098147e77e99.png)

# Resmi Linkler
## [Twitter](https://twitter.com/QuasarFi) | [Discord](https://discord.gg/quasarfi) | [Website](https://www.quasar.fi/) | [Telegram](https://t.me/+shSFVLA14B4yNmM6) | [Github](https://github.com/quasar-finance/) | [QuasarDocs](https://docs.quasar.fi/)      

## Bu rehberi hazırlarken yararlandığım kaynak: [Link](https://docs.quasar.fi/networks/intro)
## Testnet duyurusu: [Link](https://www.quasar.fi/blog/quasar-s-public-testnet-is-live-introducing-orion-our-first-vault)
## Ödül ile ilgili açıklama
![image](https://user-images.githubusercontent.com/108215275/222756124-0cfa396a-1d39-47a0-afd1-3fb17c857600.png)

## Gereksinimler (min):
```
4 CPU 16GB RAM 500GB SSD
```
### Kurulumu 4vCPU 8GB RAM 160GB SSD olan bir sunucuda yaptım


# Sunucu güncellemesi ve gerekli kütüphanelerin kurulumu
```
sudo apt-get update -y && sudo apt-get upgrade -y
```
```
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go kurulumu
```
cd $HOME
wget -O go1.18.4.linux-amd64.tar.gz https://golang.org/dl/go1.18.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz && rm go1.18.4.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version
```
# Binary kurulumu
```
mkdir -p $HOME/.quasar/genesis/bin
wget -O $HOME/.quasar/genesis/bin/quasard https://github.com/quasar-finance/binary-release/raw/main/v0.0.2-alpha-11/quasarnoded-linux-amd64
```
```
chmod +x $HOME/.quasar/genesis/bin/*
```
```
ln -s $HOME/.quasar/genesis $HOME/.quasar/current
```
```
sudo ln -s $HOME/.quasar/current/bin/quasard /usr/local/bin/quasard
```
# İnitalize
```
quasard init MONIKER --chain-id qsr-questnet-04
```
# Yapılandırma dosyası ayarları
```
curl -Ls https://snapshots.kjnodes.com/quasar-testnet/genesis.json > $HOME/.quasarnode/config/genesis.json
```

```
curl -Ls https://snapshots.kjnodes.com/quasar-testnet/addrbook.json > $HOME/.quasarnode/config/addrbook.json
```
```
sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@quasar-testnet.rpc.kjnodes.com:48659\"|" $HOME/.quasarnode/config/config.toml
```
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0uqsr\"|" $HOME/.quasarnode/config/app.toml
```
# Pruning
* Bu kısım opsiyonel, daha az disk alanı kaplaması için bunu yapabilirsiniz ama işlemci ve ram daha çok çalışacağını unutmayın.

```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.quasarnode/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.quasarnode/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.quasarnode/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.quasarnode/config/app.toml
```
# İndexer
* Bu da opsiyonel, pruning gibi
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.quasarnode/config/config.toml
```
# Service dosyası
```
sudo tee /etc/systemd/system/quasard.service > /dev/null <<EOF
[Unit]
Description=quasar
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which quasard) start --home $HOME/.quasarnode
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
# Nodu başlatın
```
sudo systemctl daemon-reload
sudo systemctl enable quasard
sudo systemctl start quasard
```
# Logları görüntüleme
```
sudo journalctl -u quasard -fo cat
```

