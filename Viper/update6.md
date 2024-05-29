
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper6
chmod +x /usr/local/bin/viper
```
```
viper network version
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/cf75893c-9817-4f4f-b972-664fc0c12a05)




```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
