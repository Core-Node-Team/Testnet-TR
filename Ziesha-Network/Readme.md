<h1 align="center"> Ziesha Network | Deruny Testnet </h1>

<div align="center">

![image](https://user-images.githubusercontent.com/108215275/230774400-08a2c51b-ee74-4884-95a9-de45d1bd8725.png)

#  [Twitter](https://twitter.com/ZieshaNetwork)|[Discord](https://discord.gg/zieshanetwork)|[Website](https://ziesha.network/)|[Telegram](https://t.me/ZieshaNetworkOfficial)|[Whitepaper](https://hackmd.io/_Sw5u2lUR9GfBV5vwtoMSQ)

</div>

# Arkadaşlar merhaba; biliyorsunuz Ziesha Network'ün geliştirilme sürecinde büyük ilerlemeler sağlandı ve mainnete hiç olmadığı kadar yaklaştık.
# Mainnet öncesi son ve ödüllü testnet olması planlanan Deruny Testnet başladı.
#
> ## Testnete katılım herkese açık.
> ## Bitiş tarihi belli değil.
> ## Gerksinimler: `2CPU 2RAM 50GB SSD`(min)
> ## Bu rehberde full node kurucaz ve ardından validatör olucaz.
> ## Prover olarak katılmak isterseniz [buradan](https://github.com/ziesha-network/zoro)devam edin.
> ## Kurulumu tamamladıkran sonra, yapılacak diğer işlemler ve gelecek güncellemeler için Discord duyurularını takip etmeyi unutmatın.
> ## Sorularınız olursa yine discorddan sorabilirsiniz.
#
> ## Kurulum tamamlandıktan sonra bu komutu girin
```
source "$HOME/.cargo/env"
```
> ## Senkronize olduktan sonra bu komut ile validatörünüzü kaydedin
```
bazuka wallet register-validator --commission <commision>
```
> ## Ardından validatörünüze token delegate etmeniz gerekecek. Bunun için önce discorddaki faucetten  token alın.
```
bazuka wallet delegate --amount <miktar> --fee <fee> --to <validatöradresi>
```
## Şu an için işlemler bu kadar. Gelişmeler için duyuruları takip etmeyi unutmayın.


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
> ### Validatör bilgisi
```
bazuka wallet info --validator
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
