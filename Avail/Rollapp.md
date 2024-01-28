
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/65de285e-bd1d-438a-8f4c-ed2d2fa5d558)


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b8fa92da-cdbc-4442-8891-62b293c6c36e)


# KOMPLE HERŞEYİ OKUYUN HEPSİNİ SONRA BAŞLAYIN...

### Kurulum
```
ufw allow 26657
ufw allow 8545
ufw allow 1317
ufw allow 22
```

```
curl -L https://dymensionxyz.github.io/roller/install.sh | bash
```
```
roller version
```
```
roller config init --interactive
```
👉 floopyland

👉 roller tipini seçin

👉 roller adını yazın corenode gibimsi

👉 3 harfli her hangi bir coin kısa yolu yazınız Mll gibim

👉 total mikarını belirleyin supply. ancak hep az giriyorsunuz lütfen dokunmadan enterla geçin

👉 avail seçtim

👉 3 adres çıkıcak 2 si dym 1 avail discorda faucetleri var alın ve explorerden kontrol edin. avail için cüzdan import edenler lütfen import ettikleri adrese faucet alsın
* dym faucet için rollape yada rollappfam rolu gerekiyordu availle olan testleri için herkese açtılarmı bilmiyoruz lütfen discordan faucet alabiliyormusunuz kontrol edin.

* geldik çokomelli kısma availdeki cüzdanı import edelim
```
nano /root/.roller/da-light-node/avail.toml
```
* içindeki kelimeleri silin ekndi cüzdan kelimelerinizi girin.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/88abce80-006c-42b9-8f9d-c8ecb33d6140)

* ve buradada kelimeleri değiştirin ctrl x y kaydedin
```
nano /root/.roller/rollapp/config/dymint.toml
```
```
systemctl daemon-reload
```

NOt: değişmişmi avail adres bakalım
```
roller keys list
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/7e033f59-26f2-4982-83b8-194b20dfb0d3)


* avail faucet alın. discorddan pass onaylı olmak gerekiyor. eğer zaten eskiden katılan ve puan toplayansanız ilave alın.
* daha sonra register edelim
```
roller tx register
```
```
apt install screen
```
```
screen -S rol
```
```
roller run
```



👉NOT: screenden çıkmak için `ctrl ad`    ile çıkıyoruz tekrar bakmak için `screen -r rol`  giriyoruz
👉NOT: `screen -ls`  açık screenleri gösterir ataç olmuş varsa `screen -d screen-adı` sonra `screen -r screen-adı`   kapamak için screene girin exit yazın...
👉NOT: rollapınız kanal buldu ehrsey hazır dym discorda pr attıktan sonra pr linkinizle portalda yayınlamak için modlara sorun. şuan için listelemeyi ve portala eklemek konusunda biraz akrısıklık var
```
roller tx fund-faucet
```
👉NOT: daha sonra aşağıdan dyn dşscordan floopy land faucetten kendi tokeninizi alıp portalda işlem yapın
```
$request cüzdan-adresiniz rollapp-idniz
```

https://portal.dymension.xyz

Not:  dizden rollap linki isterseler altaki siten arama yerine rollapp id nizi yazıp aratın cıkandan tıklayın o linki atın.

https://fl.dym.fyi/rollapp/corenode_6886110-1





### başladı kanal buldu roller tx fund-faucet bu kodu 2 3 defa girin .....

HAYIRLISI OLSUN.....

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/ceca0a28-6110-432e-a117-d443edede082)

* kanal bulduğunuz sağ taraf bele gösterıcek. suan için eski rollapp uzerinden gösterıyorum..

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/ce032dab-f4dd-4451-a307-00e90b1aef85)


* LOG lara bakmak için
```
tail -f ~/.roller/rollapp/rollapp.log
```

### tx kasma

NOT: işlemler hemen yansımıyor aşağıdaki resimde zamnala txler gorunur
öncelikle screende senin kanal sayını öğren biri sıfır diğeri kaçsa yaz bi yere


kanalınız kaçsa 8424 onla değiştiriniz...
Not: adres kısmına roller keys list yazdığınızda çıkan ilk dym adresini yazınız

Bu kod siizn rollapp a ibc transfer yapar. altaki dym kısmına kendi coininizin sembolünüde yazarak deneyin mesela crn ise ucrn
```
dymd tx ibc-transfer -y transfer transfer channel-8424 buraya-adres 1dym --from hub_sequencer --keyring-backend test --home .roller/hub-keys/ --chain-id froopyland_100-1 --node http://65.108.206.118:60757/ -y
```
Bu kod sizin rollapp dan froopyland a transfer. altaki dym kısmına kendi coininizin sembolünüde yazarak deneyin mesela crn ise ucrn
```
rollapp_evm tx ibc-transfer transfer transfer channel-0 buraya-adres 1dym --from rollapp_sequencer --keyring-backend test --home ~/.roller/rollapp --broadcast-mode block -y
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/30753255-1caa-43d5-ad19-2a9b2502c19c)


### Rollapınızı metamaska ekleme
NOT: zincir kimliğine rollapp adınızın ortadaki sayısını yazıyorsunuz sadece

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/3305de9b-78c4-4f8b-90f6-b5c016b281c1)

### Adamalar sizden coin atmanızı istedi nasıl
* öncelikle sunucunuzdan hub adresinin private keyini alın mm ekleyin yukarda ağınızı ekledik zaten
```
roller keys export rollapp_sequencer
```
* ee adamlar bize dym adresi verdi evm adresi nedir bu dymnin explorerde aratın verdikleri adresi alın size evm adresi atın mm dan

https://fl.dym.fyi/address/dym1jq59qkt6vhvu4q368pyjllt8z96wxpcmfjwkf7

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6448e12a-703f-4bfe-b6a5-129c48c17207)

👉NOT: siz dym ağında atacaksınız o yzuden ağı eklemek için portala mm bağlayın dym ağını otomatik ekler..

https://portal.dymension.xyz

### PR işlemleri

👉NOT:  komple okuyun ondan sonra başlıyacaksanız başlayın....

* kanal buldu herşey tamamsa screenden ctrl ad ile çıkın. altkai github reposunu forklayın . bunun için elbette bir githun hesabınız olmalı

https://github.com/dymensionxyz/rollapp-registry

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/11225f8b-e46e-47e3-b58a-d4bf6a942ea8)

* forkladıktan sonra masa üstünde klasör olusturun. adını rolapp id niz yapacaksınız mesela benim ki corenode_6886110-1  dosya adı bu

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/26649307-7f3d-4eb3-92ff-539427e76c26)

* içine girin ve logos die bir dosya olusturun. daha sonra bir metin belgesi açın ve adını rollapp idniz yapın mesela a benim ki corenode_6886110-1 uzantısını kson yapmamız lazım çünkü txt daha sonra bir logo lazım png yada jpg ufak boyutta bunuda logos klasörünün içine atalım ve adını gene rollapp id miz yapalım. nasıl görunecek 

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/3967df7e-a8cc-49f5-aa48-358dfe5c4282)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/8ffa2f6b-499f-4096-9f0b-e538cf9324c5)

* şimdi json dosyasına sağ tıklayıp düzenle diyoruz eğer gorunmuyorsa txt iken yapıp sonra jsona çevirirsiniz yada sorar neyle açayım die not defteri.

* sunucumuza geliyoruz ve şu kodu yazıyoruz
```
roller config export
```
* çıkan çıktığı tırnaklı parantezlerden itibaren kopyalıyoruz. (sunucuda mause ile seçince otomatik kopyalar yazıyı) ve metin belgemize kopyalıyoruz. kopyala yaptığımız kısımları dikkatle bakın.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/e1f3e685-499e-4b86-8dab-68204e4e0037)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/24257624-ee14-43bb-84d3-fb75ad5782d4)


* sunucumuzun ipsi lazım ilk giriş ekranında yazar.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/66ad3932-dcb3-4612-91af-758f6f77d7f4)

* şimdi düzenliyelim ipnizide bu şekilde değiştiriceksiniz.....portlar kalıcak sadece ipler

* bu kısım benim rollapa göre sizde görünmeyen kısımlar var rpcler ve cüzdan adresi kısımları

* siz sadece IP ve CUZDAN yazan yerlere gerekli bilgilerinizi yazıcaksınız.   "goldberg": true "availAddress": "CUZDAN" bu 2 kısım eğer yok ise gerekli yere ekleyin
  

```
{
  "chainId": "corenode_6886110-1",
  "chainName": "corenode_6886110-1",
  "rpc": "http://IP-YAZ:26657",
  "rest": "http://IP-YAZ:1317",
  "bech32Prefix": "ethm",
  "currencies": [
    {
      "displayDenom": "crn",
      "baseDenom": "ucrn",
      "decimals": 18,
      "logo": "/logos/corenode_6886110-1.png",
      "type": "main"
    }
  ],
  "coinType": 60,
  "faucetUrl": "https://discord.com/channels/956961633165529098/1143231362468434022",
  "website": "",
  "logo": "/logos/corenode_6886110-1.png",
  "ibc": {
    "hubChannel": "channel-7476",
    "channel": "channel-0",
    "timeout": 172800000
  },
  "evm": {
    "chainId": "0x6912de",
    "rpc": "http://IP-YAZ:8545"
  },
  "type": "RollApp",
  "da": "Avail",
  "description": "",
  "goldberg": true,
  "availAddress": "CUZDAN",
  "analytics": true
}
```


* şimdi dosyayı kaydedin... logo tamam json tamam hadi pr atalım

* forkladığımız dokumanın devnet klasorune girelim sağ taraftan add file ve upload file seçelim

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/10e15183-017d-4f17-9e32-8b9ea406edf4)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/c8fc48e5-b65f-4250-8038-7d7e5cd28999)

* dosyanı tut drag yazan yere at sonra alttan commit changes diyelim..
* yukarıdan solda pull requeste tıklayalım

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5fda50cd-1de5-42db-be5f-2415c8c8fca1)

* sağdan new pull request
* create request
* en son bele bir ekran gelecek

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/716aeb65-8c5f-4b27-9cfd-b3b953d17edc)

* şimdi yukarıdan sayfanın linkini kopyalayın avail discorda gidin https://discord.com/channels/1065831819154563132/1199048754569949285   rollapp veri.. kanalınaticket olusturun ve linkinizi atın

* burda bir dapp mevzusu isteme durumu var basit bir nft mintleme olur vss istek durumlarına göre ekleme olabilir sitenizi yaptığınızda adresini şuraya yazmanız gerekiyor "website":  yukarıda json dosyasını düzenlerkene...

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/e1572a1d-a221-49de-b510-32a18240c78e)


---------------------------

# Gelelim hali hazırda rollappı olanalra. ve avail de puan kasan cüzdana zaten sahip olanlara

👉Not: eğer availle daha once ilgilenmediyseniz cevirdikten sonra alttaki kodla verdiği adrese faucet alıp scrrende roller run demeniz yeter...

* screene gir ctrl c ile durdur. 
```
roller config set da avail
```
* kelimeleri gir 2sindede ctrl x y enter kaydet

```
nano /root/.roller/da-light-node/avail.toml
```
```
nano /root/.roller/rollapp/config/dymint.toml
```
```
systemctl daemon-reload
```
* screene gir `roller run` yaz başlat 


### Bazı hatalar ve çözümleri

* dymension-avail rpcsinde kaldıysa ss deki gibi hata verıor ise dymension-devnet die alttaki kodu deneyin

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/31a4e00b-8697-4d2f-bb4f-55bad031969a)

```
sed -i 's|wss://dymension-devnet.avail.tools/ws|wss://goldberg.avail.tools/ws|g' /root/.roller/rollapp/config/dymint.toml
```

### eski rollapp sahipleri farklı cüzdan çıkanlar

NOT: miktar kısmında istedikleri adedi yazmanız lazım mesela 0.001 at dediler. ya udym cinsinden yazın yada direk 0.001dym yazın. bunu rollapp çalışan sunucunuzda çalıştırıcaksınız
```
dymd tx bank send hub_sequencer dym-adresi miktar00000000000udym --home .roller/hub-keys/ --keyring-backend test --node http://65.108.206.118:60757/ --chain-id froopyland_100-1
```
