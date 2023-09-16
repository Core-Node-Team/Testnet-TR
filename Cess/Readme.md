<h1 align="center"> CESS | Storage Miner Testnet </h1>

<div align="center"
     
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/f52b6797-1e69-4d84-a5e3-8d84f9d0339e)
   
     
# [Website](https://www.cess.cloud/) | [Twitter](https://twitter.com/CESS_Storage) | [Discord](https://discord.gg/dyMHNS6D) | [Github](https://github.com/CESSProject) | [Docs](https://docs.cess.cloud/cess-build-book/) | [Whitepaper](https://www.cess.cloud/theme/cess/globe/CESS--Cumulus_Encrypted_Storage_System_v0.4.pdf)  
     
 </div>

#

## Merhaba arkadaşlar bugün [Cess](https://www.cess.cloud/) projesinin teşvikli testentine katılacağız. Başlamadan önce projenin dökümanlarını ve sosyal medya hesaplarını inceleyip kendi araştırmanızı yapın ve testnet ile ilgili bu [bloğu](https://medium.com/@CESS_LAB/cumulus-encrypted-storage-system-cess-testnet-v0-6-0-launches-on-july-4th-52c30686eb2f) okuyun.

## Cess açılımı Cumulus Encrypted Storage System. Kısacası merkezi olmayan bir yapıya sahip olan ve kullanıcıların verilerini güvenli bir şekilde depolamalarını sağlayan bir bulut depolama sistemidir.

## Testnetine iki farklı şekilde katılınabilir. Bu rehberde ***storage miner*** kurulumunu anlatıcam ***consensus miner*** kurmak isteyenler için [rehber](https://docs.cess.cloud/cess-build-book/consensus-miners)

## Mining, depolama alanı ile yapılıyor. Sunucu gereksinimleri 4Cpu 8Gb Ram Ssd miktarı ne kadar büyük olursa ***storage power*** da o kadar büyük olur dolayısıyla kazacağınız miktar da .

## Storage minerelar  600,000 Cess tokena karşılık gelen 6000 puanı paylaşacak. Puanlar minerların storage powerlarına göre dağılıyor.

# Kurulum
> Komutları sırayla girin
```
wget https://github.com/CESSProject/cess-nodeadm/archive/v0.3.3.tar.gz
tar -xvf v0.3.3.tar.gz
rm -rf v0.3.3.tar.gz
cd cess-nodeadm-0.3.3/
./install.sh
mkdir /opt/cess/storage/disk
```

# Cüzdan 
### Storage miner olmak için iki adet cüzdana ihtiyacınız var. Birisi gelen ödülelrin yatacağı hesap diğeri stake etmek ve işlemleri imzalamak için kullanılacak hesap.
### [Polkadot{.js}](https://polkadot.js.org/extension/) walletı açın ve iki tane yeni hesap oluşturun ardından [explorera](https://cloudflare-ipfs.com/ipns/dotapps.io/?rpc=wss%3A%2F%2Ftestnet-rpc0.cess.cloud%2Fws%2F#/accounts) gidin cüzdanı bağladıktan sonra ***accounts*** sekmesi altında adresleriniz görünecek.
### [Faucetten](https://testnet-faucet.cess.cloud/) test tokenları alın.

# Başlatma
```
cess config set
```
> ### Komutu girdikten sonra sırasıyla;
> 1. soru storage yazın
> 2. soru sunucunuzun ip adresini girin
> 3. default port kullanmak istiyordanız enter değilse port numarası girin
> 4. ödüllerin geleceği cüzdanın adresini girin
> 5. stake için kullanacağınız cüzdanın mnemonic girin
> 6. enter
> 7. ne kadar depolama alını kullanmak istediğinizi girin


> ### Başlat
```
cess start
```
# Kontrol
 ### Chain logları
 > `best` ulaştığınız blok yüksekliğiir [exploreri](https://cloudflare-ipfs.com/ipns/dotapps.io/?rpc=wss%3A%2F%2Ftestnet-rpc0.cess.cloud%2Fws%2F#/explorer) yakalayana kadar bekleyin
```
docker logs chain
```
### Bucket logları
```
docker logs bucket
```
### Bucket durum
```
cess bucket stat
```
### [EXPLORERDA](https://substats.cess.cloud/) Miner kısmına gelip cüzdan adresinizi arayın.

## Yararlı komutlar

### Stake miktarını yükselt
```
cess bucket increase <miktar>
```
### Withdraw
```
cess bucket withdraw
```
### Ödül bilgisi
```
cess bucket reward
```
### Claim
```
cess bucket claim
```
### Tüm servisleri güncelle
``` 
cess pullimg
```
### Tüm servisleri durdur ve sil
```
cess down
```
### Kazanç hesabını değiştir
```
cess bucket update earnings <cüzdan adresi>
```

<div align="center">

# Core Node 

#  [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)  

![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

## Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.
#

</div>

