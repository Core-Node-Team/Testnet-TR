

![image](https://github.com/molla202/Dusk-Rusk/assets/91562185/16836aa1-c324-43f8-82fb-690552fe7fe0)


## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Dusk Resmi Websitesi](https://dusk.network/)
 * [Dusk Resmi Twitter](https://twitter.com/duskfoundation)
 * [Dusk Resmi Discord](https://discord.gg/V4eAEEtF)
 * [Dusk Dökümantasyon](https://docs.dusk.network/getting-started/node-setup/docker-image)
 * [Dusk explorer](https://explorer.dusk.network/)


### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	2+ vcpu|
| ✔️RAM	| 4+ GB |
| ✔️Storage	| 160+ GB SSD |
| ✔️UBUNTU | 22 |

NOT: BAŞLAMADAN LÜTFEN ÖNCE DETAYLICA OKUYUN KURULUMUN 2 ÇEŞİDİ VAR. DETAYLAR İÇİN DUSK DİCORDA GİRİP BAKININ....
NOT: EXPLORERDEN BLOK SAYISINA BAKIN AĞDA EŞLEŞMEK ZAMAN ALACAKTIR...

### Docker kurulumu ve gereklilikler.

```
apt-get update
apt-get upgrade
```
```
sudo apt-get install ca-certificates curl gnupg
```
```
sudo install -m 0755 -d /etc/apt/keyrings
```
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt-get update
```
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


### Dosyaları çekelim

Not: kurulum baya uzun sürüyor...
```
git clone https://github.com/dusk-network/rusk.git
```
```
cd rusk
```
```
docker build -t rusk .
```
```
docker run --restart on-failure -d -p 9000:9000/udp -p 8080:8080/tcp rusk
```

### Log
Not: `docker-id` öğrenmek için `docker ps` yazıyoruz cıkanlardan.

![image](https://github.com/molla202/Dusk-Rusk/assets/91562185/25a6c343-ce28-4014-a713-3b9961c928b9)


Not: loglarda `hieght:` blok sayısı yazar eşlememiz gerekıyor buda bira zaman alacaktır. güncel bloğa burdna bakabilirsiniz. `https://explorer.dusk.network/`
```
docker logs -f --tail 100 docker-id
```


# Normal kurulum

### Gereklilikler

```
apt-get update
apt-get upgrade
```
```
sudo apt-get install ca-certificates curl gnupg zip libssl-dev clang gcc git
```
```
sudo apt-get install rustc
```
```
apt-get update
apt-get upgrade
```
### Rust kuralım
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs/ | sh
```
```
source $HOME/.cargo/env
```
### Dosyaları çekelim ve kuralım
```
git clone https://github.com/dusk-network/rusk.git
```
```
cd rusk
```
```
screen -S dusk
```
> Keyleri olusturalım
```
make keys
```
> Genesis contracts
```
make wasm
```
> Yapılandıralım
```
cargo b --release -p rusk
```
```
mkdir -p ~/.dusk/rusk
```
```
cp examples/consensus.keys ~/.dusk/rusk/consensus.keys
```
```
cargo r --release -p rusk -- recovery-state --init examples/genesis.toml
```
```
DUSK_CONSENSUS_KEYS_PASS=password cargo r --release -p rusk -- -c rusk/default.config.toml
```
NOT: loglar akmaya başlayacaktır screenden cıkmak için ctrl ad girmek için screen -r dusk. screende ctrl c DEMEYİN.

![image](https://github.com/molla202/Dusk-Rusk/assets/91562185/2dbe0c8d-3a2d-4492-970a-63842bff4830)




# Bazı alınan hatalar...

...........









