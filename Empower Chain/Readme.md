<h1 align="center"> EmpowerChain | Circulus Testnet </h1>

<div align="center"
     
![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/f5e9add1-5b55-40d2-83dd-539cbf64c266)     
     
# [Twitter](https://twitter.com/empowerchain_io) | [Discord](https://discord.gg/nVTPukf2) | [Github](https://github.com/EmpowerPlastic) | [Docs](https://docs.empowerchain.io/)   
     
 </div>
 
#
## Herkese merhaba arkadaşlar daha önce katıldığımız EmpowerChain'in beklenen ödüllü testneti başladı.
## Kuruluma başlamadan önce kısaca bilmeniz gerekenler
>  Testnet 3 aşamadan oluşuyor
 > -  1. 31 Mayıs - 6 Haziran: Ağ önyükleme aşaması
 > -  2. 7 Haziran - 20 Haziran: Ana aşama
 > -  3. 21 Haziran - 25 Haziran: Stres testi aşaması

> Ödüller 1 yıl lineer vestingli
>
> Testnet sonunda KYC olacak
> 
> Gereksinimler 4 CPU Çekirdeği 16GB RAM 500+ GB SSD
## Testnet ile ilgili tüm sorularınıza cevap bulacağınız bu [dökümanı](https://docs.empowerchain.io/testnet/overview) mutlaka okuyun.
#
## Kurulum ile ilgili sorularınız ve sohbet için Core Node [Discord](https://discord.gg/fzzUAU9k) ve [Telegram](https://t.me/corenodechat) katılabilirsiniz.
#
### Script ile kurulum yapmak için aşağıdaki komutu girin

```
curl -sSL -o empower-kurulum.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Empower%20Chain/empower-kurulum.sh && chmod +x empower-kurulum.sh && bash ./empower-kurulum.sh
``` 
#
### Manuel kurulum yapmak istyenler için [rehber](https://github.com/0xSocrates/Testnet-Rehberler/edit/main/Empower%20Chain/Manuel-Kurulum.md)
### Kurulum tamamlandıktan sonra cüzdan oluşturun
```
empowerd keys add wallet
```
### Senkronize olmayı bekleyin ardından validatör oluşturun (not: faucetin bir kaç gün içinde açılacağı söylendi)
```
empowerd tx staking create-validator \
  --amount 1000000umpwr \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.1" \
  --min-self-delegation "1" \
  --pubkey  $(empowerd tendermint show-validator) \
  --moniker $MONIKER \
  --website "websiteniz"
  --identity keybase.io idniz \
  --details "Core Node Community" \
  --chain-id circulus-1
  --y
```

# Faydalı Linkler

## [Komutlar](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Ortak-Komutlar.md)
## [Node Yedekleme ve Taşıma](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Yedekleme%20ve%20Ta%C5%9F%C4%B1ma.md)
## [Port Değiştirme](https://github.com/Core-Node-Team/CosmosSDK-Node/blob/main/Port%20de%C4%9Fi%C5%9Ftirme.md)
## [Sync-Peer-FAQ](https://github.com/Core-Node-Team/Cosmos-Aglarinda-Node-Calistirmak/blob/main/Sync-Peer%20Nedir.md)


<div align="center">

# Core Node 

#  [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)  

![1500x500](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/92b50dd4-8043-4500-b906-bc8d15b75525)

## Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.
#

</div>


## Node Silmek
```
sudo systemctl stop empowerd && \
sudo systemctl disable empowerd && \
rm /etc/systemd/system/empowerd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .empowerchain && \
rm -rf empowerchain && \
rm -rf $(which empowerd)
```
