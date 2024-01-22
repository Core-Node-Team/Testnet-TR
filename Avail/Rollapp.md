
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/65de285e-bd1d-438a-8f4c-ed2d2fa5d558)


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b8fa92da-cdbc-4442-8891-62b293c6c36e)


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

👉 total mikarını belirleyin supply

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
HAYIRLISI OLSUN.....

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/ceca0a28-6110-432e-a117-d443edede082)

* kanal bulduğunuz sağ taraf bele gösterıcek. suan için eski rollapp uzerinden gösterıyorum..

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/ce032dab-f4dd-4451-a307-00e90b1aef85)


* LOG lara bakmak için
```
tail -f ~/.roller/rollapp/rollapp.log
```

---------------------------

# Gelelim hali hazırda rollappı olanalra. ve avail de puan kasan cüzdana zaten sahip olanlara

Not: eğer availle daha once ilgilenmediyseniz cevirdikten sonra alttaki kodla verdiği adrese faucet alıp scrrende roller run demeniz yeter...

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

* screene gir roller run yaz başlat 


### Bazı hatalar ve çözümleri

* dymension-avail rpcsinde kaldıysa ss deki gibi hata verıor ise dymension-devnet die alttaki kodu deneyin

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/31a4e00b-8697-4d2f-bb4f-55bad031969a)

```
sed -i 's|wss://dymension-devnet.avail.tools/ws|wss://goldberg.avail.tools/ws|g' /root/rollapp/config/dymint.toml
```


