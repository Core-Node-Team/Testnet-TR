![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/42bd08c8-a812-4a31-beaf-ecfaa698e94e)

NOT: ubuntu 20
```
sudo ufw allow 22
sudo ufw allow 8301
sudo ufw allow 8302
sudo ufw allow 3089
```
### Mina
```
sudo rm /etc/apt/sources.list.d/mina*.list
echo "deb [trusted=yes] http://packages.o1test.net/ focal rampup" | sudo tee /etc/apt/sources.list.d/mina-rampup.list
sudo apt-get update
```
```
sudo apt-get install -y mina-berkeley=2.0.0rampup5-55b7818
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
* community-216-key içindekileri kopyalıyoruz. indirdiğiniz dosyada metin belgesiyle falan açın
*	ctrl x +y ile kaydedelim
*	wallet dosyasının yetkisini düzenliyelim
```
chmod 600 ~/keys/my-wallet
```
*	 my-wallet.pub dosyasını nano ile düzenle deyip yine pcmize indirip açtığımız dosyadaki community-216.pub içindekileri buraya kopyalıyoruz ctrl x y ile kaydediyoruz
```
nano ~/keys/my-wallet.pub
```
### Çalıştırma manuel



Not: Yeni cüzdanınızın şifresini, çıkardığınız topluluk-216-password.txt dosyasında bulabilirsiniz. bu şifreyi altaki `MINA_PRIVKEY_PASS="şifre"` yazan yere yazıcanız. ctrl x y enterla kaydet. 
* altaki kodlada olusturduğunuz şifreyi `MINA_LIBP2P_PASS="şifre"` buraya yazıcaksınız.yani kodu girince bir şifre sorucak mesela 12345678 dediniz he onu `MINA_LIBP2P_PASS="şifre"` buraya yazıcanız artık ne şifre koyarsanız
* UPTIME_PRIVKEY_PASS="şifre" buraya,  burda yazdığın şifreyi yazınız MINA_PRIVKEY_PASS="şifre"

```
mina libp2p generate-keypair -privkey-path /root/keys/keys
```
---------------
```
nano ~/.mina-env
```

* nano ~/.mina-env dedikten sonra altaki kodu kopyalayıp içine yapıstırıyoruz mubarekler sona duzeltilicek yerleri düzeltin 
```
MINA_PRIVKEY_PASS="şifre"
UPTIME_PRIVKEY_PASS="şifre"
EXTRA_FLAGS="--log-json --log-snark-work-gossip true --internal-tracing --insecure-rest-server --log-level Debug --file-log-level Debug --config-directory /root/.mina-config/ --external-ip $(wget -qO- eth0.me) --itn-keys  f1F38+W3zLcc45fGZcAf9gsZ7o9Rh3ckqZQw6yOJiS4=,6GmWmMYv5oPwQd2xr6YArmU1YXYCAxQAxKH7aYnBdrk=,ZJDkF9EZlhcAU1jyvP3m9GbkhfYa0yPV+UdAqSamr1Q=,NW2Vis7S5G1B9g2l9cKh3shy9qkI1lvhid38763vZDU=,Cg/8l+JleVH8yNwXkoLawbfLHD93Do4KbttyBS7m9hQ= --itn-graphql-port 3089 --uptime-submitter-key  /root/keys/my-wallet --uptime-url https://block-producers-uptime-itn.minaprotocol.tools/v1/submit --metrics-port 10001 --enable-peer-exchange  true --libp2p-keypair /root/keys/keys --log-precomputed-blocks true --max-connections 200 --peer-list-url  https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt --generate-genesis-proof  true --block-producer-key /root/keys/my-wallet --node-status-url https://nodestats-itn.minaprotocol.tools/submit/stats  --node-error-url https://nodestats-itn.minaprotocol.tools/submit/stats  --file-log-rotations 500"
RAYON_NUM_THREADS=6
MINA_LIBP2P_PASS="şifre"
```
```
chmod 600 ~/.mina-env
```

* Tek seferde kopyala yapıştır
```
sudo tee /usr/lib/systemd/user/mina.service > /dev/null << EOF
[Unit]

Description=Mina Daemon Service
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
Environment="PEERS_LIST_URL=https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt"
Environment="LOG_LEVEL=Info"
Environment="FILE_LOG_LEVEL=Debug"
EnvironmentFile=%h/.mina-env
Type=simple
Restart=always
RestartSec=30
ExecStart=/usr/local/bin/mina daemon --log-json --log-snark-work-gossip true --internal-tracing --insecure-rest-server --log-level Debug --file-log-level Debug --config-directory /root/.mina-config/ --external-ip $(wget -qO- eth0.me) \
--itn-keys  f1F38+W3zLcc45fGZcAf9gsZ7o9Rh3ckqZQw6yOJiS4=,6GmWmMYv5oPwQd2xr6YArmU1YXYCAxQAxKH7aYnBdrk=,ZJDkF9EZlhcAU1jyvP3m9GbkhfYa0yPV+UdAqSamr1Q=,NW2Vis7S5G1B9g2l9cKh3shy9qkI1lvhid38763vZDU=,Cg/8l+JleVH8yNwXkoLawbfLHD93Do4KbttyBS7m9hQ= \
--itn-graphql-port 3089 --uptime-submitter-key  /root/keys/my-wallet --uptime-url https://block-producers-uptime-itn.minaprotocol.tools/v1/submit --metrics-port 10001 \
--enable-peer-exchange  true --libp2p-keypair /root/keys/keys --log-precomputed-blocks true --max-connections 200 \
--peer-list-url  https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt --generate-genesis-proof  true \
--block-producer-key /root/keys/my-wallet --node-status-url https://nodestats-itn.minaprotocol.tools/submit/stats  --node-error-url https://nodestats-itn.minaprotocol.tools/submit/stats \
--file-log-rotations 500
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







