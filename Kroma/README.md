<div align="center">
  <h1>KROMA REHBER </h1>
</div>

![kroma-og](https://github.com/molla202/Kroma/assets/91562185/61044d01-0239-400c-b0f8-4a7f78679f43)


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Kroma Website](https://kroma.network/)<br>
 * [Discord](https://discord.gg/qvVNbgmK)<br>
 * [Twitter](https://twitter.com/kroma_network)<br>


## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2+ |
| RAM	| 4+ GB |
| Storage	| 250 GB SSD |
👉 Not: Odül bilgisi bulunmamaktadır.
# Oto Kurulum
```
wget -q -O kroma.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Kroma/kroma.sh && sudo chmod +x kroma.sh && sudo /bin/bash kroma.sh
```

👉 Not:
* kurulum sırasında çakışan port olursa kurmaz. 
* Kurulum sırasın da mm private key sorar sopolia faucet almış olun. 
* Kurulum sırasında rpc soracak [infura](https://www.infura.io/) yada [alchemy](https://dashboard.alchemy.com/) den almanız gerekiyor üye olarak. sepolia ağı rpc oluşturulacak.

## Log Komutu
```
cd $HOME/kroma-up/ && docker compose --profile validator logs -f
```
## Deposit İşlemi
```
docker exec kroma-validator kroma-validator deposit --amount 1000000000000000000
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5b74a753-32fd-4334-8173-4653514f5416)

## Durdurma Ve Silme
```
cd $HOME/kroma-up/ && docker compose --profile validator down -v
```


## Kroma Explorer

[https://blockscout.sepolia.kroma.network](https://blockscout.sepolia.kroma.network)

### Sepolia Faucet

[https://sepoliafaucet.com/](https://sepoliafaucet.com/)

https://sepolia-faucet.pk910.de/




