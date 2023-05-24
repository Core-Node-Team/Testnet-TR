<h1 align="center"> Opside Network | Pre-Alpha Testnet </h1>

<div align="center">

![240452111-1e5e96ef-77de-4db3-bf78-42304b162bc8](https://github.com/enzifiri/asdasd/assets/76253089/7a6be974-2ee9-4457-ae11-15b49ab73a79)


#  | [Twitter](https://twitter.com/OpsideZK) | [Discord](https://discord.gg/opside) | [Website](https://opside.network/) | [Telegram](https://t.me/OpsideTurkish) |

</div>

# Merhaba Arkadaşlar, Merakla beklediğimiz Opside Testneti nihayet bizimle. Sağ üstten Fork + Star tusuna basarak destek olabilirsiniz. 
#
> ## Testnete sadece seçilenler katılabiliyor.
> ## 3 Ay Sürecek.
> ## Gerksinimler: `Ubuntu 20.04, 4+CPU 16+RAM 500GB SSD`(min)
> ## Sorularınızı Sohbet grubumuza gelip sorabilirsiniz. [Sohbet Grubumuz](https://t.me/corenodechat)
#

<h1 align="center"> Node Kurulumu </h1>

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
> ## Sonrasında size 24 haneli Mnemonicler verecek bunları not defterine yedekleyin, kelimeleri kopyalayın ve sizden istediği yere yapıştırın.

## Sunucudaki işlemimiz bitti. Validatör keylerin yedeğini aldıktan sonra  [Discord kanalından](https://discord.gg/opside) kullandığımız cüzdana token talep edip Website kullanarak Validatör oluşturacağız. 

<h1 align="center"> Yedek Alma </h1>

> ### Winscp veya Mobaxter ile sunucunuzda `/root/testnet-auto-install/validator_keys/` altındaki `deposit_data-xxx.json` ve `keystore-m_x_x-xxxx.json` ismindeki iki dosyayı bilgisayarınıza indirip yedekleyin.

> ### Sadece `keystore-m_x_x-xxxx.json` isimli dosya ile işlem yapacağız diğerini `deposit_data-xxx.json` dosyasını sadece güvenle saklayın

#

<h1 align="center"> Validatör Oluşturma </h1>

## Öncelikle faucetten token talep edelim.

> ### Soldan Faucet Menüsü altındaki #for-validators kanalına girin.
> ### Bu komutla tokenlerinizi talep edin. "@Opside Faucet 0xCüzdanAdresiniz"
> ### Başarılı olursanız alttaki gibi çıktı alacaksınız. Hata verirse adresiniz testnete seçilmemiştir. :(
![image](https://github.com/enzifiri/asdasd/assets/76253089/85e01c3c-1b85-4331-be75-67ea4dc1eedc)

## Sync Kontrol

## NOT: NODE SYNC OLMADAN TOKENLERİ STAKE ETMEYECEĞİZ!!! SYNC OLDUKTAN SONRA TOKENLERİ STAKE EDECEĞİZ! BURASI ÇOK ÖNEMLİ!
> ### Geth loglarında ulaştığınız blok yüksekliğini öğrenebilirsiniz `opside-chain/show-geth-log.sh`
>  - `number` ulaştığınız blok yüksekliğidir, explorer ile karşılaştırarak sync kontrol edebilirsiniz.
>  
>  ![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/07767b57-86ff-4823-a3f6-7b598b4fad48)
> ### [Explorer](https://pre-alpha.opside.info/)


## Stake İşlemi

>## [Websiteye girin](https://opside.network/validator/deposit)
>## Testnet cüzdanınızı bağlayın (Faucetten token talep ettiğinizi)
>## Karşınıza çıkacak olan tüm Contiune, I accept tuşlarına basıp şartları kabul edin.
![image](https://github.com/enzifiri/asdasd/assets/76253089/1811bc04-50b4-4f23-8bce-1c2b78226d3a)

>## Sonra sayfayı en alta çekip tekrar contiune tusuna basın. 
>## Buraya sunucudaki  "root/testnet-auto-install-v2/validator_keys/deposit_data1.." dizinindeki dosyayı alıp yüklemeniz gerekiyor. WinScp ya da MobaXTerm kullanarak bu dosyayı bilgisayarına indirin. Sonrasında ise websiteye yükleyin. <br> [WinScpyi nasıl kullanacağınızı bilmiyorsanız tıklayın](https://github.com/Core-Node-Team/cosmos-node-backup)
>![image](https://github.com/enzifiri/asdasd/assets/76253089/ac9bb626-9fea-4ee3-bd59-8db34d81ffed)
>## Dosyayı yükledikten sonra sizden yine onaylar isteyecek hepsinin tikini onaylayıp Contiune tuşuna basın.
>![image](https://github.com/enzifiri/asdasd/assets/76253089/0dd22d89-91b3-4b79-8ef3-8fd9410e6eff)
>## Sonrasında 25K Tokenimizi stake etmek kalıyor. ANCAK EĞER NODE SYNC OLMADIYSA SYNC OLMASINI BEKLEYİN!!! Confirm deposit tuşuna basın, metamask onayını verin, contiune tuşuna basın.. <br> İşlemlerimiz bu kadardı.
>![image](https://github.com/enzifiri/asdasd/assets/76253089/6ac4d5bc-fcc7-4dab-b7c1-d506cf67c868)

## Validatörünüz aktif hale gelmesi 16-24 saat arası sürebilir.



## Buraya kadar hata almadan yaptıysanız
## Geth Logları böyle görünecek. `` opside-chain/show-geth-log.sh ``
![image](https://github.com/enzifiri/asdasd/assets/76253089/96ba203f-b2f0-4496-98e0-28f336dfd76b)
## Beacon logları buna benzer görünecek `` opside-chain/show-beaconChain-log.sh ``
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/e71c760c-506c-40fa-b8ab-1f7a1d1e4fbf)
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/f49589d4-9f1a-4916-b86e-1c6da2095be8)
## Validatör logları (aktif olana kadar) `` opside-chain/show-validator-log.sh ``
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/09b30163-eb24-45e1-be62-1467003fc1b0)
#
#
<div align="center">

# Core Node Sosyal Medya [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)

  
![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

### Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.


</div>


