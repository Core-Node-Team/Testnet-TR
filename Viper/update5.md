
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper5
chmod +x /usr/local/bin/viper
```
```
viper network version
```



```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
