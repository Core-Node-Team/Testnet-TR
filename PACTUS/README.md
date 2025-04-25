
<h1 align="center"> Pactus Mainnet</h1>


![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/fc854b16-a554-419c-afbf-f99de720060a)

#  | [Twitter](https://twitter.com/pactuschain/) | [Discord](https://discord.gg/pactus-795592769300987944) | [Website](https://pactus.org/) | [Github](https://github.com/pactus-project) |


# EXPLORER

https://pacviewer.com/

## kurulum

```
curl --proto '=https' --tlsv1.2 -sSL https://github.com/pactus-project/pactus/releases/download/v1.1.4/pactus_downloader.sh | sh
```
```
cd pactus-cli_1.1.4
```
👉NOT: "mnemonic" tırnakların içine mnemonic kelimelerinizi yazıcaksınız..
```
./pactus-daemon init -w ~/pactus --restore "mnemonic"
```
👉NOT: buraya kadar mainnet adresi almak için yapıyoruz eğer mainnet çalıştırmayacaksanız alt kısım gerekli değildir die dusunuyorum... discordan botla adres yazarak claimlenecek cunku

👉NOT: çıkan cıktıyı komple kaydedin... yok ben yeni cüzdan olsutrucam derseniz `./pactus-daemon init -w ~/pactus`
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
https://github.com/pactus-project/pactus/releases/download/v1.1.0/pactus-gui_1.1.0_windows_amd64_installer.exe
* mac
https://github.com/pactus-project/pactus/releases/download/v1.1.0/pactus-gui_1.1.0_darwin_amd64.dmg

* kurun gui çalıştırın zaten size yeni adres olusturayım mı die sorar açın eşleşsin bukadan

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/61af90b6-4514-455d-9b8b-f31794399c64)

### Stake etme
```
cd
cd pactus-cli_1.1.4
```
```
./pactus-wallet --path ~/pactus/wallets/default_wallet tx bond reward-adres-1 validator-adres-1 stake-miktarı
```

### Baska adrese coin gönderme
```
cd
cd pactus-cli_1.1.4
```
```
./pactus-wallet --path ~/pactus/wallets/default_wallet tx transfer  gönderici-adres alıcı-adres gönderilecek-miktar
```
-------------------------------------- Güncelleme-----------------------------
```
cd
wget https://github.com/pactus-project/pactus/releases/download/v1.1.5/pactus-cli_1.1.5_linux_amd64.tar.gz
tar -xvf pactus-cli_1.1.5_linux_amd64.tar.gz
```
### Screen'e girelim. 
```
screen -r pactus
```
##### Ardından CTRL+C ile durduralım.
```
cd
cd pactus-cli_1.1.5
```
```
./pactus-daemon start -w ~/pactus
```
### Snap
```
wget -P $HOME http://37.120.189.81/pactus/pactus.zip
unzip -d $HOME/pactus $HOME/pactus.zip
```



