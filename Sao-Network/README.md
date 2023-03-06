<h1 align="center"> SaoNetwork Node Kurulum </h1>
<div align="center">


![ss](https://user-images.githubusercontent.com/76253089/223120665-7831ebca-6019-416a-accc-e7569343705e.png)


<h3>
  
Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
</h3>
  
</div>

### Minimum Gereksinimler
* İşlemci : 2 Cpu
* Bellek : 4 GB RAM
* Depolama : 160GB SSD

# Sunucu Güncellemesi

```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go
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
# Binary Kurulumu
```
git clone https://github.com/SaoNetwork/sao-consensus.git
```
```
cd sao-consensus
```
```
git checkout testnet0
```
```
make install
```
```
saod version
```
# İnitalize
* `MONIKER` değiştirmeyi unutmayın.
```
saod init MONIKER --chain-id sao-testnet0
```
# Genesis ve Addrbook
```
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Sao-Network/genesis.json > $HOME/.sao/config/genesis.json 
```
```
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Sao-Network/addrbook.json > $HOME/.sao/config/addrbook.json
```
# Peer
```
peers="a5298771c624a376fdb83c48cc6c630e58092c62@192.18.136.151:26656,59cef823c1a426f15eb9e688287cd1bc2b6ea42d@152.70.126.187:26656,e96613a87f825269bf81ece62a9c53e611f0143c@91.201.113.194:46656,91b67dd0d2904d95748e1ec5311e39033cfeaabc@65.109.92.240:1076,af7259853f202391e624c612ff9d3de1142b4ca4@52.77.248.130:26656,c196d06c9c37dee529ca167701e25f560a054d6d@3.35.136.39:26656,87aae9e66b092c79c6e5e1a7c64ec21128359f7e@144.76.97.251:37656"
```
```
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.sao/config/config.toml
```
# Min gas price
```
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0sao\"/" $HOME/.sao/config/config.toml
```
# Pruning ve İndexer
* bu kısım opsiyonel. daha az dopalama alanı kullanımı için yapabilirsiniz ama ram ve cpu daha fazla kullanılır.
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.sao/config/config.toml
```
```
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.sao/config/config.toml
```

# Service
```
sudo tee /etc/systemd/system/saod.service > /dev/null <<EOF
[Unit]
Description=sao node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which saod) start --home $HOME/.sao
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
# Node başlatma
```
sudo systemctl daemon-reload && sudo systemctl enable saod && sudo systemctl start saod
```
# Log kontrolü
```
sudo journalctl -u saod -fo cat
```

# Cüzdan
* Mnemonicleri kaydetmeyi ve saklamayı unutmayın.
```
saod keys add wallet
```
### [Faucet](https://faucet.testnet.sao.network/)ten test tokenları alın

# Validatör
### Arkadaşlar validatör oluşturabilmek için nodenizin ağ ile senkronije olmasını beklemeniz gerekiyor. `sudo journalctl -u saod -fo cat` komutundaki `height`sizin nodunuzun ulaştığı blok yüksekliğini gösteriyor. Bu [Explorer](https://explorer.sxlzptprjkt.xyz/sao) ile aynı bloğa ulaştığı zaman nodunuz ağ ile senkronize olmuştur.
### `moniker`, `website`, `identity`, `details` kısımlarını kendinize göre değiştirin.
```
saod tx staking create-validator \
  --amount 900000usao \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.06" \
  --min-self-delegation "1" \
  --pubkey  $(saod tendermint show-validator) \
  --moniker MONIKER_ISMINIZ \
  --website "WEBSITE_ADRESINIZ" \
  --details "DETAY" \
  --identity KEYBASE_ID \
  --chain-id sao-testnet0
```
















