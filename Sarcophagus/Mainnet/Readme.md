<h1 align="center"> Sarcophagus-Mainnet </h1>

![1500x500](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/166f6a97-37c4-4b04-b28c-da54d40eb0aa)

## Arkadaşlar herkese merhaba. Testnetini yaptığımız Sarcophagus mainneti başladı.
>  Aldığınız 1000 $SARCO ödülün tamamını burada kullanacaksınız.
> 
>  6 ay boyunca mainnet çalıştırıp ve %99 uptime şartını sağlayanlara 6000 $SARCO ödül verilecek.
> 
>  Etherium işlem katmanı ile etkileşime girebilmek için bir Eth Mainnet RPC adresine ihtiyacınız olacak. Muhtemelen ücretsiz olanlar yetecektir.
> 
>  Kurulum yapacağınız sunucuya A kaydı yapılmış bir domain olması gerekiyor.
> 
>  Sarco cüzdanınızın private keyi kurulum esnasında gerekecek
> 
>  Cüzdanınızda gaz ücretlerini karşılamak için $ETH bulunması gerekiyor.
>  En çok düşündüren konu bu biliyorum
>
> Eğer dapp testnetine de katıldıysanız 300 $Sarco da oradan ödül aldınız. Bunu ethye çevirince başlangıç için yeterli olacağını düşünüyorum.
> 
> Sunucu gereksinimleri 1 Cpu 1 Gb Ram ve 10 Gb Ssd fazlasıyla yeterli olacaktır. (Min 500mb ram 4gb ssd)

## Kurulum yapmak için bu komutu girin
```
curl -sSL -o sarcophagus.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Sarcophagus/Mainnet/sarcophagus.sh && chmod +x sarcophagus.sh && bash ./sarcophagus.sh
```
## Tamamlandıktan sonra arkeolog kaydını yapmak için
```
cd quickstart-archaeologist
COMPOSE_PROFILES=register docker compose run register
```
### Komutu girdikten sonra sırasıyla
> Tüm adımlarda detaylı açıklamalar yazıyor, okuyun ve kendinize göre belirleyin.
> 
> Ben tamamında tavsiye edilen değerleri girdim.
> 
> Bu değerler daha sonra güncellenebilir
> 
> 1. soru kontraktla etkileşime girmek onayı `y` diyin
> ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/c7713afe-c609-4197-86d8-0ef980a225c7)

> 2. soru digging fee, tutacağınız lahitler karşılığında mumyacıdan aylık talep ettiğiniz $SARCO miktarı
> ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/26115ac0-cb97-478c-9279-56d59a6cdf87)

> 3. soru curse-fee
> ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/ba2bde82-81bd-4097-9678-00b9a7d72465)

> 4. soru free-bond 1000 seçin
> 
> 5. soru arkeolog nodu ne kadar süre çalıştıracağınızı belirtin. seçtiğiniz süreden erken kapatırsanız kilitlli varlıklarınızı kaybedersiniz. 
>  ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/8e9d878a-ed07-4b42-ac50-60daf1b4fe84)
> 6. ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/f3a80030-2803-4017-bcf5-b061c2c8573c) 
> 7. Son kontrol ve onay
> ![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/ea733f4f-c5e5-40c8-affa-533dee486201)

## Tamamlandı
![image](https://github.com/0xSocrates/Sarcophagus-Mainnet/assets/108215275/58fcc216-5b9b-4a01-ad1f-60669cf6f629)

## Başlatın
```
COMPOSE_PROFILES=service docker compose up -d
```

## Log kontrolü
```
docker logs --follow quickstart-archaeologist-acme-companion-1
```
```
docker logs --follow quickstart-archaeologist-archaeologist-1 
```
```
docker logs --follow nginx-proxy 
```

