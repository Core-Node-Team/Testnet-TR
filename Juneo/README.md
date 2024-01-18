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







