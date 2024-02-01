
<h1 align="center"> Pactus Miannet</h1>


![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/fc854b16-a554-419c-afbf-f99de720060a)

#  | [Twitter](https://twitter.com/pactuschain/) | [Discord](https://discord.gg/pactus-795592769300987944) | [Website](https://pactus.org/) | [Github](https://github.com/pactus-project) |


### TEST i silicem diyorsanız 
```
cd && rm -rf pactus
```
## kurulum

```
curl --proto '=https' --tlsv1.2 -sSL https://github.com/pactus-project/pactus/releases/download/v1.0.0/pactus_downloader.sh | sh
```
```
cd pactus-cli_1.0.0
```
👉Mainnet için alttaki komutla  yeni cüzdan oluşturmalısınız.
```
./pactus-daemon init

Oluşturulan Cüzdanın Seed Kelimelerini Kaydedin ve Cüzdan Parolası Oluşturun Onu da Kaydedin.

👉 Sonrasında Cüzdanınızı Sync Etmeniz Gerekli Yoksa Claim Edemezsiniz, Sync İçin Alttaki Komutu Kullanın.
./pactus-daemon start -w ~/pactus

👉 Sync Olduktan Sonra, Discordda robo-pac kanalına gidin.
/claim [Testnet-validator-address] [Mainnet-Validator-address] olacak şekilde açılan pop-up'a areslerinizi girin. İşleminiz gerçekleşecektir.

```
👉NOT: buraya kadar mainnet adresi almak için yapıyoruz eğer mainnet çalıştırmayacaksanız alt kısım gerekli değildir die dusunuyorum... 

👉NOT: çıkan cıktıyı komple kaydedin... yok ben yeni cüzdan olsutrucam derseniz `./pactus-daemon init`
```
apt install screen
```
```
screen -S pac
```
```
./pactus-daemon start -w ~/pactus
```
* çalışsın eşleşsin screenden çıkmak ıcın `ctrl ad` girmmek için `screen -r pac` yazıyoruz..

```
./pactus-wallet --path ~/pactus/wallets/default_wallet address balance cüzdan-adresi
```

### Claim..


discordan olacak duyurucaz..

# Yok ben mainnet çalıştırmayacam dıorsanız... window yada mac gui indirin
* window
https://github.com/pactus-project/pactus/releases/download/v1.0.0/pactus-gui_1.0.0_windows_amd64_installer.exe
* mac
https://github.com/pactus-project/pactus/releases/download/v1.0.0/pactus-gui_1.0.0_darwin_amd64.dmg

* kurun gui çalıştırın zaten size yeni adres olusturayım mı die sorar açın eşleşsin bukadan

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/61af90b6-4514-455d-9b8b-f31794399c64)


