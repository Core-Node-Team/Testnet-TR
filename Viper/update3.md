
### Güncelleme
```
sudo systemctl stop viper.service
```
```
rm -rf /usr/local/bin/viper
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper2
chmod +x /usr/local/bin/viper
```
```
sudo systemctl stop viper.service
```
```
cd ~/.viper
rm -r data
sudo git clone https://github.com/vishruthsk/data.git data
sudo chown -R root ~/.viper/data
```
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
