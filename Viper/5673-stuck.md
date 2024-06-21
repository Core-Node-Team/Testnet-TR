
## 5673 öncesi bir blokta sıkıştıysanız ilerlemıyorsa altakini yapıyorsunuz.
```
apt install zip
systemctl stop viper
cd
cd ~/.viper
rm -r data
cd
wget http://37.120.189.81/viper/data.zip
mkdir /tmp/temp_unzip
unzip /root/data.zip -d /tmp/temp_unzip
mkdir -p /root/.viper/data
mv /tmp/temp_unzip/root/.viper/data/* /root/.viper/data/
rm -rf /tmp/temp_unzip
sudo chown -R root ~/.viper/data
```


### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```


### Kontrol
```
curl http://127.0.0.1:12657/status
```
```
viper servicers query servicer cüzdan adresi yaz
```
Not: paused görunuyorsa altaki kodu girin çalışıyorsa  ve hata verırosa biraz bekleyip deneyin kodu. eve 2 kere cüzdan yazılıor
```
viper servicers unpause cüzdan-yaz cüzdan-yaz testnet
```
