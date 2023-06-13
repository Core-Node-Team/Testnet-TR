<h1 align="center"> Cascadia | Devnet </h1>

<div align="center">

![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/e8021857-3241-492d-a10b-9df8dda62f0b)



#  | [Twitter](https://twitter.com/CascadiaSystems) | [Discord](https://discord.gg/cascadia) | [Website](https://www.cascadia.foundation/) | [Telegram](https://t.me/+Tf6pQQSA7IkxNmU5) |

</div>

#
## Arkadaşlar şu anki Devnete katılmanın herhangi bir teşviki yok. Sadece discorddan validatör rolü alabilirsiniz
## İleride teşvikli bir test ağı daha olacak
## Proje ve testnet süreci ile ilgili tüm sorularınız için [Türkiye Telegram](https://t.me/CascadiaTR) grubuna katılabilirsiniz.
## Sistem gereksinimleri `4CPU 8GB RAM 160GB SSD`

## Script ile kurulum yapmak için bu komutu girin
```
curl -sSl cascadia-kurulum.sh https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Cascadia/Cascadia-Kurulum.sh && chmod +x cascadia-kurulum.sh && bash ./cascadia-kurulum.sh
```
## Manuel kurulum yapmak isterseniz: [Link](https://github.com/Core-Node-Team/Testnet-TR/blob/main/Cascadia/Manuel%20Kurulum.md)

#
## Kurulum tamamlandıktan sonra bu komutu girin
```
source $HOME/.bash_profile
```
## Cüzdan oluşturun
> ### Şifre oluşturmanızı isteyecek
> ### Mnemonic kaydetmeyi ve saklamayı unutmayın.
```
cascadiad keys add wallet
```
> ### [Discordda](https://discord.gg/cascadia) `#faucet` kanalından test tokenlarını alın ($request cüzdanadresi)

## Senkronize olduktan sonra valiadatör oluşturabilirsiniz
> ### Sync kontrol `cascadiad status 2>&1 | jq .SyncInfo`
> ### Log kontrol `sudo journalctl -u cascadiad -fo cat`
> ### [Explorer](https://validator.cascadia.foundation/)
```
cascadiad tx staking create-validator \
  --amount 1000000000000000000aCC \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.06" \
  --min-self-delegation "1" \
  --pubkey  $(cascadiad tendermint show-validator) \
  --moniker $MONİKER \
  --website "WEBSİTENİZ"
  --identity KEYBASE.İO İD \
  --details "Core Node Community" \
  --chain-id cascadia_6102-1 \
  --gas auto \
  --fees 300000000aCC \
  -y
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
sudo systemctl stop cascadiad && \
sudo systemctl disable cascadiad && \
rm /etc/systemd/system/cascadiad.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .cascadiad && \
rm -rf cascadia && \
rm -rf $(which cascadiad)
```
