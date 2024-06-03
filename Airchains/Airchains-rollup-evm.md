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




### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip screen -y
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
git clone https://github.com/airchains-network/tracks.git
```
```shell
git clone https://github.com/availproject/availup.git
```
### Evm-Station
```shell
screen -S evm
```
```shell
cd evm-station
```
```shell
go mod tidy
```
```shell
/bin/bash ./scripts/local-setup.sh
```
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
sed -i.bak -e "s%:26658%:${CROSSFI_PORT}658%g;
s%:26657%:${G_PORT}657%g;
s%:6060%:${G_PORT}060%g;
s%:26656%:${G_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${G_PORT}656\"%;
s%:26660%:${G_PORT}660%g" $HOME/.evmosd/config/config.toml
```
### Başlatalım
```shell
/bin/bash ./scripts/local-start.sh
```
- çalıştıysa bloklar akar ctrl + a + d screenden çıkın

```shell
/bin/bash ./scripts/local-keys.sh
```

- key vericek bu bizim airchain rollup keyimiz kaydedin


## Avail light node kuralım
```shell
screen -S avail
```
```
cd
cd availup
```
```shell
/bin/bash availup.sh --network "turing" --app_id 36
```
- çalışınca loglar akmaya başlar ve bizim cüzdan adresimiz görunur pubkey falan kaydedin bunları. ctrl + a + d screen çıkın

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/14e09a3b-3836-4500-b710-aaae9d2f2800)


## Track kurulum

```shell
cd
cd tracks
```
```shell
go mod tidy
```
- Dakey : avail içindeki kelimeler mubarekler nerden görucez. altaki kodla kelimeleri görebilirsiniz. aldınız napacaksınız.
```
nano /root/.avail/identity/identity.toml
```
- adrese gedelim accountta tıklayalım ve kelimelerimizi girelim yukarda hatırlarsanız avail kurarkene cüzdan adresi ve pubkey gozukmustu buraya kelimeleri eklediğimizde aynı cüzdanmı gorunuyor tmm biraz faucet alalım  

https://temp-explorer.avail.so/?rpc=wss%3A%2F%2Fturing-rpc.corenode.info#/accounts

https://faucet.avail.tools

- Moniker : MONİKER İSMİNİZ

- şimdi aşağıdaki koduda düzenlediğimizde girince track dataları oluşucak
```shell
go run cmd/main.go init --daRpc "http://127.0.0.1:7000" --daKey "avail kelimeler yaz" --daType "avail" --moniker "moniker-adini-yaz" --stationRpc "http://127.0.0.1:16545" --stationAPI "http://127.0.0.1:16545" --stationType "evm"
```

- Aşağıdaki kodda cüzdan-adi-yaz kısmına adınızı yaıznız cüzdanın çıktıyı koomple kaydedin lazımdır. keplerede ekleyin adrese discordan faucet istiyoruz

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/688f4f3c-dc1d-407c-9324-9cac047a9081)


```shell
go run cmd/main.go keys junction --accountName cüzdan-adi-yaz --accountPath $HOME/.tracks/junction-accounts/keys
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/e04908ec-e0c4-41a5-a622-96a66c10c2e6)

### Prover başlatalım
```shell
go run cmd/main.go prover v1EVM
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
go run cmd/main.go create-station --accountName cüzdan-adini-yaz --accountPath $HOME/.tracks/junction-accounts/keys --jsonRPC "https://airchains-testnet-rpc.cosmonautstakes.com/" --info "EVM Track" --tracks cüzdan-adresini-yaz --bootstrapNode "/ip4/SUNUCU-İP-YAZ/tcp/2300/p2p/NODE-ID-YAZ"
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/fe107d45-9253-49a9-8bcc-b9d60f4433a0)

### Başlatalım
```
screen -S evm
```
```shell
go run cmd/main.go start
```

![image](https://github.com/molla202/Airchains-rollup/assets/91562185/6a383743-601d-4a87-8731-11620354c012)

Not: çalıştırdıktan sonra yukardaki gibi görunce ctrl a+d ile çıkalım. screenlere bakmak için her zaman bu kodu kullanıyoruz screen -r screen-adi   screene ne ad verdiysek onu yazıcaz cıkarken yıne ctrl ad

### Puan kontrol
- cüzdan kelimeleriniz leap walleta import edip bağlaıyınız.puan kazanmak zaman alıyor.
- https://points.airchains.io/



