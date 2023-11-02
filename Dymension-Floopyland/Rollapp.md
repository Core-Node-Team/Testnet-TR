# Dymension
![1500x500](https://user-images.githubusercontent.com/91562185/234884978-f1a6b9f1-5939-422c-af5d-ca66a9feb758.jpg)

## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 500 GB SSD |


- önemli notlar
   - ben eski roller update edip migrate ettim ama olmadı yeni kurdum
   - update için
   - curl -L https://dymensionxyz.github.io/roller/install.sh | bash
   - zaten ``roller run`` dediğiniz de size migrate dicek ``roller migrate`` yazıcaksınız. eğer olursa  ``roller tx fund-faucet`` bu kod çalışır. olmazsa olmaz :D
   - Diyelim yeni kurmak zorunda kaldık ``roller config init --interactive`` çıkan adresleri kaydediniz... bu arada roller id nizi direk isim yazın mesela ahmet mehmet die sayı çizgi rakam yazmayın kendi eklesin
   - faucet dicorda açıksa alınız... `$request cüzdan-adresi` kendi coninizi almak için `$request cüzdan-adresiniz rollapp-idniz`
   -  celestia faucet kapalıdır. açalım :D ``https://faucet-arabica-9.celestia-arabica.com/``
   -  node kurduysanız coin vardır ordan aktarıcaz roller kurunca 3 adres verior 2si dym  celestiayı yukarıda faucetten hallettik dymleride node cüzdandan aktaralım artık ne kadar varsa ufaktan atalım..
   -  ``dymd tx bank send node-cüzdan-adresi atacağın-dym-adresi 100dym --gas auto --gas-adjustment 1.5 -y``
   -  şimdide register edelim ``roller tx register``
   -  şimdide çalıştıralım ``roller run``
   -  kanal bulunca alttan devamke...
   -  ÇOK ÖNEMLİ : http://SUNUCU-İP-ADRESİNİ-YAZ:26657/status   Bunu kendi browserinize yazınız bir çıktı almıyorsanız rollerda soru vardır düzgün çalışıyorsa çıktı şöle olmalı. aynı zamanda 1317 ve 8545 portunada bakınız

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5e4998ef-128e-466c-96ac-5a160b09e5d1)





* roller kurdunuz kanal buldu mu ? evetse devam edelim
* faucete gönderme için artık kısa bir kodumuz var deneyelim .
```
roller tx fund-faucet
```
![image](https://github.com/molla202/Dymension/assets/91562185/0a0bed26-56b9-4874-8f98-2159ff631596)

* faucet hernekadar kapalı olsada sonucta açılacak bakiye gönderimini göirmek için
```
$balance dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5 <RollApp-ID>
```
* evet zurnanın zırt dediği yere geldik repoyu forklayalım
https://github.com/dymensionxyz/rollapp-registry
* sunucumuza geçelim. ve forkladığımız repoyu sunucuya çekicez alttaki buraya yazan yere kendi github adınızı yazıcaksınız
```
git clone https://github.com/BURAYA/rollapp-registry
```
```
cd rollapp-registry
```
Not: altaki rollap idniz roller çalıştırdığınızda yazıor zaten... BURAYA yazan kısma yazın
![image](https://github.com/molla202/Dymension/assets/91562185/0d58e837-73f4-4707-8f49-f93c519afc3a)
```
export ROLLAPP_ID=BURAYA
```
```
mkdir -p $ROLLAPP_ID/logos
cd $ROLLAPP_ID && touch $ROLLAPP_ID.json
```

* şimdi sunucumuzdaki dosyanın içine logo muzu atıcaz desteklediği uzantılar SVG, PNG, or JPG attığınız resmide rollap id yapıcaz arkadaslar mesela idmiz molla_456453-1 buysa molla_456453-1.png gibi 50kb üstü kabul etmıyor dosya boyutunu düşürmeniz lazım https://www.resizepixel.com/ buradan yapabilirsiniz
* winscple yada mobo uzerinden buraya yazan yer sizin rollapp idniz adında klasör  `/root/rollapp-registry/BURAYA/logos/`
* şimdide yaptığımız ayarlamaları çıktı alalım.
```
roller config export
```
![image](https://github.com/molla202/Dymension/assets/91562185/e32fb431-e7ec-44ff-a30b-022400861e17)

* bu çıktıyı kaydedelim dursun.
* şimdide bu olusturduğumuz jsonu düzenleyeceğiz...
```
cd
```
```
cd rollapp-registry
```
not: aşağıya buraya yazan yere sizin rollapp idnizi yazacaksınız mesel cd molla_456453-1 gibi idniz neyse o dosyaya giricez.
```
cd BURAYA
```
* json adınız rollap id adınız. BURAYA kısmına diyelim rollapp idniz molla_456453-1     nano molla_456453-1.json gibi yazıcaz anliyomusun mubarek... :D
```
nano BURAYA.json
```
* şimdi export dediğimizde çıkan çıktıyı kaydetmiştik bi yere ordan kopyalayıp  gerekli değişiklikleri aşağıdaki gibi yapıcaz... tabi içinde zaten yazıyorsa sıkıntı yok
* Aşağıdaki yerleri bulup ip adresini yazıcaksınız vps'in. sonra ctrl+x y enter dicez kaydedicez... Portlarınızı değiştirdiyseniz ona göre yazın hee

``"rpc": "http://IP-ADRES:26657"``

``"rest": "http://IP-ADRES:1317"``

``"rpc": "http://IP-ADRES.8545"``

* logoyu attık jsonu düzenledik.. geriye kaldı bu yaptıklarımızı kendi hesabımıza puşş etmeye puşş nasıl edilir çok puşş bi işlem :D

* githubunuza girin... sağ menuden resmine tıkla setting'e girin

![image](https://github.com/molla202/Dymension/assets/91562185/72e008f8-fd46-4e8e-8176-7e06e63f2043)

* sol altta developer settinge girelim

![image](https://github.com/molla202/Dymension/assets/91562185/42b63d38-f3b7-4732-b8d2-3f3015cd7fe3)

* sol menuden ``personel acces token diyelim açılan alt menıden classic diyelim

![image](https://github.com/molla202/Dymension/assets/91562185/87e561b8-5082-4900-8c8e-9507cd881abd)

* sağ üst menuden generate deyip yine classic seçelim
* açılan ekranda bi ad verelim alttaki tum kutuları tıklayıp en altaki generateye tıklayalım..

![image](https://github.com/molla202/Dymension/assets/91562185/6585fe18-8834-43d8-8802-93190208039a)

* çıkan kodu bir yere kaydedin bu bizim şifremiz unutmayın

![image](https://github.com/molla202/Dymension/assets/91562185/1a09b406-4501-44e3-82c3-4a3b49e6c38a)

* şimdi sunucumuzda hazırladığımız herseyi gthub repomuza puşşş edelim bize kullanıcı adı sorucak neyse onu yazın sonra şifre sorucak oda yukarıda yaptığımız classic token şeysi  vardıya kod onu yazıyoruz enter dıyoruz ve puş edıyor

```
git add .
git commit -m "added RollApp"
git push -u origin main
```

![image](https://github.com/molla202/Dymension/assets/91562185/27c38010-cf51-433c-8235-9e1c50b8f0d4)

* eğer hata alırsanız token olusturmada hata yapmısınızdır şöle der

![image](https://github.com/molla202/Dymension/assets/91562185/2d66acd5-26a0-4437-a4de-716890ee8218)

* artık githundan bakalım dosya gelmiş mi repoya sayfayı yenile

![image](https://github.com/molla202/Dymension/assets/91562185/45e20818-d8b7-4691-a2d4-2b6cda0042e2)

- Eğer olmuyorsa dosyayı pcnize çekin sonra manuel githuba yükleyin. neden bukadar anlattın derseniz öğrenmekten zarar çıkmaz...

* şimdide bu repoya pr çekelim. gördüğünüz gibi  kendimize forkladığımız repodan pr çekiyoruz. eğer dosyayı pcnize çektiyseniz add files kısmında upload var ordan hazırladığınız dosyayı upload edebilirsiniz. 

![image](https://github.com/molla202/Dymension/assets/91562185/95b23072-75df-4ecc-a2a4-ab3b4501bb03)

* sağdan new pull request diyelim

![image](https://github.com/molla202/Dymension/assets/91562185/676ae07a-a218-4b06-b93a-f960d149ce1b)

* create pull request çıkıyor dıyoruz pul puşşş allah ne verdiyse :D sona not falan ekleme falan var yazın bişiler

![image](https://github.com/molla202/Dymension/assets/91562185/697ebde4-a798-407f-bc23-b739f7231bb9)

* daha sonra discorda gidiyoruz...  cr list-your-rollapp kanalına gidiyoruz


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/f8cf73bb-a2e7-4f12-8c5d-d8d1511d22f6)


* burası suan kapalı ama açılacak ve buraya $pair molla_34521-1  gibi yazıcaz sizin rollapp idniz neyse onu yazıcaksınız

``$pair BURAYA``

* yöneticilerden biri ayrı kanal açıp size rollapınızın linkini vericek daha sonra prtaldan kendiniz görebilicek ve işlemler yapmak için insanları yonlendirebiliceksiniz. lütfen kanala attııktan sonra sağ tıklayıp alt kanal olusturun ve buraya pr sayfanızı atın  hayırlı olsun

https://portal.dymension.xyz/rollapps


NOT: corenode onaylandığın işlem yapın arkadaslar. ibc bolumunden topluluğun gücünü gösterelim...


### rollerdan baska kişilere kendi tokeninden atma
NOT: dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5 faucetin discordaki adresi orayada gondermek ısterseniz aşağıdaki kodu yazmanız yeterli sadece kanal kısmını değiştiriceksiniz sizde ne bulduysa artıkın.tabi baskasına atacaksanız adresi değiştiriniz 
```
rollapp_evm tx ibc-transfer transfer transfer channel-0 dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5 500000000000000000uMGA --from rollapp_sequencer --keyring-backend test --home ~/.roller/rollapp
```














  
