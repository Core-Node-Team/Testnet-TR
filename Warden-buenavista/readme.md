<h1 align="center"> Warden Protocol </h1>


![image](https://github.com/molla202/Warden-Protocol/assets/91562185/32f62d0a-d2b1-4dfa-9b6a-60395461025f)



> Unlock the Potential of Intent-Based, Secure Cross-Chain Interactions



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Warden Website](https://wardenprotocol.org/)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/Warden%20Testnet)<br>
 * [Discord](https://discord.gg/gbPAKUhH)<br>
 * [Twitter](https://twitter.com/wardenprotocol)<br>

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

### 🚧 Dosyaları çekelim ve kuralım

```
cd $HOME
mkdir -p $HOME/.warden/cosmovisor/genesis/bin
rm -rf wardenprotocol
git clone --depth 1 --branch v0.3.0 https://github.com/warden-protocol/wardenprotocol/
cd wardenprotocol
make build
```
```
mv /root/wardenprotocol/build/wardend $HOME/.warden/cosmovisor/genesis/bin/
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
### 🚧 Genesis addrbook
```
wget -O $HOME/.warden/config/genesis.json "https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Warden-buenavista/genesis.json"
wget -O $HOME/.warden/config/addrbook.json "https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Warden-buenavista/addrbook.json"
```
### 🚧 Gas ayarı
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025uward\"/;" ~/.warden/config/app.toml
```
### 🚧 Peer
```
SEEDS="8288657cb2ba075f600911685670517d18f54f3b@warden-testnet-seed.itrocket.net:18656"
PEERS="b14f35c07c1b2e58c4a1c1727c89a5933739eeea@warden-testnet-peer.itrocket.net:18656,61446070887838944c455cb713a7770b41f35ac5@37.60.249.101:26656,0be8cf6de2a01a6dc7adb29a801722fe4d061455@65.109.115.100:27060,dc0122e37c203dec43306430a1f1879650653479@37.27.97.16:26656,8288657cb2ba075f600911685670517d18f54f3b@65.108.231.124:18656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.warden/config/config.toml
```
### 🚧 Snap
```
wardend tendermint unsafe-reset-all --home $HOME/.warden
if curl -s --head curl http://37.120.189.81/warden_testnet/warden_snap.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl http://37.120.189.81/warden_testnet/warden_snap.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.warden
    else
  echo no have snap
fi
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
### 🚧 Faucet
Not: altaki kodu çalıştırdıktan sonra explorerden adresini arat bak gelmişmi die

https://warden-explorer.paranorm.pro/warden/block
```
curl --data '{"address": "cüzdan-adresi-yaz"}' https://faucet.buenavista.wardenprotocol.org
```
### 🚧 Validator Olusturma
Not: altaki kodla pubkey öğren
```
wardend comet show-validator
```
Not: öğrendiğin pubkeyi aşağıda nano ile içine akataracağın yere yazıcan
```
nano /root/wardenprotocol/validator.json
```
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
wardend tx staking create-validator /root/wardenprotocol/validator.json \
    --from=cüzdan-adi \
    --chain-id=buenavista-1 \
    --fees=500uward \
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

### OTO faucet isteme 
NOT: ayrıca platformdadan keplerle alabilirsiniz : https://spaceward.buenavista.wardenprotocol.org/
NOT: cüzdan adresi yazın
```
screen -S faucet
```
```
nano script.sh
```
```
#!/bin/bash

# Sonsuz döngü başlat
while true; do
  # Komutunuzu burada çalıştırın
  /usr/bin/curl --data '{"address":"cüzdan-adresi-yaz"}' https://faucet.buenavista.wardenprotocol.org/

  # 12 saat (43200 saniye) bekleyin
  sleep 43200
done
```

- cttl y x enter
```
chmod +x script.sh
```
```
./script.sh
```
- CRTL+A D  bas çık


### Komple Silme
```
sudo systemctl stop wardend
sudo systemctl disable wardend
sudo rm -rf /etc/systemd/system/wardend.service
sudo rm $(which wardend)
sudo rm -rf $HOME/.warden
sed -i "/WARDEN_/d" $HOME/.bash_profile
```


