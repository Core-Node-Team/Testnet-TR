<h1 align="center"> ÖDÜLLÜ Nibiru Node kurulum ve Görevler </h1>
<div align="center">


![nibiru](https://user-images.githubusercontent.com/76253089/222176097-583a0546-8108-47b9-a0b6-93c09e557676.jpg)

<h3>
  
Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
</h3>
  
</div>

![node-kurulum-aşaması](https://user-images.githubusercontent.com/76253089/222183148-f5c0411e-4f63-4599-96bf-3f8d7ab62e53.jpg)

### Sunucuyu Güncelleyerek Başlayalım
```
sudo apt update 
```
```
sudo apt upgrade -y
```

### Gerekli Portları kuralım.
```
sudo apt install -y ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow 9100
sudo ufw allow 26656
sudo ufw allow 26657 
sudo ufw enable
```

### Otomatik Yükleme ile Nibiruyu kuralım
```
source <(curl -s https://raw.githubusercontent.com/enzifiri/core-node/main/cosmos-scripts/kurulum.sh)

```

## İşlem bitince alttaki komutu girin
```
source $HOME/.bash_profile
```
![bosline](https://user-images.githubusercontent.com/76253089/222183268-6fb83660-5f9a-45bc-a1fe-1d7beb5ed361.jpg)

## Kurulum bittikten sonra Cüzdan Import Etme / Oluşturma

Import (Daha önceden cüzdan adresi oluşturduysanız bu komutu kullanın.)
```
nibid keys add wallet --recover
```
Cüzdan Olusturma (Seedlerini bi yere not edin)
```
nibid keys add wallet
```

## Faucet 
Alttaki Linke tıklayın ve oluşturuduğunuz/import ettiğiniz cüzdanı bağlayın ve tokenleri talep edin.
<h2>
  
[FAUCET LİNKİ](https://app.nibiru.fi/faucet)

</h2>

![bosline](https://user-images.githubusercontent.com/76253089/222183385-67ecc109-4c08-412f-8ab9-35cba611e288.jpg)

### Nodeumuzun güncel bloğa erişmesini bekleyelim. Logları kontrol etmek isterseniz
```
sudo journalctl -u nibid -f --no-hostname -o cat
```
### Eğer Peer konusunda sıkıntı yaşarsanız alttaki komutları uygulayıp nodeu sıfırlayın ve ardından tekrar logları kontrol edin.
```
PEERS="a1b96d1437fb82d3d77823ecbd565c6268f06e34@nibiru-testnet.nodejumper.io:27656,ac163da500a9a1654f5bf74179e273e2fb212a75@65.108.238.147:27656,abab2c6f45fa865dc61b2757e21c5d2244e5bacb@213.202.218.55:26656,fe17db7c9a5f8478a2d6a39dbf77c4dc2d6d7232@5.75.189.135:26656,7e75b2249d088a4dfc3b33f386c316cb47366d2b@195.3.221.48:11656,6db03cd0732b5120c291065694bafaf9c76baf4c@213.202.247.87:26656,4f1780cd0fbcd7fc0211eab1917860d69e049d06@65.109.130.180:28656,c1b40d056e4260a9fa9d1142af1adbeec5039599@142.132.202.50:46656,ea44a000ee4df9d722a90fdf41b3990e738bdda0@65.109.235.95:26656,2dce4b0844754b467ae40c9d6360ac51836fadca@135.181.221.186:29656,e08089921baf39382920a4028db9e5eebd82f3d7@142.132.199.236:21656,88f6634eecc60b8ea89b44ebbcefe3d891ca6bb9@65.108.251.231:26656,bab9f78f1c0ccd5b4d9db13a112dcf45c60e4df1@130.193.68.154:26656,d327bb6b997a32aaa7dae5673e9a9cbad487ad09@104.156.250.70:26656,4f1af4f62f76c095d844384a3dfa1ad76ad5c078@65.108.206.118:60656,9d901d286eda108828250c0a9e65fef72ee293cd@129.146.80.192:26656,ee76ff1711d63ab37efa77cb669e21643b0f2609@65.109.39.103:26656,f2e99f5a68adfb08c139944a193e2e3a4864b038@167.235.132.74:26656,c8907a13b012e7a937cfe7d624b0fbe7ef3508b2@194.163.160.155:26656,53db2490d7f6601a55aa59e98e4d6cfd5d8a929c@51.159.187.67:36656,30e14f66fc44a55a51f36693afd754283c668953@65.108.200.60:11656,fa5c730d842aff05c3761d9c1b06107340ac7651@65.108.232.238:11656,f01ad3a75b255226499df9183ac2ebc0a40a9e05@46.4.53.207:33656,81a8383eefae628ae4bc400d52d49adfb11cb76a@65.108.108.52:11656,1c548375968f0abfac3733cae9f592468c988bf9@46.4.53.209:33656,cd44f2d2fc1ded3a63c64f46ed67f783c2d93d57@144.76.223.24:36656,b03d1ce3e97984a8b8a63a7a6ec6c5d196d81436@46.4.53.208:33656,e74f1204d65d0264547e2c2d917c23c39fcff774@95.217.107.96:36656,b88642986618adc6d47ed32db1a5f2e086da18b8@132.145.209.220:26656,79e2bfc202e39ba2a168becc4c75cb6a56803e38@135.181.57.104:11656,22d5b4919850ad71ad0a1bf7979c7dba53960689@192.9.134.157:27656,3fbc70ee59230284f834931cc8edf1e16f9659e3@65.108.43.58:27667,a3a344c1732c507f40931778225f919004392e94@52.204.188.236:26656,d3e7948a5ba3f55264f1260c1d102924616b6711@5.180.186.27:26656,98032241ea61ca6ac066b8fa508baace6678a7a3@190.2.155.67:31656,5f3394bae3791bcb71364df80f99f22bd33cc2c0@95.216.7.169:60556,f1243fd7e7f655b64d49f24b3202aab6db1341c4@167.235.21.54:29656,a08e5b25443d038b08230177456ee23196509dd5@65.109.92.79:12656,10382838df100f7817eb9c86c5da67160eefe4fc@95.216.100.241:30656,62d93ddd046e8092c3717117484ed680cbacbf0d@139.59.239.43:26656,f29c808ff578c7f3a3746b9b0b3e0504b3ee2315@65.108.216.139:26656,8ebed484e09f93b12be00b9f6faa55ea9b13b372@45.84.138.66:39656,4f1c8f3de055988bf15f21b666369287fb5230de@31.220.73.148:26656,c2c2af737665fafa38b52110e591687558fe788a@31.220.78.187:26656,aad0d897a82880e36bb909091c5878607446ab41@138.201.204.5:35656,8c1e4bd5d50f33f2d4073318fb9cf8ebaac2ceb4@185.244.183.157:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.nibid/config/config.toml
```
```
curl -s https://snapshots2-testnet.nodejumper.io/nibiru-testnet/addrbook.json > $HOME/.nibid/config/addrbook.json
```
```
sudo systemctl restart nibid
```
```
sudo journalctl -u nibid -f --no-hostname -o cat
```
### Çıktınız Aşağıdaki Gibi ise Nodeunuz başarılı şekilde kurulmuştur. Eşleştikten Sonra Validatör oluşturun sonrasında Görevleri Yapmaya başlayabilirsiniz. Güncel bloğa aşağıdaki explorerden bakın.
![image](https://user-images.githubusercontent.com/76253089/222171711-5a372302-75c9-44f6-8179-0ba54036e7f2.png)
<h1>
  
[Explorer](https://nibiru.explorers.guru/)
 
## Validatör Olusturma (NODEİSMİGİRİN yazan yere istediğinizi yazın.)
```
nibid tx staking create-validator \
--amount=1000000unibi \
--pubkey=$(nibid tendermint show-validator) \
--moniker="NODEİSMİGİRİN" \
--identity=FFB0AA51A2DF5955 \
--details="Core Node Member" \
--chain-id=nibiru-itn-1 \
--commission-rate=0.10 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1 \
--from=wallet \
--gas-prices=0.1unibi \
--gas-adjustment=1.5 \
--gas=auto \
-y
```
</h1>

![görevrehberi](https://user-images.githubusercontent.com/76253089/222183814-65b884b0-4d07-465b-8f8a-54ac8d6a6137.jpg)

# Görevler (NODEUNUZ EŞLEŞİP GÜNCEL BLOĞA ERİŞMEDEN GÖREVLERE BAŞLAMAYIN HATA ALIRSINIZ)

## Görevler sırasında muhtemelen şu hatayı alacaksınız çözümü direk söylüyorum

![image](https://user-images.githubusercontent.com/76253089/222180673-dc239cfa-b68b-4781-9a62-8c2b5ff7f15a.png)

"account sequence mismatch, expected 11, got 8: incorrect account sequence" Gibi bi hata alırsanız komutun sonundaki -s 8 etiketini 11 ile değişitirin. Eğer 11 yerine başka sayı verdiyse -s yerine o sayıyı girmeniz gerekiyor.

# 1) Formu doldur (77 Puan)
Görevleri yapıp node üzerinde kullandığınız cüzdan adresini verin. [GLEAM FORM LİNKİ](https://gleam.io/yW6Ho/nibiru-incentivized-testnet-registration)

![image](https://user-images.githubusercontent.com/76253089/222189011-356f18d1-893f-40a5-a158-5d93ac16b7b6.png)


# 2) Delegate, Claim ve Redelegate Görevi (100 Puan)

## DELEGATE  (DEĞİŞİKLİK YAPMAYIN)
```
nibid tx staking delegate nibivaloper10gm4kys9yyrlqpvj05vqvjwvje87gln86t4u6q 1000000unibi --from wallet --chain-id nibiru-itn-1 --fees 100unibi -y -s 8
```
## CLAİM
Alttaki linke girin ve Nodedda kullandığınız cüzdan ile Siteye bağlanın. İşaretlediğim yerlere basarak biriken ödüllerinizi Claim edin.

<h1> Site LİNK https://app.nibiru.fi/stake </h1>

![image](https://user-images.githubusercontent.com/76253089/222187928-d796b4aa-39ff-4898-a4e4-5937572f2766.png)

Claim işlemi bu kadardı.

## REDELEGATE (DEĞİŞİKLİK YAPMAYIN, GÖREVLERİ YAPABİLMENİZ İÇİN VALOPERLERİ BEN SEÇTİM)
```
nibid tx staking redelegate nibivaloper10gm4kys9yyrlqpvj05vqvjwvje87gln86t4u6q nibivaloper1gc6vpl9j0ty8tkt53787zps9ezc70kj8wv386g 1000000unibi --from wallet --chain-id nibiru-itn-1 --fees 100unibi -y -s 12 --gas 210000
```
# 2-B) Oracle'a Stake et Sonrasında Unstake Et (2. görevin devamıdır bu görev 100 puana dahildir.)

## ORACLE DELEGATE  (DEĞİŞİKLİK YAPMAYIN)
```
nibid tx staking delegate nibivaloper1u40w3kzng8af0enr5wy7702s20td79g89h2k83 1000000unibi --from wallet --chain-id nibiru-itn-1 --fees 100unibi -y -s 8
```
## ORACLE UNDELEGATE  (DEĞİŞİKLİK YAPMAYIN)
```
nibid tx staking unbond nibivaloper1u40w3kzng8af0enr5wy7702s20td79g89h2k83 1000000unibi --from wallet --chain-id nibiru-itn-1 --fees 100unibi -y -s 8
```

# 3) Validatör Olun (75 Puan / Jail Olmazsan Bonus 50 Puan)
## Validatörümüzü olusturduk 75 puan cepte. Aktif veya İnaktifin hiç bir önemi yok.

# 4) Oracle Görevi (200 Puan / ZOR)
## En az 10k TX yapın. (Aktif Sette Olmanız Gerekiyor)

# 5) Geliştiriciler için (+250 puan)
Bir hata düzeltmesini depoyla nibirubirleştirme(yeni pencere açar)
Herhangi bir yolla panik/zincir durmasına neden olun veya test ağını yok edin.
Depoya bir veri kaynağı katkıda bulununpricefeeder(yeni pencere açar)
Hata ödülleri hakkında bilgi almak için → bugs@nibiru.fi

