<h1 align="center"> Airchain Evm Rollup 


![image](https://github.com/molla202/Airchain/assets/91562185/64b9e7f3-4739-4774-b421-635e224dcd4f)


</h1>

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Airchain Website](https://www.airchains.io)<br>
 * [Blockchain Explorer](https://testnet.airchains.io)<br>
 * [Discord](https://discord.gg/jsy8ZqrD)<br>
 * [Twitter](https://twitter.com/airchains_io)<br>

### Public RPC

RPC : https://airchains-testnet-rpc.corenode.info/

API : https://airchains-testnet-api.corenode.info/

GRPC : https://airchains-testnet-grpc.corenode.info/

### Explorer

https://explorer.corenodehq.com/Airchains-Testnet.

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2|
| RAM	| 4+ GB |
| Storage	| 100+ GB SSD |


## ♥ Silip kurucam diyenler
NOt: avail servis oalrak çalışıor bişileri değiştirmemize tekrar kurmamıza gerek yok.
```
cd
rm -rf .evm-station
rm -rf tracks
rm -rf .tracks
rm -rf evm-station
rm -rf .evmosd
```

### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip screen -y
sudo apt install -y curl git jq lz4 build-essential cmake perl automake autoconf libtool wget libssl-dev -y
```
```
ufw allow 16545
```
### Go
```shell
cd $HOME && \
ver="1.21.3" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```
### Dosyaları çekelim
```shell
git clone https://github.com/airchains-network/evm-station.git
```
```shell
wget https://github.com/airchains-network/tracks/releases/download/v0.0.3/tracks
chmod +x tracks
```

### Evm-Station

```shell
cd evm-station
```
```shell
go mod tidy
```
- Chainid belirleyelim resimdeki gibi isim yazın tr karakter olmadan ve sayılarıda değştirebilirsiniz ama unutmayın ne yazdığınızı klaydedin. ctrl xy enterla kaydediyoruz.
```
nano /root/evm-station/scripts/local-setup.sh
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/77c51add-9b4a-491b-b9ba-3b0a9325e079)


```shell
/bin/bash ./scripts/local-setup.sh
```
- bize cüzdan kelimelerinide veriyor kaydedin verileri.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6341ae29-e5f4-4db4-9c68-2a0c3b368eb1)


Not: port değiştiricekseniz bu opsiyonel port ayarını girebilirsiniz ben port değiştirerek anlattım devamını ona göre 
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
s%:6065%:${G_PORT}065%g" $HOME/.evmosd/config/app.toml
```
```
sed -i.bak -e "s%:26658%:${G_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.evmosd/config/config.toml
```

### oluşan cüzdanımızın private keyini allım 
NOT: bu aynı zamanda ototx işleminde private key alma işlemi ile aynı işlemdir.
```shell
cd
cd evm-station
/bin/bash ./scripts/local-keys.sh
```

### servis hazırlayalım
ÖNEMLİ : KÜÇÜK HARFLER VE TR HARİCİ KARAKTERLER.
Not: CHAINID=corenode_1254-1   gibi bir isimi vardıya aşağı yonu yazıcaksınız. YADA servis deki bu kısma --chain-id "buraya yazicaksınız"  

```
CHAINID=ağ adı girmiştik buraya yazın
```
```
sudo tee /etc/systemd/system/evmosd.service > /dev/null <<EOF
[Unit]
Description=evmosd node
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$HOME/.evmosd
ExecStart=/root/evm-station/build/station-evm start \
--metrics "" \
--log_level "info" \
--json-rpc.api eth,txpool,personal,net,debug,web3 \
--chain-id "$CHAINID"
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable evmosd
sudo systemctl restart evmosd
```
### Log
```
sudo journalctl -u evmosd -fo cat
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/ed285d29-f404-458f-b3d8-f21000112789)


## Avail light node kuralım
- aşağıdaki repodan kuralım servisle durduydu ettiydiyle uğraşmayalım temiz. başlatınca cüzdan adresi ve pubkey gorunur alıp kaydedin

https://github.com/Core-Node-Team/Testnet-TR/blob/main/Avail-Turing/Light-Node.md


## Track kurulum

- Dakey : avail kurduğumuzda başlarken yazan pubkey başına 0x koyuyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2831e936-b6c6-43ce-a057-9b47a2c0ecb6)

```
nano /root/.avail/identity/identity.toml
```
- adrese gedelim accountta tıklayalım ve kelimelerimizi girelim yukarda hatırlarsanız avail kurarkene cüzdan adresi ve pubkey gozukmustu buraya kelimeleri eklediğimizde aynı cüzdanmı gorunuyor tmm biraz faucet alalım  

https://temp-explorer.avail.so/?rpc=wss%3A%2F%2Fturing-rpc.corenode.info#/accounts

https://faucet.avail.tools

- Moniker : MONİKER İSMİNİZ

- şimdi aşağıdaki koduda düzenlediğimizde girince track dataları oluşucak
```shell
./tracks init --daRpc "http://127.0.0.1:7000" --daKey "avail-pubkey-başı-0x-şekilde" --daType "avail" --moniker "moniker-adini-yaz" --stationRpc "http://127.0.0.1:16545" --stationAPI "http://127.0.0.1:16545" --stationType "evm"
```

- Aşağıdaki kodda cüzdan-adi-yaz kısmına adınızı yaıznız cüzdanın çıktıyı koomple kaydedin lazımdır. keplerede ekleyin adrese discordan faucet istiyoruz

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/688f4f3c-dc1d-407c-9324-9cac047a9081)


```shell
./tracks keys junction --accountName cüzdan-adi-yaz --accountPath $HOME/.tracks/junction-accounts/keys
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/e04908ec-e0c4-41a5-a622-96a66c10c2e6)

### Prover başlatalım
```shell
./tracks prover v1EVM
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/96ea07c9-dbd9-4d4a-bd4f-182e5b40dc77)


### Junction istasyon oluşturalım
- NODE-ID-YAZ :  içersinde yazıyor
```
nano /root/.tracks/config/sequencer.toml
```
![image](https://github.com/molla202/Airchains-rollup/assets/91562185/4adec374-03f9-457d-8ca9-0dac3ee285ff)

- cüzdan-adini-yaz yani cündanın adını yaz :D askjdhskaldnas 
- cüzdan-adresini-yaz kısmına adresiizi yazın air ile başlayan
- /ip4/SUNUCU-İP-YAZ/tcp/2300/p2p/NODE-ID-YAZ  bu kısımda sunucu ip ve yukarıda node id aldığımız bilgileri yazalım.
- hata verirse tekrar deneyin.


```shell
./tracks create-station --accountName cüzdan-adini-yaz --accountPath $HOME/.tracks/junction-accounts/keys --jsonRPC "https://airchains-testnet-rpc.cosmonautstakes.com/" --info "EVM Track" --tracks cüzdan-adresini-yaz --bootstrapNode "/ip4/SUNUCU-İP-YAZ/tcp/2300/p2p/NODE-ID-YAZ"
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/fe107d45-9253-49a9-8bcc-b9d60f4433a0)

### Başlatalım
```
screen -S etm
```
```shell
./tracks start
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/6a383743-601d-4a87-8731-11620354c012)

Not: çalıştırdıktan sonra yukardaki gibi görunce ctrl a+d ile çıkalım. screenlere bakmak için her zaman bu kodu kullanıyoruz screen -r screen-adi   screene ne ad verdiysek onu yazıcaz cıkarken yıne ctrl ad

### Tracks servisle çalıştırma
Not: zaten çalışıyorsa işlem yapıyorsa durdurmayın hata verirse yada işlemi bitirip beklemedeyse ctrl c ile durdurup servis yapın. evet screen açmıştık eğer servisle çalıştırıcaksanız açmanıza gerek yok
```
sudo tee /etc/systemd/system/tracksd.service > /dev/null <<EOF
[Unit]
Description=tracksd node
After=network-online.target

[Service]
User=$USER
WorkingDirectory=$HOME/.tracks
ExecStart=/root/tracks start

Restart=always
RestartSec=5
LimitNOFILE=65535
SuccessExitStatus=0 1
[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable tracksd
sudo systemctl restart tracksd
```
### Log
```
sudo journalctl -u tracksd -fo cat
```


### Puan kontrol
- cüzdan kelimeleriniz leap walleta import edip bağlaıyınız.puan kazanmak zaman alıyor.
- https://points.airchains.io/

### Hangi portlar kullanılıyor.
- kod ile bakın eğer kullanmıyorsa sunucunuzda kurabilirsiniz.
```
sudo lsof -i -P -n | grep LISTEN
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/a0bd638f-4ff8-4bcd-9614-dffdd7234f3e)


