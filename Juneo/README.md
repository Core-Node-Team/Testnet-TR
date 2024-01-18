# Juneo

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/639b4be5-b0d1-4f31-9dc0-bd000ae29076)



![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/dc0c0b9a-6e7d-4d17-91fa-c2405ca9d997)


## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Juneo Resmi Websitesi](https://juneo.com/)
 * [Juneo Resmi Twitter](https://twitter.com/JUNEO_official)
 * [Juneo Resmi Discord](https://discord.gg/ZPBCWWQX)
 * [Juneo Dökümantasyon](https://docs.juneo.com/intro/the-juneo-network-work-in-progress/join-the-socotra-testnet-v1)
 * [Juneo explorer](https://mcnscan.io/)


### 💻Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4+ vcpu|
| ✔️RAM	| 8+ GB |
| ✔️Storage	| 160+ GB SSD |
| ✔️UBUNTU | 20.04/ 22.04 |


### 🚧Docker kurulumu ve gereklilikler.

```
sudo apt-get update
```
```
sudo apt-get install ca-certificates curl gnupg git
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
```
apt install docker-compose
```
### 🚧Dosyaları çekelim
```
git clone https://github.com/Juneo-io/juneogo-docker
```
```
cd juneogo-docker
```
```
docker-compose build
```
```
docker-compose up -d juneogo
```
### 🚧Port açalım(ufw allow yapmanız gerekirse 22 portunu yada hangi portla bağlanıyorsanız açmayı unutmayın. ufw allow 22)
```
sudo ufw allow 9650
sudo ufw allow 9651
```
### 🚧Kontrol
```
curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.isBootstrapped",
    "params": {
        "chain":"JUNE"
    }
}' -H 'content-type:application/json;' 192.168.10.2:9650/ext/info
```
* Çıktı şu şekilde olmalı

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/1847d059-c337-44fe-9934-4a9d2062c301)

### 🚧izinler
```
cd juneogo
```
```
sudo chown -R root .juneogo/
```

### 🚧Node id alalım
Not: çıkan çıktıyı kayddin
```
curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.getNodeID"
}' -H 'content-type:application/json' 192.168.10.2:9650/ext/info
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/a6ea8685-958a-4158-9a88-5530f4fcaba9)


### 🚧Cüzdan olusturalım

* [BURAYA](https://www.mcnwallet.io/) tıklayıp cüzdan olusturmaya gidelim. create deyin kelimeleri yedekleyin juneo chain adresini alın kaydedin

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/57c11b1c-7920-462e-85e6-4377f6e7ddc5)


> Cüzdanı oluşturduk. node idmizide aldık şimdi tg den iletişime geçen kişiye bilgilerimizi verıyoruz.

Wallet Adress :  0x le başlıyor mm adresim gibi

Node-id : NodeID- bele başlıyore mubarek

* Mallar gelince stake yapmamız lazım. web cüzdanında stakeye gelin.ordan validateye gelin. node idnizi yazın. miktarı yazın biraz kalsın hepsini etmeyin. tarih seçiyoruz burdan minimum 15 gün demişler.zaten sağda validate cıkıcak. onaylamaları geçtikten sonrası

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/18443616-0808-4105-b974-241054badf5b)

* https://mcnscan.io/validator/validator-list node idnizi yazıp aratın bele cıkması lazım

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/0a5bd6fe-2260-4dd2-b7b2-ea29e67c075a)

* 2 gün kadar minimum çalışması lazım demişler. bu şekilde. devamı ondan sonra.

* Not: stake etmek için öncelikle cross kısmından platform tarafına coinleri aktarmanız lazım 1010 kadar aktarım 1000 kadarını stake edebilirsiniz sonra. 

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/8874fd8f-11c7-47e7-86ec-9f43aaa041f2)

---------------------------------------------------------------------------------------------------------

# Create a Supernet

:laughing: ( Super mi net - net mi super - inanmassan dayıya sor )

Not: sorarsa herşeye yes ovrayt :D
```
apt install npm
```
```
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
```
```
sudo apt-get install -y nodejs
```
```
sudo dpkg -i --force-overwrite  /var/cache/apt/archives/nodejs_20.11.0-1nodesource1_amd64.deb
```
```
git clone https://github.com/Juneo-io/juneojs-examples
```
```
cd juneojs-examples
```
```
npm install
```
```
cp .env.example .env
```
```
nano .env
```
* Portaldakiolusturduğumuz cüzdanın kelimelerini içine girelim tırnakları silmeden ctrl x y enter ile kaydedip çıkalım.
```
npx ts-node ./src/docs/crossJUNEtoJVM.ts
```
```
npx ts-node ./src/docs/crossJVMtoP.ts
```
Not: yukarıda ki 2 işlemde ağlar arası mal taşımak için juneden jvmye ordanda 2ci kodla platform chaine 1.1 mal tasıyor. aslında bunları site üzerindende yapabilirsiniz ama kurulumunuzun doğru gittiğinden emin olmak için sunucuda yapıp yansıdığını sitede görüp devam etmek daha mantıklı. mumkunse işlemleri 2 şer kez yapınız.

* şimdide sıper mi net net mi kuralım :D
```
npx ts-node ./src/supernet/createSupernet.ts
```
* ve bize bele bi ID vericek kaydedin.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/eef28b97-72f8-4ed7-b1ba-600aa1fe906c)

* şimdide supernetimizda bir doğrulayıcı yok o yuzden doğrulayıcı ayarlamamız lazım kim bu arkadaş tabiki biz amale olmak bunu gerektirir :D 
```
nano /root/juneojs-examples/src/supernet/addSupernetValidator.ts
```
NOT: değişiklikleri yaptıktan sonra ctrl x y enter kaydedip cıkıyoruz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/121d6a08-38dd-41cb-8156-3b14a3da8e88)

- const nodeId: string = 'NodeID-Buraya node-id nizi yazın'
- const supernetId: string = 'ZxTjijy4iNthRzuFFzMH5RS2BgJemYxwgZbzqzEhZJWqSnwhP- temin bele bişi aldıkya onu yazın'
- const durationInDays: number = 4 // number of days you will validate your Supernet # Burayı ellemiyoruz
```
npx ts-node ./src/supernet/addSupernetValidator.ts
```
* supernet için değişiklikleri yaptık. bu nodumuzu supernet ağımız için doğrulayıcı olarak ekleyecek ancak bişi daha var yapılcak devam
* şimdi nodu durdurmamız gerekiyor.
```
docker stop juneogo
```
```
nano /root/juneogo-docker/juneogo/.juneogo/config.json
```
* burada alttaki kodu duzenleyip içersine eklememiz lazım. kendi node id nizi yazın daha sonra ilk parantezden sonra enter deyip boşluk bırakarak aynı izaha gelin yapıstırın ctrlx y enterla kaydedin. aşağıda nasıl görüneceğinin resmi var.

* "track-supernets":"ZxTjijy4iNthRzuFFzMH5RS2BgJemYxwgZbzqzEhZJWqSnwhP"

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/abd179ca-c522-4af4-9d57-02ccb1ee57a9)

* şimdi tekrar başlatalım
```
docker restart juneogo
```
```
docker logs -f juneogo
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/390b6e4f-475e-469c-ad1a-a671560b7666)

NOT: !!!

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/dcdf092b-a205-47a5-b661-80576e7ef190)


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/c1cbbdc4-d80f-43fb-85bd-06c972d00893)

-----------------------------------------------------------------------------

# Deploy VM

nano /root/juneojs-examples/src/supernet/createChain.ts

* içersindeki değiştirmemiz gereken yerler var. chain id : burdaki numara eşsiz olmalı aynı numarayı yazmayın. şu aralıklarda numara girmeniz lazım `For Socotra v1, please use a random number from 300,000 - 399,999.`

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/587344b3-3d2c-4b11-b941-654af353956a)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9e4355a4-adee-4f11-9348-532b695110ab)

```
cd
```
```
cd juneojs-examples
```
```
npx ts-node ./src/supernet/createChain.ts
```
Not: bize id veriyor kaydedin

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6fd463e5-e8d6-40ab-b67a-6b1cce319b65)

NOT: yukarda id aldık yeni onu yazıcanız aşağıdaki son yere düzenleyin.
```
mkdir /root/juneogo-docker/juneogo/.juneogo/configs/chains/yukarıda verdiği adresi yazın
```
NOT: yine yukardaki adresi yazın...
```
nano /root/juneogo-docker/juneogo/.juneogo/configs/chains/yukarıda verdiği adresi yazın/config.json
```
* içersine aşağıdaki kod kopyalayıp yapıstırın ve ctrl x y enterla kaydedip cıkın
```
{
"pruning-enabled": false,
  "eth-apis": ["public-eth", "public-eth-filter","net","web3","internal-public-eth","internal-public-blockchain","internal-public-transaction-pool","internal-public-debug","debug-tracer"]
}
```
* şimdide nodumuzu başlatalım. dosyayı gorunduğu gibi düzenleyin.ctrl x y enterla kaydedin.
```
nano /root/juneogo-docker/docker-compose.yml
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/cdb374b2-4862-4ee8-aa14-f1e0ad353521)

```
docker-compose up -d
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/487585da-0cb1-43de-9aa1-bf85998a3dd2)











