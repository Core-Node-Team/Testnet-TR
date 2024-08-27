
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

### Düzeltme

nano ~/.viper/config/blockchains.json

içerisindekileri bir metin belgesine kaydedin.alttaki kodu düzenleyip sunucudaki içeriği silip(ctrl+k basarak silin) düzenlendiğiniz içeriği içine yapıstırın ctrl +xy enterla kaydedip çıkın.


```
   [
  {
    "id": "0001",
    "url": "http://localhost:8082/",
    "websocket_url": "wss://localhost:8082/ws",
    "basic_auth": {
      "username": "",
      "password": ""
    }
  },
  {
    "id": "002",
    "url": "http://localhost:8545",
    "websocket_url": "wss://localhost:8545",
    "basic_auth": {
      "username": "",
      "password": ""
    }
  },
  {
    "id": "003",
    "url": "https://rpc-testnet.suiscan.xyz:443/",
    "websocket_url": "wss://rpc-testnet.suiscan.xyz:443/",
    "basic_auth": {
      "username": "",
      "password": ""
    }
  }
]
``` 

### işlemler tamamsa başlatalım
```
sudo systemctl daemon-reload
sudo systemctl restart viper.service
journalctl -u viper -f
```
