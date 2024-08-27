
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper9
chmod +x /usr/local/bin/viper
```
```
viper network version
```

![image](https://github.com/user-attachments/assets/78b509c4-5c61-4793-9eff-9983fa0ea994)



### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
