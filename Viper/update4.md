
### Güncelleme
```
cd
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper4
chmod +x /usr/local/bin/viper
```
```
viper network version
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/8e825cae-a91f-4c3e-bea9-8a2fcb5b8da4)

```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
