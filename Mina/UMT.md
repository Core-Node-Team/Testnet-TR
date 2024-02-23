




```
sudo rm /etc/apt/sources.list.d/mina*.list
```
```
sudo echo "deb [trusted=yes] http://packages.o1test.net $(lsb_release -cs) umt" | sudo tee /etc/apt/sources.list.d/mina.list
```
```
sudo apt-get update
```
```
sudo apt-get install --allow-downgrades -y mina-mainnet=1.0.0umt-2025a73
```

* gelen zipli dosyayı mailden pcye indirin ve açın hebelehübele.zip
* Sunucuda bir keys dosyası oluşturuyoruz ~/keys .
```
mkdir ~/keys
```
*	dosyanın yetkisini düzenliyoruz
```
chmod 700 ~/keys
```
* Nano ile my-wallet içini düzenliyoruz
```
nano ~/keys/my-wallet
```
* community-33-key içindekileri kopyalıyoruz. indirdiğiniz dosyada metin belgesiyle falan açın
*	ctrl x +y ile kaydedelim
*	wallet dosyasının yetkisini düzenliyelim
```
chmod 600 ~/keys/my-wallet
```
*	 my-wallet.pub dosyasını nano ile düzenle deyip yine pcmize indirip açtığımız dosyadaki community-33.pub içindekileri buraya kopyalıyoruz ctrl x y ile kaydediyoruz
```
nano ~/keys/my-wallet.pub
```

Not: Yeni cüzdanınızın şifresini, çıkardığınız community-33-password.txt dosyasında bulabilirsiniz. bu şifreyi altaki `MINA_PRIVKEY_PASS="şifre"` yazan yere yazıcanız. ctrl x y enterla kaydet. 
* altaki kodlada olusturduğunuz şifreyi `MINA_LIBP2P_PASS="şifre"` buraya yazıcaksınız.yani kodu girince bir şifre sorucak mesela 12345678 dediniz he onu `MINA_LIBP2P_PASS="şifre"` buraya yazıcanız artık ne şifre koyarsanız
* UPTIME_PRIVKEY_PASS="şifre" buraya,  burda yazdığın şifreyi yazınız MINA_PRIVKEY_PASS="şifre"

```
mina libp2p generate-keypair -privkey-path /root/keys/keys
```
---------------


* Tek seferde kopyala yapıştır
```
sudo tee /usr/lib/systemd/user/mina.service > /dev/null << EOF
[Unit]

Description=Mina Daemon Service
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
Environment="PEERS_LIST_URL=https://storage.googleapis.com/o1labs-gitops-infrastructure/o1labs-umt-pre-fork-run-1/seed-list-o1labs-umt-pre-fork-run-1.txt"
Environment="LOG_LEVEL=Info"
Environment="FILE_LOG_LEVEL=Debug"
EnvironmentFile="RAYON_NUM_THREADS=6
EnvironmentFile="UPTIME_PRIVKEY_PASS="şifre"
EnvironmentFile="MINA_LIBP2P_PASS="şifre"
EnvironmentFile="MINA_PRIVKEY_PASS="şifre"

Type=simple
Restart=always
RestartSec=30
ExecStart=/usr/local/bin/mina daemon \
--block-producer-key /root/keys/my-wallet \
--config-directory /root/.mina-config/ \
--enable-peer-exchange true \
--external-ip $(wget -qO- eth0.me) \
--file-log-level Debug \
--file-log-rotations 500 \
--generate-genesis-proof true \
--insecure-rest-server \
--libp2p-keypair /root/keys/keys \
--log-json \
--log-level Debug \
--log-precomputed-blocks true \
--log-snark-work-gossip true \
--metrics-port 10001 \
--node-error-url https://nodestats-itn.minaprotocol.tools/submit/stats \
--node-status-url https://nodestats-itn.minaprotocol.tools/submit/stats \
--peer-list-url https://storage.googleapis.com/o1labs-gitops-infrastructure/o1labs-umt-pre-fork-run-1/seed-list-o1labs-umt-pre-fork-run-1.txt \
--uptime-submitter-key /root/keys/my-wallet \
--uptime-url https://block-producers-uptime-itn.minaprotocol.tools/v1/submit


ExecStop=/usr/local/bin/mina client stop-daemon

[Install]
WantedBy=default.target
EOF
```
```

systemctl --user daemon-reload
systemctl --user restart mina
systemctl --user enable mina
sudo loginctl enable-linger
journalctl --user-unit mina -n 1000 -f
```

Not: az bekle sona bu cıktı vericek
```
mina client status
```
