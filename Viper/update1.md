
### Güncelleme




```
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper_linux_amd64
chmod +x /usr/local/bin/viper
```
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```


### Wrong block hatası alırsanız

```
sudo systemctl stop viper.service
```
```
cd ~/.viper
rm -r data
rm -r viper_evidence.db
rm -r viper_result.db
sudo git clone https://github.com/vishruthsk/data.git data
sudo chown -R viper ~/.viper/data
cd config
rm addrbook.json
```
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
