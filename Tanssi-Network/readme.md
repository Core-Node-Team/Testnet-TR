
<h1 align="center"> Tanssi

![image](https://github.com/molla202/Tanssi/assets/91562185/209da5fb-efe6-4170-a7ba-90511307e0f7)

> Hızlı, Verimli ve Zahmetsiz Appchain Dağıtımına Gateway'iniz
Tanssi, geliştiricileri, uygulama dağıtımını hızlı ve zahmetsiz hale getirmek için özel olarak tasarlanmış geniş bir altyapı araçları ve hizmetleri kümesiyle donatan bir uygulama altyapısı protokolüdür.

> Uygulama dağıtım süresini aylardan bir saatin altına dönüştürerek Tanssi, blockchain alanında büyük bir değişime yol açarak benzersiz verimlilik ve ölçeklenebilirliğin kilidini açıyor.

 [Topluluk kanalımız](https://t.me/corenodechat)<br>
 [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 [Tanssi Website](https://www.tanssi.network/)<br>
 [Discord](https://discord.gg/WMxTM2fQkr)<br>
 [Twitter](https://twitter.com/TanssiNetwork)<br>
 [Doc](https://docs.tanssi.network/node-operators/block-producers/onboarding/run-a-block-producer/block-producer-systemd/)<br>
 [Explorer](https://polkadot.js.org/apps/?rpc=wss://fraa-dancebox-rpc.a.dancebox.tanssi.network#/extrinsics)<br>
 [Telemetry](https://telemetry.polkadot.io/#stats/0x27aafd88e5921f5d5c6aebcd728dacbbf5c2a37f63e2eda301f8e0def01c43ea)<br>

</h1>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2+|
| RAM	| 4+ GB |
| Storage	| 160+ GB SSD |

### Öcelikle form dolduralım

https://polkadot.js.org/apps/?rpc=wss://fraa-dancebox-rpc.a.dancebox.tanssi.network#/accounts

* Adres olsuturun veya varsa adresinizi alın ve formu doldurun

https://www.tanssi.network/block-producer-form


```
wget https://github.com/moondance-labs/tanssi/releases/download/v0.7.0/tanssi-node && \
chmod +x ./tanssi-node

sudo mkdir /root/tanssi-data/

cd /root/tanssi-data/

mv /root/tanssi-node /root/tanssi-data

```
NOT: molla202 yazan yerleri kendi adınızla değiştirin
```
sudo tee /etc/systemd/system/tanssid.service > /dev/null <<'EOF'
[Unit]
Description="Tanssi systemd service"
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=on-failure
RestartSec=10
User=root
SyslogIdentifier=tanssi
SyslogFacility=local7
KillSignal=SIGHUP
ExecStart=/root/tanssi-data/tanssi-node \
--chain=dancebox \
--name=molla202 \
--unsafe-force-node-key-generation \
--sync=warp \
--base-path=/root/tanssi-data/para \
--state-pruning=2000 \
--blocks-pruning=2000 \
--collator \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' \
--database paritydb \
-- \
--name=molla202 \
--base-path=/root/tanssi-data/container \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' \
-- \
--chain=westend_moonbase_relay_testnet \
--name=molla202 \
--unsafe-force-node-key-generation \
--sync=fast \
--base-path=/root/tanssi-data/relay \
--state-pruning=2000 \
--blocks-pruning=2000 \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' \
--database paritydb \

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable tanssid.service
sudo systemctl restart tanssid.service
```
```
journalctl -u tanssid -fo cat
```


## Key olusturalım.
```
curl http://127.0.0.1:9944 -H \
"Content-Type:application/json;charset=utf-8" -d \
  '{
    "jsonrpc":"2.0",
    "id":1,
    "method":"author_rotateKeys",
    "params": []
  }'
```
## KEyi kaydedelim
* Linke gidelim.

https://polkadot.js.org/apps/?rpc=wss://fraa-dancebox-rpc.a.dancebox.tanssi.network#/extrinsics

* 1 cüzdanı seçin olusturmadıysanız accountan olusturup bilgilerini yedekleyin. yok oluşturcam derseniz sunucundanda olusturabilirsiniz `/root/tanssi-data/tanssi-node key generate -w 24`
* 2 resimdeki gibi seçin `setkeys(keys,proof)`
* 3 key olusturmustuk onu girin
* 4 girin `0x`
> 5 Tıklayın İşlem Gönder ve işlemi cüzdanınızdan imzalayıp gönderin

![image](https://github.com/molla202/Tanssi/assets/91562185/028512d5-82f3-415e-8bc6-f23a860db449)

NOT: şimdi faucet için bir form doldurmalı ve discordan rol almalıyız. dokumanın basında bu kısım var sadece hatırlatma amacıyla yazıyorum.

 https://www.tanssi.network/block-producer-form

## Bond işlemi








