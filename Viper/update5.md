
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

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9b2bf717-8fe3-4288-a99c-c0b20c4c8df3)


```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
