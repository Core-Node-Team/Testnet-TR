<h1 align="center"> Opside Network | Pre-Alpha Testnet </h1>

<div align="center">

![240452111-1e5e96ef-77de-4db3-bf78-42304b162bc8](https://github.com/enzifiri/asdasd/assets/76253089/7a6be974-2ee9-4457-ae11-15b49ab73a79)


#  | [Twitter](https://twitter.com/OpsideZK) | [Discord](https://discord.gg/opside) | [Website](https://ziesha.network/) | [Telegram](https://t.me/OpsideTurkish) |

</div>

# Merhaba Arkadaşlar, Merakla beklediğimiz Opside Testneti nihayet bizimle. Sağ üstten Fork + Star tusuna basarak destek olabilirsiniz. 
#
> ## Testnete sadece seçilenler katılabiliyor.
> ## Bitiş tarihi belli değil.
> ## Gerksinimler: `Ubuntu 20.04, 4+CPU 16+RAM 500GB SSD`(min)
> ## Sorularınızı Sohbet grubumuza gelip sorabilirsiniz. [Sohbet Grubumuz](https://t.me/corenodechat)
#
## Kuruluma Başlayalım.

## Sunucu Güncellemesi
```
sudo apt-get update -y && sudo apt-get upgrade -y
```

## Gerekli Kütüphaneleri yükleyelim.
```
sudo apt install -y build-essential libssl-dev cmake screen git htop
```
```
wget -c https://pre-alpha-download.opside.network/testnet-auto-install-v2.tar.gz 
```
```
tar -C ./ -xzf testnet-auto-install-v2.tar.gz
```
```
chmod +x -R ./testnet-auto-install-v2
```
## Kuruluma başlayalım.
```
cd ./testnet-auto-install-v2
```
```
./install-ubuntu-en-1.0.sh
```
## Bu adımda DİKKAT! , Üstteki komutu yazdıktan sonra bizden bilgileri doldurmamızı isteyecek
> ## 1. Ödüllerin gelmesini istediğiniz Metamask adresinizi yazın.
> ## 2. Şifre belirleyin. (Validatör imza anahtarınızı şifreleyecek)
> ## 3. Tekrar Metamask adresinizi yazın.
> ## 4. Şifreyi tekrar yazın
> ## Sonrasında size 24 haneli Mnemonicler verecek bunları not defterine yedekleyin, sonraki adımda bizden isteyecek fakat kopyala yapıştır yapmamamız gerekiyor! Nedeni ise her kelimenin sadece ilk 4 hanesini kabul ediyor. O yüzden sizden kelimeleri istediğinizde kelimelerin sadece ilk 4 hanesini gireceksiniz, alttaki görselde örneği görebilirsiniz. 
![image](https://github.com/enzifiri/asdasd/assets/76253089/0c2a3c51-18b9-4536-84ad-006f9bcfad12)

## Sunucudaki işlemimiz bitti. [Discord kanalından](https://discord.gg/opside) kullandığımız cüzdana token talep edip Website kullanarak Validatör oluşturacağız. 

## Öncelikle faucetten token talep edelim.

> ### Soldan Faucet Menüsü altındaki #for-validators kanalına girin.
> ### Bu komutla tokenlerinizi talep edin. "@Opside Faucet 0xCüzdanAdresiniz"
> ### Başarılı olursanız alttaki gibi çıktı alacaksınız. Hata verirse adresiniz testnete seçilmemiştir. :(
![image](https://github.com/enzifiri/asdasd/assets/76253089/85e01c3c-1b85-4331-be75-67ea4dc1eedc)

## Validatörümüzü oluşturalım.

>## [Websiteye girin](https://opside.network/validator/deposit)
>## Testnet cüzdanınızı bağlayın (Faucetten token talep ettiğinizi)
>## Karşınıza çıkacak olan tüm Contiune, I accept tuşlarına basıp şartları kabul edin.
![image](https://github.com/enzifiri/asdasd/assets/76253089/1811bc04-50b4-4f23-8bce-1c2b78226d3a)

>## Sonra sayfayı en alta çekip tekrar contiune tusuna basın. 
>## Buraya sunucudaki  "root/testnet-auto-install-v2/validator_keys/deposit_data1.." dizinindeki dosyayı alıp yüklemeniz gerekiyor. WinScp ya da MobaXTerm kullanarak bu dosyayı bilgisayarına indirin. Sonrasında ise websiteye yükleyin. <br> [WinScpyi nasıl kullanacağınızı bilmiyorsanız tıklayın](https://github.com/Core-Node-Team/cosmos-node-backup)
>![image](https://github.com/enzifiri/asdasd/assets/76253089/ac9bb626-9fea-4ee3-bd59-8db34d81ffed)
>## Dosyayı yükledikten sonra sizden yine onaylar isteyecek hepsinin tikini onaylayıp Contiune tuşuna basın.
>![image](https://github.com/enzifiri/asdasd/assets/76253089/0dd22d89-91b3-4b79-8ef3-8fd9410e6eff)
>## Sonrasında 25K Tokenimizi stake etmek kalıyor. Confirm deposit tuşuna basın, metamask onayını verin, contiune tuşuna basın.. <br> İşlemlerimiz bu kadardı.
>![image](https://github.com/enzifiri/asdasd/assets/76253089/6ac4d5bc-fcc7-4dab-b7c1-d506cf67c868)

## İşe yarar komutlar
### Client Logları göster. (Başarılı Log örneği)
![image](https://github.com/enzifiri/asdasd/assets/76253089/96ba203f-b2f0-4496-98e0-28f336dfd76b)

`` opside-chain/show-geth-log.sh ``

### Consensus client logları göster.
`` opside-chain/show-beaconChain-log.sh ``

### Validatör loglarını göster.
`` opside-chain/show-validator-log.sh ``
