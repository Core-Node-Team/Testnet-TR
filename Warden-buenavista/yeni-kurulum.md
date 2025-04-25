<h1 align="center"> Warden Protocol </h1>


![image](https://github.com/molla202/Warden-Protocol/assets/91562185/32f62d0a-d2b1-4dfa-9b6a-60395461025f)



> Unlock the Potential of Intent-Based, Secure Cross-Chain Interactions



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Warden Website](https://wardenprotocol.org/)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/Warden%20Testnet)<br>
 * [Discord](https://discord.gg/7rzkxXRK)<br>
 * [Twitter](https://twitter.com/wardenprotocol)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	6|
| RAM	| 16+ GB |
| Storage	| 400 GB SSD |

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

### 🚧 Go kurulumu
```
cd $HOME
VER="1.22.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```

### 🚧 Dosyaları çekelim ve kuralım

```
cd $HOME
mkdir -p $HOME/.warden/cosmovisor/genesis/bin
wget https://github.com/warden-protocol/wardenprotocol/releases/download/v0.3.2/wardend_Linux_x86_64.zip
unzip -o wardend_Linux_x86_64.zip
rm -rf wardend_Linux_x86_64.zip
chmod +x wardend
```
```
mv wardend $HOME/.warden/cosmovisor/genesis/bin/
```
```
sudo ln -s $HOME/.warden/cosmovisor/genesis $HOME/.warden/cosmovisor/current -f
sudo ln -s $HOME/.warden/cosmovisor/current/bin/wardend /usr/local/bin/wardend -f
```
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧 Servis oluşturalım
```
sudo tee /etc/systemd/system/wardend.service > /dev/null << EOF
[Unit]
Description=warden node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.warden"
Environment="DAEMON_NAME=wardend"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.warden/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable wardend
```
### 🚧 İnit
```
wardend init "isim-yaz" --chain-id buenavista-1
```
### 🚧 Genesis
```
sudo wget -O /root/genesis.json.tar.xz https://buenavista-genesis.s3.eu-west-1.amazonaws.com/genesis.json.tar.xz && sudo tar -xJf /root/genesis.json.tar.xz -C /root && sudo rm /root/genesis.json.tar.xz /root/genesis.json.tar
sudo mv /root/genesis.json /root/.warden/config/
```
### 🚧 Addrbook
```
wget -O $HOME/.warden/config/addrbook.json "https://raw.githubusercontent.com/hazennetworksolutions/warden/main/addrbook.json"
```
### 🚧 Gas ayarı
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025uward\"/;" ~/.warden/config/app.toml
```
### 🚧 Peer
```
SEEDS="8288657cb2ba075f600911685670517d18f54f3b@warden-testnet-seed.itrocket.net:18656"
PEERS="92ba004ac4bcd5afbd46bc494ec906579d1f5c1d@52.30.124.80:26656,ed5781ea586d802b580fdc3515d75026262f4b9d@54.171.21.98:26656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.warden/config/config.toml
```
### config pruning
```
sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.warden/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.warden/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.warden/config/app.toml
```
### 🚧 Snap
```
sudo systemctl stop wardend

cp $HOME/.warden/data/priv_validator_state.json $HOME/.warden/priv_validator_state.json.backup

rm -rf $HOME/.warden/data $HOME/.warden/wasm
curl http://37.120.189.81/warden_testnet/warden_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.warden

mv $HOME/.warden/priv_validator_state.json.backup $HOME/.warden/data/priv_validator_state.json

```

### 🚧 Port ayarı
```
CUSTOM_PORT=112

sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${CUSTOM_PORT}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${CUSTOM_PORT}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${CUSTOM_PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${CUSTOM_PORT}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${CUSTOM_PORT}66\"%" $HOME/.warden/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${CUSTOM_PORT}17\"%; s%^address = \":8080\"%address = \":${CUSTOM_PORT}80\"%; s%^address = \"localhost:9090\"%address = \"localhost:${CUSTOM_PORT}90\"%; s%^address = \"localhost:9091\"%address = \"localhost:${CUSTOM_PORT}91\"%" $HOME/.warden/config/app.toml
```
### 🚧 Başlatalım
```
sudo systemctl restart wardend
journalctl -fu wardend -o cat
```


### 🚧 Cüzdan olusturalım
```
wardend keys add cüzdan-adi
```
### 🚧 Fauceti Warden discord #faucet kanalından alıyoruz. $request wardencüzdanadresi

### 🚧 Validator Olusturma
Not: altaki kodla pubkey öğren
```
wardend comet show-validator
```
Not: öğrendiğin pubkeyi aşağıda nano ile içine akataracağın yere yazıcan
```
nano /root/validator.json
```
NOT: baska bele validator olusturmalı proje kuruluysa içi dolu olabilir. önemli değil zaten bikere kullanıyoruz sil bastan ekle yok sa zaten içi boş
```
{
        "pubkey": pubyaz,
        "amount": "1000000uward",
        "moniker": "myvalidator",
        "identity": "optional identity signature (ex. UPort or Keybase)",
        "website": "validator's (optional) website",
        "security": "validator's (optional) security contact email",
        "details": "validator's (optional) details",
        "commission-rate": "0.1",
        "commission-max-rate": "0.2",
        "commission-max-change-rate": "0.01",
        "min-self-delegation": "1"
}
```
Not: ctrl xy enter kaydet çık.
### Validator olusturucaz ama eşleşmesini beklemeniz gerek....
```
wardend tx staking create-validator /root/validator.json \
    --from=cüzdan-adi \
    --chain-id=buenavista-1 \
    --fees=500uward \
    --node=http://localhost:11257
```
### oto validator olusturma yukardaki ile yapamadıysız deneyin
```
cd $HOME
```
# Create validator.json file
```
echo "{\"pubkey\":{\"@type\":\"/cosmos.crypto.ed25519.PubKey\",\"key\":\"$(wardend comet show-validator | grep -Po '\"key\":\s*\"\K[^"]*')\"},
    \"amount\": \"1000000uward\",
    \"moniker\": \"nodeismin\",
    \"identity\": \"keybasecode\",
    \"website\": \"\",
    \"security\": \"\",
    \"details\": \"details\",
    \"commission-rate\": \"0.1\",
    \"commission-max-rate\": \"0.2\",
    \"commission-max-change-rate\": \"0.01\",
    \"min-self-delegation\": \"1\"
}" > validator.json
```
# Create a validator using the JSON configuration
```
wardend tx staking create-validator validator.json \
    --from cuzdanismin \
    --chain-id buenavista-1 \
    --gas auto --gas-adjustment 1.5 --fees 600uward \
    --node=http://localhost:11257
```

### Delege 
```
wardend tx staking delegate valoper-adresi miktar000000uward \
--chain-id buenavista-1 \
--from "cüzdan-adi" \
--fees 500uward \
--node=http://localhost:11257
```

### Komple Silme
```
sudo systemctl stop wardend
sudo systemctl disable wardend
sudo rm -rf /etc/systemd/system/wardend.service
sudo rm $(which wardend)
sudo rm -rf $HOME/.warden
sed -i "/WARDEN_/d" $HOME/.bash_profile
```
