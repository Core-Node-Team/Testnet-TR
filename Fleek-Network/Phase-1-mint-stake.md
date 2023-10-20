# Mint

Metamask'a aşağıdaki Fleek ağını ekleyiniz.

```
Network Name: Fleek Network
RPC URL: https://rpc.testnet.fleek.network/rpc/v0
Chain ID: 59330
Currency symbol: tFLK
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5ab9cd70-9c69-423d-ae79-b9d8b71543af)


- **Faucet:** **https://faucet.testnet.fleek.network/**

- Siteye cüzdanınız bağlayın ve mint edin bazen olmaya bilir bi kaç defa deneyin mubarekler

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/65db344a-a6a9-4af5-bae9-7c2d92b0acad)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5c4916ec-76b6-4fe2-a8ae-5a1d00e6ff1a)

# Stake

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/5ce0327b-4217-4c35-8d70-c08ab2dea706)

- `Node Public Key` `Consensus Public Key` ve Sunucu `IP` ekliyoruz. Stake diyruz nerden bulucaz ben görmedim diyenler için `lgtn keys show` diyoruz

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2ca27c5a-3046-4295-a7ab-bd47f186dc16)


Not: çıktılar ilk basta 

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/0cebd5fc-ab0a-4cea-b915-938c3b7b58f4)

- stake işleminden sonra `sudo systemctl restart lightning` diyoruz ve akmaya başlıyor.


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/3872fdbb-fabc-4002-afd2-052ee344113a)

```
tail -f /var/log/lightning/output.log
```

- Healt check
```
http://sunucuipsi:4230/health
```


