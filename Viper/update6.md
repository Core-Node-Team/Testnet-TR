
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

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/4a21a813-25ca-4bcc-98db-c8c7c81f8f12)



```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
