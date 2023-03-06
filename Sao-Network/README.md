<h1 align="center"> Sao Network Testnet </h1>
<div align="center">


![ss](https://user-images.githubusercontent.com/76253089/223120665-7831ebca-6019-416a-accc-e7569343705e.png)

  
</div>

# Sao Network
> ## ***SAO Network, Hedra Labs tarafından desteklenen Web3 için merkezi olmayan bir depolama altyapısıdır. Web3 içerik depolamanın benimsenmesini artırmak ve ekosistem uygulamalarını kolaylaştırmak için Cosmos SDK ve IPFS'ye dayalı merkezi olmayan bir depolama protokolü sağlar.***
> ### ***Sao Network resmi hesapları: [Twitter](https://twitter.com/SAONetwork) | [Discord](https://discord.gg/KMhCKkjd) | [Website](https://www.sao.network/) | [Medium](https://saonetwork.medium.com/) | [SaoDocs](https://docs.sao.network/)***
> ### ***Sao Network tarafından yayınlanan testnet ile ilgili dökümanlar: [link1](https://saonetwork.medium.com/sao-network-announces-testnet-0-launch-320e489e787f)|[link2](https://saonetwork.medium.com/a-complete-guide-to-sao-network-testnet-e70117bd294)|[link3](https://saonetwork.notion.site/Testnet-0-FAQs-f2f7f4a745c04034984e3af509b12166)***
> ### ***Arkadaşlar bu testnette yapacağımız üç aşama var;***
> ### ***Birincisi full node kurup validatör oluşturmak.***

> ### ***İkincisi Sao Storage node kurmak.***

> ### ***Son olarak da Sao networkte modül oluşturucaz. Bu işlemi [Notater](https://notater.sao.network/) platformundan yapabilirsiniz (platform şu an çalışmıyor) ya da sao cli client ile sunucu üzerinden yapabilirsiniz.***

> ### Bu rehberde ilk olarak full node kurulumu ve validatör oluşturma ardından storage node kurulumu son olarak da cli client kurup modül oluşturma adımları var.
> ### Hazırsanız başlayabilirsiniz...
<div align="center">

<h3>
  
Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
</h3>

</div>

<h1 align="center"> SaoNetwork Full Node ve Validatör </h1>

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
  --amount 900000sao \
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

<h1 align="center"> Sao Storage Node Kurulum </h1>

> ### ***Arkadaşlar storage node kurulumunu valiadör oluşturduğunuz sunucuya yapacağınızı varsayarak yazdım. Eğer başka bir sunucuya kuracaksanız önce yukarıdaki sunucu güncellemesi ve go kurulumu adımlarını yapın***
# Binary kurun
```
cd /$HOME
git clone https://github.com/SAONetwork/sao-node.git
```
```
cd sao-node
make
go mod tidy
sudo chmod u+x saonode
```
## Sao zincirinde node account oluşturun
* bu komut yeni bir cüzdan oluşturacak, bilgileri kaydetmeyi unutmayın
```
./saonode --chain-address "https://rpc-testnet-node0.sao.network:443/"  --keyring ~/.sao  account export --key-name wallet2
```
* Sonraki adıma geçmeden önce yeni oluşturduğunuz cüzdana test tokenları atmanız gerekiyor. Fauceti kullanın ya da önceki cüzdanınızdan gönderin.
## İnit
* Yeni oluşturduğun cüzdana test tokenları almadan bu adımı yapmayın
* `<address>` kısmına yukarıdaki komutta oluşturduğunuz adresi girmeniz gerekiyor
```
./saonode --repo ~/.sao-node --chain-address "https://rpc-testnet-node0.sao.network:443/" init --creator <address>
```
* Çıkan soruya `yes`yazıp geçin. verdiği txhashi explorerda arayın işlemin başarılı olduğunu kontrol edin.
![image](https://user-images.githubusercontent.com/108215275/223184092-7980077a-f6af-4932-936c-7b2871111544.png)

## Sao storage nodu başlatın
```
screen -S saonode
```
```
./saonode run
```
### Doğru çalışan logların görünümü bu şekilde
![image](https://user-images.githubusercontent.com/108215275/223185630-f4187aec-6f0e-4bf6-bb8a-728983fe326e.png)

### CTRL+A+D ile screenden çıkış yapın



# Arkadaşlar cli client rehberini yarın ekleyeceğim...















































