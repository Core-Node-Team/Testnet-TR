<h1 align="center"> Babylon | Testnet </h1>

<div align="center"
     
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/108215275/f486baf6-ba52-46a4-a270-2863f5626e9c)
   
     
# [Twitter](https://twitter.com/babylon_chain) | [Discord](https://discord.gg/exuVuXX8Jt) | [Github](https://github.com/babylonchain/) | [Docs](https://docs.babylonchain.io/)   
     
 </div>

## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4 |
| RAM	| 8 GB |
| Storage	| 250 GB SSD |

# Script ile kurlum için aşağıdaki komutu girin

```
curl -sSL -o babylon-kurulum.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/babylon.sh && chmod +x babylon-kurulum.sh && bash ./babylon-kurulum.sh
``` 
## Manuel kurulum yapmak isteyenler için [Link](https://github.com/Core-Node-Team/Testnet-TR/blob/main/Babylon/manuel.md)
## Kurulumu tamamladıktan sonra bu komutu girin
```
source $HOME/.bash_profile
```
## Cüzdan oluşturun
> ### Mnemonic kaydedip saklayın
```
babylond keys add wallet
```
## Faucet
> ### Babylon [Discorda](https://discord.gg/exuVuXX8Jt) gidip `#faucet` kanalından `!faucet cüzdanadresi` ile test tokenlarını alın

## BLS key oluşturun
```
babylond create-bls-key $(babylond keys show wallet -a)
```
> ### Ardından yeni oluştuırulan BLS keyinb belleğe yüklenebilmesi için nodeyi yeniden başlatmak gerekiyor
>  - `sudo systemctl restart babylond`

## Yapılandırma ayarlarını değiştirin
> ### BLS imza işlemlerini gönderecek key ismini belirtmek gerekiyor
> ### Cüzdan ismini `wallet` yerine başka bir isim yaptıysanız komutu değiştirin
```
sed -i -e "s|^key-name *=.*|key-name = \"wallet\"|" $HOME/.babylond/config/app.toml
```
> ### Validatörün yeni bloğa başlamadan önce bekleyeceği süreyi belirtin
> ### Babylon ağında  bloklar arası 10 saniye süre olması hedefleniyor
```
sed -i -e "s|^timeout_commit *=.*|timeout_commit = \"10s\"|" $HOME/.babylond/config/config.toml
```

# Validatör
> ### Senkronizasyon durumunuzu kontrol edin
> - `babylond status 2>&1 | jq .SyncInfo` 
> -  Ulaştığınız blok yüksekliğini [Explorer](https://babylon.explorers.guru/) ile karşılaştırın. Senkronize olduktan sonra `"catching_up": false` çıktısı verir

```
babylond tx checkpointing create-validator \
 --amount="1000000ubbn" \
 --pubkey=$(babylond tendermint show-validator) \
 --moniker $MONİKER \
 --website "WEBSİTENİZ" \
 --identity KEYBASE.İO İD \
 --details "Core Node Community" \
 --chain-id bbn-test-2 \
 --gas="auto" \
 --gas-adjustment 1.2 \
 --gas-prices "0.0025ubbn" \
 --keyring-backend=test \
 --from wallet \
 --commission-rate "0.10" \
 --commission-max-rate "0.20" \
 --commission-max-change-rate "0.01" \
 --min-self-delegation "1" \
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
sudo systemctl stop babylond && \
sudo systemctl disable babylond && \
rm /etc/systemd/system/babylond.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .babylond && \
rm -rf babylon && \
rm -rf $(which babylond)
```
