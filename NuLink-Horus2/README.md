

![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/b8633ea4-d5c1-4d0e-93c8-66d70209c041)

## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [NuLink Resmi Websitesi](https://www.nulink.org/)
 * [NuLink Resmi Twitter](https://twitter.com/NuLink_)
 * [NuLink Resmi Discord](https://discord.gg/25CQFUuwJS)
 * [NuLink Dökümantasyon](https://docs.nulink.org/products/stakers/nulink_worker/eth_account/)
 


### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	2+ vcpu|
| ✔️RAM	| 4+ GB |
| ✔️Storage	| 40+ GB SSD |
| ✔️UBUNTU | 20 |


Ödüllendirmenin nasıl yapılacağı ile ilgili bilgiler [BURADA](https://www.nulink.org/blog-posts/nulink-testnet-horus-2-0-phase-one-testing-rules) yazıyor. bir sıralama ve çekiliş usulu olucak gibi gorunuyor. Kurallar [BURADA](https://www.nulink.org/blog-posts/nulink-testnet-horus-2-0-phase-one-testing-rules) yazıyor. Genel bilgilendirme de [BURADA](https://www.nulink.org/blog-posts/announcement-for-nulink-testnet-horus-2-0) Ve linklerde form ve açıklamalar var ona göre yapıp epoch geçtikten sonra formu doldurmayı unutmayınız.

### Docker kurulumu ve gereklilikler.

```
sudo apt-get update
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
### Worker oluşturma
```
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.23-d901d853.tar.gz
```
```
tar -xvzf geth-linux-amd64-1.10.23-d901d853.tar.gz
```
```
cd geth-linux-amd64-1.10.23-d901d853/
```
Not: şifre oluşturmanızı isteyecek 12345678 yapın geçin kafa karışmasın :D çıktıda bi UTC ile ilgili yazı olucak kaydedin dosyannın adını
```
./geth account new --keystore ./keystore
```
![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/5e0c45e8-da65-4f3f-9d2b-397a69976639)
### NuLink docker image çekelim

```
docker pull nulink/nulink:latest
```
```
cd
mkdir nulink
```
```
cp /root/geth-linux-amd64-1.10.23-d901d853/keystore/* /root/nulink
```
```
chmod -R 777 /root/nulink
```
```
export NULINK_KEYSTORE_PASSWORD=12345678
export NULINK_OPERATOR_ETH_PASSWORD=12345678
```
### İnit işlemi
Not: `--signer keystore:///code/UTC--DEğiş beni bıradır \` Burada yazan `UTC--DEğiş beni bıradır` bu kısmı değiştirmemiz lazım. nulink dosyasında UTC ile başlayan bir dosya var daha oncedende kaydedin demiştik orası ile değişmesi gerekiyor buranın. Ve cüzdna adresi buraya yazan kısmada olusturduğumuz workerın adresini yazmamız lazım. adresi nerden öğrenicez aslında UTC ile başlayan isimde yazıyor ama yok basında 0x vardı yoktu küçük harf buyuk boşverin dosyayı pcmize çekiyoruz. nulink içindeki UTC yi sonra metamasktan add account ımport json dosyası seçin dosyayı seçin zaten herşeye 12345678 yazmıştık şifre kısmınada 12345678 yazın ekleyin makına kasar kendindne geçer bekleyin açılınca eklenmiş olur adresinizi alın yapıstırın.altaki resimdeki yer UTC adı yazan yer yukarıdaki işlemde
![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/5e0c45e8-da65-4f3f-9d2b-397a69976639)
```
docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer keystore:///code/UTC--DEğiş beni bıradır \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address Cüznda-adresiburaya \
--max-gas-price 10000000000
```
- Aşağıdaki resim :D beel bi sıralamada sorucak yukardakini yazınca
![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/4c7a8de5-679d-4ea7-ad8a-b75e0ac035e4)

### Stake işlemleri ve bond
- https://dashboard.testnet.nulink.org/staking adresine gidiyoruz burn cüzdanlardan birini bağlıyoruz. ve faucet alıcaz tbnb ve nulink için sayfanın sağ ustunde bir cüzdan simgesi var tıklayın ona ve size açılan pencerede faucet için yonlendiricek faucetleri alın.

![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/ac68b359-40af-44c4-98ad-762365d0dbec)

- stake dıyoruz 5 dane dıor max deyınce 5 dane edin lütfen.

![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/2b5a3f84-9f40-419d-8735-9eb365ba4f3c)

- Bond worker deyin ve sizden cüzdan adresi sorucam bu import ettiğimiz cüzdan adresimiz var ya UTC li hatta cüdan adresi yaz butya dediğimiz adres yazın onaylayın. 

![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/581a7f20-644f-4723-ad51-7f7cf62a034d)

- daha sonra alttan çalıştırın. bi zaman son online olmanız gerekiyor.
- belki daha sonra restart atmanız gerekebilir oda yazıyor aşağıda




### Başlatma
Not: bişi değişmiyor aynen convaynen.
```
docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready
```

![image](https://github.com/molla202/NuLink-Horus2/assets/91562185/078c4d7f-7739-4a37-a271-ab5637f32146)


### Loglara bakalım
```
docker logs -f ursula
```
### Restart
```
docker restart ursula
```










