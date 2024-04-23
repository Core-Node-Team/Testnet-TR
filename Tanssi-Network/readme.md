
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


</h1>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2+|
| RAM	| 4+ GB |
| Storage	| 160+ GB SSD |



```
wget https://github.com/moondance-labs/tanssi/releases/download/v0.6.0/tanssi-node && \
chmod +x ./tanssi-node

sudo mkdir /root/tanssi-data/

cd /root/tanssi-data/

mv /root/tanssi-node /root/tanssi-data

```
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
--sync=warp \
--base-path=/root/tanssi-data/para \
--state-pruning=2000 \
--blocks-pruning=2000 \
--collator \
--database paritydb \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' 
-- \
--name=molla202 \
--base-path=/root/tanssi-data/container \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' 
-- \
--chain=westend_moonbase_relay_testnet \
--name=molla202 \
--sync=fast \
--base-path=/root/tanssi-data/relay \
--state-pruning=2000 \
--blocks-pruning=2000 
--database paritydb \
--telemetry-url='wss://telemetry.polkadot.io/submit/ 0' 

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
## 








