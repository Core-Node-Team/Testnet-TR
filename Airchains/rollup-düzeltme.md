
Not: manuel çalıştırmayı otoya çeviriyoruz.
```
screen -r avail
```
- ctrl c ile durdurun exit yazıp çıkın

```
cd
wget https://github.com/availproject/avail-light/releases/download/v1.9.0/avail-light-linux-amd64.tar.gz
tar -xvzf avail-light-linux-amd64.tar.gz
mv avail-light-linux-amd64 avail-light
chmod +x avail-light
rm -rf avail-light-linux-amd64.tar.gz
```
```
sudo tee /etc/systemd/system/availd.service > /dev/null <<EOF
[Unit]
Description=Avail Light Client
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
ExecStart=/root/avail-light \
--network "turing" \
--config /root/.avail/turing/config/config.yml \
--app-id 0 \
--identity /root/.avail/identity/identity.toml
 
Restart=always
RestartSec=30
Environment="DAEMON_HOME=$HOME/.avail"

[Install]
WantedBy=multi-user.target
EOF
```

#### Başlatalım
```
sudo systemctl daemon-reload
```
```
systemctl enable availd
```
```
sudo systemctl restart availd && journalctl -u availd -fo cat
```
- kontrol edelim hala aynı adresmi çıkıor daha once kaydetmiştik aynıysa tamamsınız.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/399bdbd0-f78b-44d9-8d74-6c09d0113c72)

## Loglar
```
journalctl -u availd -fo cat
```

------------------------------

- şimdide dosya içinde dakey duzenliyelim. resimdede gorulduğu gibi dakey kısmına cüzdan adresimizi yazıp ctrl x+y enterla kaydedip çıkalım.
```
nano /root/.tracks/config/sequencer.toml
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/70a5195e-e88b-4312-baba-528745b0cd0e)
```
screen -r etm
```
- çalışıorsa durdurun ctrl c ile ve aşağıdaki kodla tekrar başlatın.
```
go run cmd/main.go start
```
