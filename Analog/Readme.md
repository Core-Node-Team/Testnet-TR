<p align="center">
</p>
<h1>
<p align="center"> Analog </p>
</h1>

<p align="center">
  <a href="https://www.analog.one/">Website</a> 
  <a href="https://x.com/OneAnalog">Twitter</a> 
  <a href="https://docs.analog.one/documentation/node-operators/running-a-timechain-node/">Dokumanlar</a> 
  <a href="https://coinlist.co/analog-testnet?utm_source=dashboard&utm_medium=web&utm_campaign=analog+testnet/">Coinlist</a>
</p>



* Minimum Sistem Gereksinimleri

```console
Hardware: 8 vCPUs, 16 GB Ram, 300 GB Disk
Port: 9947
Network: 500 MBps
Ubuntu: Version 22.04

```


* Güncellemeleri yapalım

```console
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
```

* Docker kuralım

```console
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```

* Docker bileşenlerini yükleyelim

```console
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

* Analog Timechain Docker görüntüsünü çekelim

```console
docker pull analoglabs/timechain
```

* Analog dizinini oluşturalım
```console
mkdir -p $(pwd)/.analog
```

----------------------------------------------------
* Eğerkine daha önceden çalıştırdı iseniz key aldı iseniz sezon key unutun. aşağıdakini girmeden ( konu yukleyıp eşleşemesi için bekleyenler için ) unutmayın bu kısım daha once kurmuş olanlar için yani vali falan kurmamış olanalr için ve evet port değiştirdim bilocan artık baska polka ile çakışmaması lazımdur.
```
docker stop analog
docker rm analog
cd
rm -rf .analog
```
------------------------------------ * Önemli: adini-yaz kısmına isminizi yazın telemetry adınız bu 
```console
docker run -d -p 9947:9944 -p 30303:30303 -v $(pwd)/.analog:/.analog --name analog analoglabs/timechain --base-path /.analog --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external --rpc-cors=all --name adini-yaz --telemetry-url "wss://telemetry.analog.one/submit 0" --sync warp
```


* Websocat'i yükleyelim

```console
curl -LO https://github.com/vi/websocat/releases/download/v1.7.0/websocat_amd64-linux
chmod +x websocat_amd64-linux
sudo mv websocat_amd64-linux /usr/local/bin/websocat
```

* Websocat'i check edelim

```console
websocat --version
```

* |websocat version 1.7.0 olmalı|

* Author_rotateKeys method ile "SESSION KEY'imizi" alalım.


```console
echo '{"id":1,"jsonrpc":"2.0","method":"author_rotateKeys","params":[]}' | websocat -n1 -B 99999999 ws://127.0.0.1:9947
```


* Telemetryde sınır var isminiz görünmeyebilir. 

* [Telemetry](https://telemetry.analog.one/)




* Son işlemler için Polkadot.js'ye bağlanmamız gerekiyor
* Öncelikle Subwallet ile bir cüzdan oluşturalım.
* Daha sonra aşağıdaki link üzerinden siteye cüzdanımızı bağlayalım
* [PolkadotDashboard](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Fanalog-corenode.strangled.net#/accounts)
* [Discord](https://discord.com/invite/analog/) adreslerine gidip Analog adresimize, Faucet'ten token alalım.


# Token geldi mi? Eğer geldiyse birkaç işlemimiz daha olacak

* İlk olarak PolkadotDashboard sitesine giriş yapalım
* Sırasıyla: Network, Staking, Accounts bölümüne gidelim
* Sağ kısımda "Validator"e tıklayalım ve Stash Account bölümüne Faucet aldığımız cüzdanı ekleyelim. Fee bırakacak şekilde elimizde bulunan token'ları stake edeceğiz.
* (Minimum 0.9 adet Analog stake etmek gerekiyor. Bana kalırsa daha fazlasını stake edin. 12 saatte bir fauceti kullanabilirsiniz)
* Next dedikten sonra (Keys From Rotatekeys) kısmına daha önceden almış olduğumuz Session Key'imizi ekleyelim. (Sadece adres kısmını ekliyoruz, tırnaklar vs. olmadan)


* Böyle bir sonuca sahip olmanız gerekiyor
<img width="1071" alt="Ekran Resmi 2024-06-30 10 03 47" src="https://github.com/kaplanbitcoin1/Analog-Node/assets/98455323/72228575-41e5-4ffa-9e73-b9108c0e5cd1">


> Son olarak başvuru [Form'unu](https://l5d87lam6fy.typeform.com/to/kwlADm6U/) dolduralım. Seçilmemiz halinde bize mail gönderilecek. -Form doldururken referans soruluyor. İsteyen corenode yazabilir ( bu repoda gordukleri için benim adımı yazmamaları için değştirdim)


> Bu arada projenin testnet görevleri de var. Contract deploy etme Smart Contract oluşturma vs. gibi. Ben belli bir süre bu görevleri yaptım ve diğer projelere nazaran Analog, kullanıcılara bir şeyleri öğretmeyi hedefliyor. İsteyen [Sitede'ki](https://testnet.analog.one/#/quests/) görevlere göz atabilir. Aynı cüzdan adresinizle görevleri yapabilirsiniz. Seçilmemiz halinde sitedeki validator kısmına eklenmiş olacağız sanırım. Bu da bizlere ekstra puanlar getirmiş olacak.  


* Logları kontrol etme
  
```console
docker logs -f analog -n 100
```
* Analog başlatma
```console
docker start analog
```
* Analog restart
```console
docker restart analog
```
* Analog durdurma
```console
docker stop analog
```

> [Lorento](https://github.com/Lorento34/) katkılarından dolayı teşekkürler ✅
> [Kaplan](https://github.com/kaplanbitcoin1/) katkılarından dolayı teşekkürler ✅
