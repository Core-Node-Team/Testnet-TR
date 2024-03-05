<h1 align="center"> CESS | Storage Miner Testnet </h1>

<div align="center"
     
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/f52b6797-1e69-4d84-a5e3-8d84f9d0339e)
   
     
# [Website](https://www.cess.cloud/) | [Twitter](https://twitter.com/CESS_Storage) | [Discord](https://discord.gg/DyEzq6Js) | [Github](https://github.com/CESSProject) | [Docs](https://docs.cess.cloud/cess-build-book/)
     
 </div>

#

## Merhaba arkadaşlar bugün [Cess](https://www.cess.cloud/) projesinin teşvikli testentine katılacağız. Başlamadan önce projenin dökümanlarını ve sosyal medya hesaplarını inceleyip kendi araştırmanızı yapın.

## Cess açılımı Cumulus Encrypted Storage System. Kısacası merkezi olmayan bir yapıya sahip olan ve kullanıcıların verilerini güvenli bir şekilde depolamalarını sağlayan bir bulut depolama sistemidir.

## Testnetine iki farklı şekilde katılınabilir. Bu rehberde ***storage miner*** kurulumunu anlatıcam ***consensus miner*** kurmak isteyenler için [rehber](https://docs.cess.cloud/cess-build-book/consensus-miner)

## Mining, depolama alanı ile yapılıyor. Sunucu gereksinimleri 4Cpu 8Gb Ram Ssd miktarı ne kadar büyük olursa ***storage power*** da o kadar büyük olur dolayısıyla kazacağınız miktar da .

### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4+ vcpu|
| ✔️RAM	| 8+ GB |
| ✔️Storage	| 160+ GB SSD(nekadar-çok-okadar-ödül) |
| ✔️UBUNTU | 22or20 |

# Kurulum
> Komutları sırayla girin. UNUTMAYIN HERHANGİ BİR POLKA TABANLI PROJE VARSA SIKINTI ÇIKAR.
```
ufw allow 4001
wget https://github.com/CESSProject/cess-nodeadm/archive/v0.5.5.tar.gz
tar -xvf v0.5.5.tar.gz
rm -rf v0.5.5.tar.gz
cd cess-nodeadm-0.5.5/
./install.sh
mkdir -p /opt/cess/storage/disk
```

# Cüzdan 
### Storage miner olmak için iki adet cüzdana ihtiyacınız var. Birisi gelen ödülelrin yatacağı hesap diğeri stake etmek ve işlemleri imzalamak için kullanılacak hesap.
### [Polkadot{.js}](https://polkadot.js.org/extension/) walletı açın ve iki tane yeni hesap oluşturun Cess test ağında olan adresleri alın-ADRES CX İLE BAŞLAYACAK- ardından [explorera](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ftestnet-rpc0.cess.cloud%2Fws%2F#/accounts) gidin cüzdanı bağladıktan sonra ***accounts*** sekmesi altında adresleriniz görünecek. Farklı rpc [Explorer](https://testnet.cess.cloud/?rpc=wss%3A%2F%2Ftestnet-rpc2.cess.cloud%2Fws%2F#/accounts)
### [Faucetten](https://cess.cloud/faucet.html) test tokenları alın.

# Başlatma
```
cess config set
```
> ### Komutu girdikten sonra sırasıyla;
> 1. soru storage yazın
> 2. default port kullanmak istiyordanız enter değilse port numarası girin
> 3. ödüllerin geleceği cüzdanın adresini girin (bak adres diyorum)
> 4. stake için kullanacağınız cüzdanın mnemonic girin(yeni cüzdan bu sadece stake için )
> 5. /opt/cess/storage/disk   bunu görüp enter. sayı yazmayın  (zaten dosyasını olusturduk enter dıyoruz)
> 6. ne kadar depolama alını kullanmak istediğinizi girin (sadece sayı gb cinsinden 500gb sadece 500 yazıonuz)
> 7. işlemci core sayısı 4 yazıyoruz
> 8. diğer stake hesabını soruyor enter dıyoruz buna
> 9. worker soruyor enter dıyoruz


> ### Başlat
```
cess start
```
# Kontrol
 ### Chain logları
 > `best` ulaştığınız blok yüksekliğiir [exploreri](https://cloudflare-ipfs.com/ipns/dotapps.io/?rpc=wss%3A%2F%2Ftestnet-rpc0.cess.cloud%2Fws%2F#/explorer) yakalayana kadar bekleyin farklı rpc [explorer](https://testnet.cess.cloud/?rpc=wss%3A%2F%2Ftestnet-rpc2.cess.cloud%2Fws%2F#/accounts)
```
docker logs -f chain
```
### Bucket logları
```
docker logs -f bucket
```
### Bucket durum
```
cess bucket stat
```
### [EXPLORERDA](https://substats.cess.cloud/) Miner kısmına gelip cüzdan adresinizi arayın.

## Yararlı komutlar



<div align="center">

# Core Node 

#  [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)  

![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

## Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.
#

</div>
