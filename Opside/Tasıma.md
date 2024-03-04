# opside-tasıma

# taşımak istiyorsunuz
# sıfırdan kurun herşeyi yapmamıs gibi kurulumunuzu yapın ve bitirin sonra...( aynı şekilde aynı cüzdan ve aynı şifre)


```
cd
cd testnet-auto-install-v2
```
```
opside-chain/stop-all.sh
```

yapalım.

wincpten bağlanalım 

yedek aldığımız validator keys dosyasını donucez eskisini silin ve kendi dosyanızı atın
/root/testnet-auto-install-v2/       (burda)

sonra
winscp ile aşağıdaki yere girin ve yedeğinizdeki key store dosyanızı buraya kopyalayın

/root/testnet-auto-install-v2/opside-chain/prysm/validator/config/wallet/

not; içerde bir adet key store olucak onu siliniz. kendinizinkini atınız


# terminale donelim

```
cd
```
```
testnet-auto-install-v2/opside-chain/start-geth.sh
```
```
testnet-auto-install-v2/opside-chain/start-beaconChain.sh
```
```
testnet-auto-install-v2/opside-chain/start-validator.sh
```
validatorude girince en son bele dicek

Successfully imported 1 accounts, view all of them by running `accounts list`

# sonra loglarımızı kontrol edıyoruz

```
cd
cd testnet-auto-install-v2/
```
```
opside-chain/show-geth-log.sh
```
```
opside-chain/show-beaconChain-log.sh
```
```
opside-chain/show-validator-log.sh
```

## OLMADI MI?  speciel teknik...

v3 kuruyoruz bizden menemonic isteyecek menemoniclerimizi girip denedik ama aynı pubkeyi vermediyse.   v3 menemonic istediğinde menemoniclerin ilk 4 harfini yazaıyoruz hata vericek amaçta bu hata verip cüzdan eklememesi FATAL görücez . çok güzel :D  alttaki kodu yazıp durduralım.
```
cd
cd testnet-auto-install-v3
opside-chain/stop-all.sh
```
### v2 deyken aldığım yedek dosyalarını validator dosyalarını sunucumuza yukleyelim ardından başlatalım.
```
cd
testnet-auto-install-v3/opside-chain/start-geth.sh
testnet-auto-install-v3/opside-chain/start-beaconChain.sh
testnet-auto-install-v3/opside-chain/start-validator.sh
```

### NOT: daha sonra control panelinden 8 ze sona zaten 1 çıkıyor basıp çıkan pubkeyin bizim yedekteki dosya ile aynı pubkey olduğundan emin olalım. ve ardından validator loglarımıza bakalım deposit bakiye yukleme beklenıor gibi değilde normal loglar gelmeye baslıyacaktır. uzun zaman alıyor site üzerinde düzelmesi validator logları duzgunse sorun yok.
