<h1 align="center"> Ziesha Network | Tahdig Testnet </h1>

<div align="center">

![image](https://user-images.githubusercontent.com/108215275/230774400-08a2c51b-ee74-4884-95a9-de45d1bd8725.png)

#  [Twitter](https://twitter.com/ZieshaNetwork)|[Discord](https://discord.gg/zieshanetwork)|[Website](https://ziesha.network/)|[Telegram](https://t.me/ZieshaNetworkOfficial)

</div>

> ### Arkadaşlar, Ziesha'nın yeni testneti ***Tahdig*** ***Testnet*** başladı.
> ### Bu testnet öncekilerden farklı olarak ***PoS*** ***konsensus*** mekenizması kullanılacak.
> ### Tahdig Testnet teşviksiz bir test ağıdır.
#
#
> ### Bazuka node çalıştımak için gereken minimum gereksinimler: `2CPU 2GB RAM 50GB SSD`
> ### Testnete katılmak için; hazırladığımız kurulum scriptini kullanabilirsiniz
> ### Aşağıdaki komutu kopyalayıp terminale yapıştırın ve yönergeleri takip edin.
```
wget https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Ziesha-Network/corenode-ziesha.sh && chmod +x corenode-ziesha.sh && bash ./corenode-ziesha.sh
```
> ### Kurulumu tamamladıktan sonra yapılacak diğer işlemler ve gelecek güncellemeler için Ziesha [Discordu](https://discord.gg/zieshanetwork) takip etmeyi unutmayın.
# 
#
# Komutlar

> ### Logları görüntülemek
```
sudo journalctl -u bazuka -fo cat
```
> ### Restart
```
sudo systemctl restart bazuka
```
> ### Node durumunu görüntüleyin
```
bazuka node status
```
> ### Cüzdan bilgisi
```
bazuka wallet info
```
> ### Token gönderme
```
bazuka wallet send --amount <miktar> --from <adres> --to <hedefadres>
```
> ### Validatör oluşturma
```
bazuka wallet register-validator --commission <commision>
```
> ###  Delegate 
```
bazuka wallet delegate --amount <miktar> --fee <fee> --to <validatöradresi>
```
> ### ReClaim
```
bazuka wallet reclaim-delegate --amount <miktar> --fee <fee> --from <validatöradresi>
```
> ### Token oluşturma
```
bazuka wallet new-token --name <isim> --supply <supply> --symbol <sembol>
```
> ### Cüzdana token ekleme
```
bazuka wallet add-token --id <id>
```
> ### Pendingdeki işlmeleri tekrar gönderme
```
bazuka wallet resend-pending
```
> ### Wallet nonce sıfırlama
```
bazuka wallet reset
```

<div align="center">

# Core Node Sosyal Medya [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)

![image](https://user-images.githubusercontent.com/108215275/230776662-b35d69ab-f3a2-4c4b-975f-f36dd7c1d2db.png)

### Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.


</div>

