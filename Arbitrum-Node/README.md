<div align="center"> 

<h1> Arbitrum Node Kurulumu + Snapshot (40 Million Block) </h1>
  
<img width="1200" alt="647867" src="https://user-images.githubusercontent.com/76253089/225751798-96c9d054-e8a2-4780-9545-6077dded8256.png">
  
<h3>
  
Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
</h3>
  
</div>

<details>

<summary> 
<h2> SIFIRDAN KURULUM (BOŞ SERVER) 
</summary> </h2>
  

## Sunucu Güncelleyelim ve Docker kuralım.

```
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
```
- Karşınıza pembe ekran çıkarsa direk enter tuşuna basın.

## Arbitrum Klasörü açıp yetki verelim
```
mkdir -p ~/data/arbitrum
chmod -fR 777 ~/data/arbitrum
```

## Şimdi Nodeu çalıştıralımi Aşağıdaki RPCURLNİZ yerine Infuradan / Alchemyden aldığınız ETHEREUM RPCSİNİ YAZIN.
```
docker run -d -v ~/data/arbitrum:/home/user/.arbitrum -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 offchainlabs/nitro-node:v2.0.11-8e786ec --l1.url RPCURLNİZ --l2.chain-id=42161 --http.api=net,web3,eth,debug --http.corsdomain=* --http.addr=0.0.0.0 --http.vhosts=* --init.url="https://snapshot.arbitrum.io/mainnet/db.tar"
```
</details>

<details>

<summary> 
<h2> Eski Snapshot kuruluysa, Onu silip 40 milyonlu Snapshotu kuralım.
</summary> </h2>
  
## Eğer sunucunuzda eski snapshotlu node kuruluysa alttaki adımlarla eski dosyaları ve docker dosyalarını silip en allta verdiğim komutla tekrar başlatın.

## Docker dosyalarını silelim
Bu Komutlar Docker İdlerimizi öğrenelim
```
docker ps
```
Sonra dockerlarımızı alttaki komutlarla silelim
```
docker stop DOCKERIDNİZ
docker rm DOCKERIDNİZ
rm -rf data
```
## Arbitrum Klasörü açıp yetki verelim
```
mkdir -p ~/data/arbitrum
chmod -fR 777 ~/data/arbitrum
```

## Şimdi Nodeu çalıştıralımi Aşağıdaki RPCURLNİZ yerine Infuradan / Alchemyden aldığınız ETHEREUM RPCSİNİ YAZIN.
```
docker run -d -v ~/data/arbitrum:/home/user/.arbitrum -p 0.0.0.0:8547:8547 -p 0.0.0.0:8548:8548 offchainlabs/nitro-node:v2.0.11-8e786ec --l1.url RPCURLNİZ --l2.chain-id=42161 --http.api=net,web3,eth,debug --http.corsdomain=* --http.addr=0.0.0.0 --http.vhosts=* --init.url="https://snapshot.arbitrum.io/mainnet/db.tar"
```
</details>


