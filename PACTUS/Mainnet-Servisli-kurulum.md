<h1 align="center"> Pactus Mainnet</h1>


![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/fc854b16-a554-419c-afbf-f99de720060a)

#  | [Twitter](https://twitter.com/pactuschain/) | [Discord](https://discord.gg/pactus-795592769300987944) | [Website](https://pactus.org/) | [Github](https://github.com/pactus-project) |


# EXPLORER

https://pacviewer.com/

```
cd
curl --proto '=https' --tlsv1.2 -sSL https://github.com/pactus-project/pactus/releases/download/v1.4.0/pactus_downloader.sh | sh
mkdir -p pac
cp -r pactus-cli_1.4.0/* pac/
cd pac
```
- Yeni kurucaksanız.
```
./pactus-daemon init -w ~/pactus
```
- Zaten kelimeleriniz var ise import
```
./pactus-daemon init -w ~/pactus --restore "mnemonic"
```
NOT: cüzdan şifrenizi değiştirin aşağıdakinde.
```
sudo tee /etc/systemd/system/pactusd.service <<EOF
[Unit]
Description=Pactus Service
After=network.target

[Service]
User=root
Group=root
ExecStart=/root/pac/pactus-daemon start -w /root/pactus -p şifreni-yaz
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable pactusd.service
sudo systemctl restart pactusd
```
```
journalctl -u pactusd -fo cat
```
### Bakiye sorgula
```
cd
cd pac
```
```
./pactus-wallet --path ~/pactus/wallets/default_wallet address balance cüzdan-adresi
```
### Gönderme
```
cd
cd pac
```
```
./pactus-wallet --path ~/pactus/wallets/default_wallet tx transfer  gönderici-adres alıcı-adres gönderilecek-miktar
```

### Snap
NOT: servisi durdurun önce.
```
wget -P $HOME http://37.120.189.81/pactus/pactus.zip
unzip -d $HOME/pactus $HOME/pactus.zip
```
### Ben zaten çalıştırıyordum nasıl servise geçicem
NOT: screen içine gir önce durdur çık sona yap.
```
cd
mkdir -p pac
cp -r pactus-cli_1.4.0/* pac/
cd pac
```
- Yeni kurucaksanız.
```
./pactus-daemon init -w ~/pactus
```
- Zaten kelimeleriniz var ise import
```
./pactus-daemon init -w ~/pactus --restore "mnemonic"
```
NOT: cüzdan şifrenizi değiştirin aşağıdakinde.
```
sudo tee /etc/systemd/system/pactusd.service <<EOF
[Unit]
Description=Pactus Service
After=network.target

[Service]
User=root
Group=root
ExecStart=/root/pac/pactus-daemon start -w /root/pactus -p şifreni-yaz
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable pactusd.service
sudo systemctl restart pactusd
```
```
journalctl -u pactusd -fo cat
```
