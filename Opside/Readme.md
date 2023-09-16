
 <h1 align="center"> Opside Network | Pre-Alpha Testnet </h1>

<div align="center">

![240452111-1e5e96ef-77de-4db3-bf78-42304b162bc8](https://github.com/enzifiri/asdasd/assets/76253089/7a6be974-2ee9-4457-ae11-15b49ab73a79)


#  | [Twitter](https://twitter.com/OpsideZK) | [Discord](https://discord.gg/opside) | [Website](https://opside.network/) | [Telegram](https://t.me/corenodechat) |

</div>

# Merhaba Arkadaşlar, Merakla beklediğimiz Opside Testneti nihayet bizimle. Sağ üstten Fork + Star tusuna basarak destek olabilirsiniz. 
#
> ## Testnete sadece seçilenler katılabiliyor.
> ## 3 Ay Sürecek.
> ## Kurulumdan sonra Validatörün explorerda gözükmesi 16-24 saat sürüyor. Acele etmeyin.
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

### Kurulum tamamlandıktan sonra logları kontrol edin
> ### `opside-chain/show-geth-log.sh `
> - Bu şekilde olması gerekiyor
> 
> ![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/c21aa497-6a6b-4a73-a4ed-1ffc5d8a99b0)

## Sunucudaki işlemimiz bitti. Validatör keylerinin yedeğini aldıktan sonra [Discord kanalından](https://discord.gg/opside) kullandığımız cüzdana token talep edip Website kullanarak Validatör oluşturacağız. 

<h1 align="center"> Yedek Alma </h1>
 
> ### Sunucunuza winscp veya mobaxterm ile bağlanıp `/root/testnet-auto-install/validator_keys` altındaki `deposit_data-xxx.json` ve `keystore-xxx.json` ismindeki iki dosyayı bilgisayarınıza indirerek yedekleyin
> ### Sadece `deposit_data-xxx.json` dosyasını ile işlem yapacağız, diğer `keystore-xxx.json` isimli dosyayı sadece güvende saklayın

<h1 align="center"> Validatör Oluşturma </h1>
 
## Öncelikle faucetten token talep edelim.
> ### Soldan Faucet Menüsü altındaki #for-validators kanalına girin.
> ### Bu komutla tokenlerinizi talep edin. "@Opside Faucet 0xCüzdanAdresiniz"
> ### Başarılı olursanız alttaki gibi çıktı alacaksınız. Hata verirse adresiniz testnete seçilmemiştir. :(
![image](https://github.com/enzifiri/asdasd/assets/76253089/85e01c3c-1b85-4331-be75-67ea4dc1eedc)

## Sync Kontrol
## NOT: NODE SYNC OLMADAN TOKENLERİ STAKE ETMEYECEĞİZ!!! SYNC OLDUKTAN SONRA TOKENLERİ STAKE EDECEĞİZ! BURASI ÇOK ÖNEMLİ!
> ### Geth loglarında ulaştığınız blok yüksekliğini görebilirsiniz
>  - `number` ulaştığınız blok yüksekliği, explorer ile karşılaştırarak sync kontrol edebilirsiniz
>  
> ![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/b07f1713-00fe-4192-87e3-523ee5cbb41f)
>  ### [Explorer](https://pre-alpha-beacon.opside.info/)

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

## [Explorerdan](https://pre-alpha-beacon.opside.info/) Validatörünüzü kontrol etmek için,
>## "/root/testnet-auto-install-v2/validator_keys/" dizinindeki keystore ile başlayan dosyanın içini açın ve pubkey adresinizi kopyalayıp explorerda aratın
>![image](https://github.com/Core-Node-Team/Testnet-TR/assets/76253089/9ced6fac-76d7-47ef-9793-30720e362021)
## Validatörün aktif hale gelmesi 16-24 saat sürebilir.


## Buraya kadar hata almadan yaptıysanız
## Execution layer logları böyle görünecek `opside-chain/show-geth-log.sh`
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/c21aa497-6a6b-4a73-a4ed-1ffc5d8a99b0)

## Consensus layer logları buna benzer görünecek `opside-chain/show-beaconChain-log.sh`
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/d6456490-b7ce-48ef-bb6c-59bfebdf4393)

![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/a63ec569-cfc7-4a43-a521-73af78a13dd6)


## Validatör logları (aktif olana kadar) böyle görünecek `opside-chain/show-validator-log.sh`
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/45fb5221-e87e-4237-855e-2e12e1dfc058)


## Validatör logları (aktif olduktan sonra) böyle görünecek
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/63f7c82c-fe45-4a81-ae3f-420b55be7ba6)

#
#

<div align="center">

# Core Node Sosyal Medya [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)
  
![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

## Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.
#

</div>

<h1 align="center"> Yararlı Komutlar </h1>

## Execution layer logları
> ## `opside-chain/show-geth-log.sh`
## Consensus layer logları
> ## `opside-chain/show-beaconChain-log.sh`
## Validator logları
> ## `opside-chain/show-validator-log.sh`
## Execution layer başlatma
> ## `opside-chain/start-geth.sh`
## Consensus layer başlatma
> ## `opside-chain/start-beaconChain.sh`
## Validatör başlatma
> ## `opside-chain/start-validator.sh`
## Tamamını durdurma
> ## `opside-chain/stop-all.sh`


