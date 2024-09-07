
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper10
chmod +x /usr/local/bin/viper
```
```
viper network version
```


![image](https://github.com/user-attachments/assets/8cf37d2f-94c1-4bd8-84aa-d5baa7b23eb2)




### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
