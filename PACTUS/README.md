
<h1 align="center"> Pactus Testnet</h1>

<div align="center">

![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/fc854b16-a554-419c-afbf-f99de720060a)

#  | [Twitter](https://twitter.com/pactuschain/) | [Discord](https://discord.gg/pactus-795592769300987944) | [Website](https://pactus.org/) | [Github](https://github.com/pactus-project) |

</div>

<h1 align="center">Pactus</h1>

- `500 kişi` ile sınırlı idi 500 ilave geldi
- Ödül `100 PAC` tokenidir.



<h1 align="center">Donanım</h1>

- 8080 portunu kullanıyor


### Minimum
1 CPU 1 RAM - Ubuntu 22

### Port kontrol
```
lsof -i -P -n | grep LISTEN
```

<h1 align="center">Kurulum</h1>

```console
sudo apt update -y && sudo apt upgrade -y
sudo apt install screen

curl --proto '=https' --tlsv1.2 -sSL  https://github.com/pactus-project/pactus/releases/download/v0.17.0/pactus_downloader.sh | sh

cd pactus-cli_0.17.0

### 12 kelimenizi alın ve şifrenizi yedekleyin.
./pactus-daemon init -w ~/pactus --testnet
# 7 sayısına enter diyin - çıktıyı yedekleyin

screen -S pactus
./pactus-daemon start -w ~/pactus
```
### sync olmasını bekleyin
explorer: https://explorer.codeblocklabs.com/pactus/validator.php

- Sync olduktan sonra 1. validatör adresine token isteyin.

- reward adreslerinin ilkinde kazançlar zamanla gorulmeye baslanıcak ve artıcak

- Bu aşamada bu adresinize otomatik `delege` edilecek ve `discord=validatör` bağlantısı yapılacak

### Cüzdan bakiye kontrol
Not: ilk validator adresine sonrada ilk reward adresinize bakınız reward adresinde bakiye toplandıysa tekrar kendinize stake edebilirsiniz.
```
cd
cd pactus-cli_0.16.1
./pactus-wallet --path ~/pactus/wallets/default_wallet address balance cüzdan-adresi
```
### Stake etme
```
cd
cd pactus-cli_0.16.1
./pactus-wallet --path ~/pactus/wallets/default_wallet tx bond reward-adres-1 validator-adres-1 stake-miktarı
```
