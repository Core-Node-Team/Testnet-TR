<h1 align="center"> 0G

![image](https://github.com/molla202/0G/assets/91562185/6eca238f-cd35-411b-9c5a-857fbd80dd33)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>
 * [Twitter](https://twitter.com/0G_labs)<br>
 * [0G Website](https://0g.ai/)<br>
 * [0G Blog](https://blog.0g.ai/)<br>
 * [0G gitbook/docs](https://zerogravity.gitbook.io/0g-doc/)<br>
 * [0G Telegram](https://t.me/web3_0glabs)<br>
 * [Blockchain Explorer](https://explorer.corenodehq.com/0G%20Testnet.)<br>


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

### 🚧Dosyaları çekelim
```
git clone -b v0.1.0 https://github.com/0glabs/0g-chain.git
./0g-chain/networks/testnet/install.sh
source .profile
```

```
mkdir -p $HOME/.0gchain/cosmovisor/genesis/bin
mv /root/go/bin/0gchaind $HOME/.0gchain/cosmovisor/genesis/bin/
```
### 🚧System link
```
sudo ln -s $HOME/.0gchain/cosmovisor/genesis $HOME/.0gchain/cosmovisor/current -f
sudo ln -s $HOME/.0gchain/cosmovisor/current/bin/0gchaind /usr/local/bin/0gchaind -f
```
### 🚧Cosmovisor indirelim
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
### 🚧Servis oluşturalım
```
sudo tee /etc/systemd/system/0gchaind.service > /dev/null << EOF
[Unit]
Description=0gchaind node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.0gchain"
Environment="DAEMON_NAME=0gchaind"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.0gchain/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable 0gchaind.service
```
### 🚧Node ayarları
```
0gchaind config chain-id zgtendermint_16600-1
0gchaind config keyring-backend os
0gchaind config node tcp://localhost:16657
```
### 🚧İnit
NOT: node adınızı yazınız.
```
0gchaind init NODE-ADI-YAZ --chain-id zgtendermint_16600-1
```
### 🚧Genesis addrbook
```
rm ~/.0gchain/config/genesis.json
curl -Ls https://github.com/0glabs/0g-chain/releases/download/v0.1.0/genesis.json > $HOME/.0gchain/config/genesis.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/0G-Newton/addrbook.json > $HOME/.0gchain/config/addrbook.json
```
OR
```
rm ~/.0gchain/config/genesis.json

wget -P ~/.0gchain/config https://github.com/0glabs/0g-chain/releases/download/v0.1.0/genesis.json
```
### 🚧Seed
```
PEERS="498110cd24688215cb2d8e050fb587b0e7f91b21@65.109.20.18:26656,00b85563ffff199e272296e870da1710ea6ed60b@167.86.115.3:26656,6c3d79ac2ac0367c9ec5b540816b131d8ec1bb89@161.97.105.211:12656e0cf097847b0236f2ae9f811b5528886371d2e02@161.97.115.158:12656,5dd21fdcef903d4176c55589301b0baf37741a95@209.145.59.219:26656,796ebf2273e91c04d277812fdf1889e2941d0157@75.119.147.128:26656,a8e7aa505bbca6ed5a317d63c0f77411ea3eff7c@83.171.248.147:12656,e937254f9f62b3d04c4ea9ba37c8208bff2b6906@89.117.51.134:26656,2a1426b810319c601b0053516a4b9c7f8f692357@5.58.226.61:26756,bcbe072005aa6d1e1e9c5542f1bd77f8acadf318@87.212.22.230:26656,8429930892c6c647e70d3a8a89e20e3978e4213e@84.54.23.81:26656,7e95e37ea8eb6bab8ea4a30e6eb21cb166c071c8@207.180.243.9:12656,6ea572ba1528d05dfbe6dbeef3d0face815a423d@128.199.204.71:26656,99054f0339b35970167596779ff242106ddac993@89.117.76.6:26656,9f08f8b70e3d0118e348197ec5b856efac5869e2@91.230.110.229:12656,df6759c5f756aa2123d9c5ba78260ed638bc3e95@109.123.244.167:12656,b2cc97e2c9d0e7e0740944fb4d38a6933d81038e@65.109.115.56:16456,8b53b9e71d5b85ba7ccf17dd2326a540e67558d1@188.40.85.207:12856,8d1c5859fc540289fb3f112d785bf6edbfcce763@157.90.181.76:56656,07bbb71f51a0fbbca9b35e840eb19cd33a2fb22f@38.242.236.246:12656,81861ed028e847469d37a77f89e16645f9d75aff@89.117.55.86:12656,d7a6f9e8075673ef95d93ebc9d344a556291f6bb@83.171.249.192:12656,41f341a08a67fe9fc7f31bff1de2a0bedcc200b4@89.116.33.234:37656,8a3f41e40d519ebcbec62339d5b2b322fa19fcb9@173.212.216.88:12656,bb619cf8da2a73301ccde7ed1eedc62578b0b55e@37.60.233.189:26656,350ab53e5461f88bca189e877462eb929691e7d8@173.249.17.131:26656,4f99d21757e442846e6cc38d11800336e6614a10@176.57.189.224:12656,19060f0b8b578ce18ec13a8d7f97c81c0b6b9bf7@161.97.83.127:12656,dffa6a922f7b8d2fb3b64275f34b1f4e69951139@95.111.232.189:26656,d03e19e2156116664abc642a97687cf87c08b378@158.220.90.189:26656,: command not found
498110cd24688215cb2d8e050fb587b0e7f91b21@65.109.20.18:26656,00b85563ffff199e272296e870da1710ea6ed60b@167.86.115.3:26656,6c3d79ac2ac0367c9ec5b540816b131d8ec1bb89@161.97.105.211:12656e0cf097847b0236f2ae9f811b5528886371d2e02@161.97.115.158:12656,5dd21fdcef903d4176c55589301b0baf37741a95@209.145.59.219:26656,796ebf2273e91c04d277812fdf1889e2941d0157@75.119.147.128:26656,a8e7aa505bbca6ed5a317d63c0f77411ea3eff7c@83.171.248.147:12656,e937254f9f62b3d04c4ea9ba37c8208bff2b6906@89.117.51.134:26656,2a1426b810319c601b0053516a4b9c7f8f692357@5.58.226.61:26756,bcbe072005aa6d1e1e9c5542f1bd77f8acadf318@87.212.22.230:26656,8429930892c6c647e70d3a8a89e20e3978e4213e@84.54.23.81:26656,7e95e37ea8eb6bab8ea4a30e6eb21cb166c071c8@207.180.243.9:12656,6ea572ba1528d05dfbe6dbeef3d0face815a423d@128.199.204.71:26656,99054f0339b35970167596779ff242106ddac993@89.117.76.6:26656,9f08f8b70e3d0118e348197ec5b856efac5869e2@91.230.110.229:12656,df6759c5f756aa2123d9c5ba78260ed638bc3e95@109.123.244.167:12656,b2cc97e2c9d0e7e0740944fb4d38a6933d81038e@65.109.115.56:16456,8b53b9e71d5b85ba7ccf17dd2326a540e67558d1@188.40.85.207:12856,8d1c5859fc540289fb3f112d785bf6edbfcce763@157.90.181.76:56656,07bbb71f51a0fbbca9b35e840eb19cd33a2fb22f@38.242.236.246:12656,81861ed028e847469d37a77f89e16645f9d75aff@89.117.55.86:12656,d7a6f9e8075673ef95d93ebc9d344a556291f6bb@83.171.249.192:12656,41f341a08a67fe9fc7f31bff1de2a0bedcc200b4@89.116.33.234:37656,8a3f41e40d519ebcbec62339d5b2b322fa19fcb9@173.212.216.88:12656,bb619cf8da2a73301ccde7ed1eedc62578b0b55e@37.60.233.189:26656,350ab53e5461f88bca189e877462eb929691e7d8@173.249.17.131:26656,4f99d21757e442846e6cc38d11800336e6614a10@176.57.189.224:12656,19060f0b8b578ce18ec13a8d7f97c81c0b6b9bf7@161.97.83.127:12656,dffa6a922f7b8d2fb3b64275f34b1f4e69951139@95.111.232.189:26656,d03e19e2156116664abc642a97687cf87c08b378@158.220.90.189:26656" && \
SEEDS="c4d619f6088cb0b24b4ab43a0510bf9251ab5d7f@54.241.167.190:26656,44d11d4ba92a01b520923f51632d2450984d5886@54.176.175.48:26656,f2693dd86766b5bf8fd6ab87e2e970d564d20aff@54.193.250.204:26656,f878d40c538c8c23653a5b70f615f8dccec6fb9f@54.215.187.94:26656" && \
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Gas pruning ayarı
```

sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.0gchain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.0gchain/config/app.toml

sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0ua0gi"|g' $HOME/.0gchain/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.0gchain/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.0gchain/config/config.toml
```
### 🚧Port Ayarları
```
echo "export G_PORT="16"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:1317%:${G_PORT}317%g;
s%:8080%:${G_PORT}080%g;
s%:9090%:${G_PORT}090%g;
s%:9091%:${G_PORT}091%g;
s%:8545%:${G_PORT}545%g;
s%:8546%:${G_PORT}546%g;
s%:6065%:${G_PORT}065%g" $HOME/.0gchain/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${G_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.0gchain/config/config.toml
```
### 🚧Snap
```
yakında
```
### 🚧Başlatalım   
```
sudo systemctl daemon-reload
sudo systemctl restart 0gchaind
```
### 🚧Log
```
sudo journalctl -u 0gchaind.service -f --no-hostname -o cat
```
### 🚧Cüzdan oluşturma
NOT: cüzdan adınızı yazınız
```
0gchaind keys add cuzdan-adini-yaz --eth
```
- Eski cüzdan import ederkene bele
```
0gchaind keys add wallet --eth --recover
```
### 🚧Cüzdan evm adresi alma
NOT:wallet adınızı yazınız
```
echo "0x$(0gchaind debug addr $(0gchaind keys show wallet-adınızı-yazınız -a) | grep hex | awk '{print $3}')"
```
> evm scan :   https://scan-testnet.0g.ai
> evm için private key alma mm ekleme aynı cüzdanı. cüzdna adınızı yazınız.
```
0gchaind keys unsafe-export-eth-key cüzdan-adi-yaz
```
### FAUCET
NOt: faucet suan 
https://faucet.0g.ai/

### 🚧Validator oluşturma
NOT: discorddan rollerinizi de alın ki kanallar açılsın

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2b73ebc0-0880-4237-be41-aeb739f2d325)


NOT: cüzdan adını moniker adınızı yazınız
```
0gchaind tx staking create-validator \
  --amount=1000000ua0gi \
  --pubkey=$(0gchaind tendermint show-validator) \
  --moniker=MONIKER-YAZ \
  --chain-id=zgtendermint_16600-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=CUZDAN-ADI-YAZ \
  --identity="" \
  --website="" \
  --details="" \
  --node=http://localhost:16657 \
  -y
```
### Test dosya yuklemesi deneme

https://scan-testnet.0g.ai/tool


- adresine gidiyoruz cüzdanımızı bağlıyoruz. ağı otomatik ekler. sonra herhangi ufak bir resim dosya seçiyouruz ve upload ediyoruz onay verıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/36d5d3ee-85a2-4d7a-ae56-8784b0fa8c1c)


### Kendine delege
NOT: wallet kısmına cuzdan adı yazınız 2yerede. miktar kısmınada sayıyı yazın 1 dane edeceksenız mıktarı sil 1 yaz olmassa 1 sıfır falan dusur
```bash
0gchaind tx staking delegate $(0gchaind keys show wallet --bech val -a)  miktar000000ua0gi --from wallet -y
```




