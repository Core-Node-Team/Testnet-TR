
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper7
chmod +x /usr/local/bin/viper
```
```
viper network version
```


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/acb90d63-8ad0-48bd-9bf8-a26b1dcbe4f1)



## 4278 öncesi bir blokta sıkıştıysanız ilerlemıyorsa altakini yapıyorsunuz.
```
cd
cd ~/.viper
rm -r data
sudo git clone https://github.com/vishruthsk/data.git data
sudo chown -R root ~/.viper/data
```


### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
