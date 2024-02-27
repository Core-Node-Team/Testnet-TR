<h1 align="center"> Babylon | Testnet </h1>

<div align="center"
     
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/f486baf6-ba52-46a4-a270-2863f5626e9c)
   
     
# [Twitter](https://twitter.com/babylon_chain) | [Discord](https://discord.gg/exuVuXX8Jt) | [Github](https://github.com/babylonchain/) | [Docs](https://docs.babylonchain.io/)   
     
 </div>

## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	6+ |
| RAM	| 16+ GB |
| Storage	| 500+ GB SSD |

NOT: BU AĞ SEÇİLENLERE ÖZELDİR. TEŞVİKLİ DEĞİLDİR. KURMAK ÖDÜL KAZANDIRMAZ. 

### Go kuralım
```
ver="1.21.6"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
### Dosyaları çekelim ve kuralım
```
cd && rm -rf babylon
git clone https://github.com/babylonchain/babylon
cd babylon
git checkout v0.8.3
```
```
make build
```
### Cosmovisor ayar
```
mkdir -p $HOME/.babylond/cosmovisor/genesis/bin
mv build/babylond $HOME/.babylond/cosmovisor/genesis/bin/
rm -rf build
```
### System link
```
sudo ln -s $HOME/.babylond/cosmovisor/genesis $HOME/.babylond/cosmovisor/current -f
sudo ln -s $HOME/.babylond/cosmovisor/current/bin/babylond /usr/local/bin/babylond -f
```

### Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### Servis oluşturalım
```
sudo tee /etc/systemd/system/babylond.service > /dev/null << EOF
[Unit]
Description=babylon node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.babylond"
Environment="DAEMON_NAME=babylond"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.babylond/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable babylon.service
```

# Set node configuration
```
babylond config chain-id bbn-test-3
babylond config keyring-backend test
babylond config node tcp://localhost:16457
```
# Initialize the node
```
babylond init $MONIKER --chain-id bbn-test-3
```
# Download genesis and addrbook
```
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/genesis.json > $HOME/.babylond/config/genesis.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/addrbook.json > $HOME/.babylond/config/addrbook.json
```
# Add seeds
```
sed -i -e 's|^seeds *=.*|seeds = "49b4685f16670e784a0fe78f37cd37d56c7aff0e@3.14.89.82:26656,9cb1974618ddd541c9a4f4562b842b96ffaf1446@3.16.63.237:26656"|' $HOME/.babylond/config/config.toml
```
# Set minimum gas price
```
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml
```
### Btc ağ ayarı
```
sed -i 's|^network *=.*|network = "signet"|g' $HOME/.babylond/config/app.toml
```
### Pruning
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.babylond/config/app.toml
```
### Port ayarı
```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:16458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:16457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:16460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:16456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":16466\"%" $HOME/.babylond/config/config.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:16417\"%; s%^address = \":8080\"%address = \":16480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:16490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:16491\"%; s%:8545%:16445%; s%:8546%:16446%; s%:6065%:16465%" $HOME/.babylond/config/app.toml
```
### Snap
```
Download latest chain snapshot
curl -L http://37.120.189.81/babylon_testnet/babylon_snap.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
[[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json
```
### Başlatalım
```
sudo systemctl daemon-reload
sudo systemctl start babylond.service
```
```
sudo journalctl -u babylond.service -f --no-hostname -o cat
```
### Cüzdan oluşturalım
```
babylond keys add wallet
```

### BLS key olusturalım
```
babylond create-bls-key $(babylond keys show wallet -a)
```
```
sed -i -e "s|^key-name *=.*|key-name = \"wallet\"|" $HOME/.babylond/config/app.toml
sed -i -e "s|^timeout_commit *=.*|timeout_commit = \"30s\"|" $HOME/.babylond/config/config.toml
```
```
sudo systemctl stop babylond
```
```
sudo systemctl restart babylond
```

### Validator oluşturma.

nano /root/.babylond/validator.json

Not: aşağıdakileri koppyalayıp yapıştıralım düzenledikten sonra
```
{
        "pubkey": $(babylond tendermint show-validator),
        "amount": "1000000ubbn",
        "moniker": "validator-adını-yaz",
        "identity": "",
        "website": "",
        "security": "",
        "details": "Core Node Community",
        "commission-rate": "0.1",
        "commission-max-rate": "0.2",
        "commission-max-change-rate": "0.01",
        "min-self-delegation": "1"
}
```
```
sudo systemctl stop babylond
```
```
sudo systemctl restart babylond
```
```
babylond tx checkpointing create-validator /root/.babylond/validator.json \
    --chain-id=bbn-test-3 \
    --gas=150000 \
    --gas-adjustment=1.5 \
    --gas-prices=0.025ubbn \
    --from=wallet
    -y
 ```

Not: rpc hatası verirse.. altakini dene
 ```
babylond tx checkpointing create-validator /root/.babylond/validator.json \
    --chain-id=bbn-test-3 \
    --gas=150000 \
    --gas-adjustment=1.5 \
    --gas-prices=0.025ubbn \
    --from=molla202 \
    --node=http://localhost:16457 
    -y  
 ```

### Delege kodu kendine
Not: Gas hatası alırsanız gası 85000den fazla yapmayı deneyin 100000 yada 150000 gibi gas-adjustment 1.2 den 1.3 .15 falan denersiniz...
```
babylond tx epoching delegate valoper-adresin-explorerde-yazar 1000000ubbn --from wallet --chain-id bbn-test-3 --gas 85000 --gas-adjustment 1.2 --gas-prices 0.025ubbn -y
```

# Yararlı komutlar...

### Jailden Kurtulma
```
babylond tx slashing unjail --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Validator Bilgileri
```
babylond q epoching validator $(babylond keys show $WALLET --bech val -a) 
```
### Ödülleri Talep Etme
```
babylond tx distribution withdraw-all-rewards --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Komisyon ve Ödülleri Talep Etme
```
babylond tx distribution withdraw-rewards $(babylond keys show $WALLET --bech val -a) --commission --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delege Etme Kendine
```
babylond tx epoching delegate $(babylond keys show $WALLET --bech val -a) 1000000ubbn --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delege Etme Başkasına
```
babylond tx epoching delegate valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Redelegate (delege edilenden alıp baskasına delege etme)
```
babylond tx epoching redelegate valoper-adresini-yazınız valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Delegeyi Geri Çekme
```
babylond tx epoching unbond valoper-adresini-yazınız 1000000ubbn --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Başkasına Coin Gönderme
```
babylond tx bank send cüzdan-adresi 1000000ubbn --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y
```
### Oy Kullanma ( yes, no, no_with_veto yada abstain )
```
babylond tx gov vote 1 yes --from $WALLET --chain-id bbn-test-3 --gas-prices 0.1ubbn --gas-adjustment 1.5 --gas auto -y 
```
## Node Silme
```
sudo systemctl stop babylond && \
sudo systemctl disable babylond && \
rm /etc/systemd/system/babylond.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .babylond && \
rm -rf babylon && \
rm -rf $(which babylond)
```
