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


### Güncelleme v0.1.8 Block=3,400,000
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.8.sh | bash
```

### Güncelleme v0.1.7 Block=2,820,000
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.7.sh | bash
```

### Güncelleme v0.1.6 Block=2722000
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.6.sh | bash
```
### Güncelleme v0.1.5
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.5.sh | bash
```
### Güncelleme v0.1.4
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.4.sh | bash
```
## Peer Eklemek isterseniz
```
peers=$(curl -s https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/peer.txt)
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" ~/.cascadiad/config/config.toml
systemctl restart cascadiad && journalctl -u cascadiad -fo cat
```
## Script ile kurulum yapmak için bu komutu girin
```
curl -sSl -o cascadia-kurulum.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/cascadia.sh && chmod +x cascadia-kurulum.sh && bash ./cascadia-kurulum.sh
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

> ### CoreNode Snap

```
sudo apt install liblz4-tool

systemctl stop cascadiad

cp $HOME/.cascadiad/data/priv_validator_state.json $HOME/.cascadiad/priv_validator_state.json.backup

cascadiad tendermint unsafe-reset-all --home $HOME/.cascadiad --keep-addr-book 

curl -L http://128.140.4.67/CoreNode_Chain_Services/cascadia_snapshot.tar.lz4 | tar -I lz4 -xf - -C $HOME/.cascadiad/data

mv $HOME/.cascadiad/priv_validator_state.json.backup $HOME/.cascadiad/data/priv_validator_state.json 

sudo systemctl start cascadiad && sudo journalctl -u cascadiad -fo cat
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
