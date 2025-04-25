
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper11
chmod +x /usr/local/bin/viper
```
```
viper network version
```


![image](https://github.com/user-attachments/assets/f93f30c8-2e59-44e0-8cc4-ca184d189f50)





### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
