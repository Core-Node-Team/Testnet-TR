![image](https://github.com/molla202/Viper-private/assets/91562185/83832c2d-997b-4f4c-992a-6bee394b5891)


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>

## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 400 GB SSD |

### 🚧Gereklilikler ve Update
```
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
```
### 🚧GO
```
ver="1.21.3" &&
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" &&
sudo rm -rf /usr/local/go &&
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" &&
rm "go$ver.linux-amd64.tar.gz" &&
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile &&
source $HOME/.bash_profile &&
go version
```
### Portları açalım
```
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8081
sudo ufw allow 12656
sudo ufw allow 26656
```
### Dosyaları çekelim
```
wget -O /usr/local/bin/viper http://37.120.189.81/viper/viper
```
```
chmod +x /usr/local/bin/viper
```
Not: altaki kodu girince cüzdan olusuyor şifre soruyor. yazarken görunmez ama yazar cıkan cıktıyı kaydedin.
```
viper wallet create-account
```
![image](https://github.com/molla202/Viper-private/assets/91562185/b9a96691-6add-4a9a-9436-16c7c49efef2)

Not: Adress yazan yazıyı silip yukarıdaki çıkan cüzdan adresini yazıcaksınız.

viper servicers create-validator address

![image](https://github.com/molla202/Viper-private/assets/91562185/928ca790-8448-434b-8eb5-d04d42d1a275)

- Dicorda gidiyoruz rolunuz varsa #🤑|req-tokens kanalını göruceksınız linki var botun girin açılacak oraya adres yazıp fauceti alın işlemlere devam etmeden once biraz bekleyin.
```
echo $(viper util print-configs) | jq '.tendermint_config.P2P.Seeds = "6304da172fce20a6039a6eb5c9154cb8056c0ed6@testnet-seed1.vipernet.xyz:26656"' | jq . > ~/.viper/config/configuration.json
```
```
viper util gen-chains
```
- soru soracak ilkine 0001 sonrakine http://127.0.0.1:8082/ daha sonrakinede enter ve n deyip bitiriyoruz.

![image](https://github.com/molla202/Viper-private/assets/91562185/24b05386-1e62-477d-92f3-1c65e5d5a78e)
```
viper util gen-geozone
```
- 0001 yazıp enterlıyoruz

![image](https://github.com/molla202/Viper-private/assets/91562185/eb571cf2-c0ea-49e2-9265-6aeec97d00ee)
```
cd ~/.viper/config
```
```
wget https://raw.githubusercontent.com/vipernet-xyz/genesis/main/testnet/genesis.json genesis.json
```
```
ulimit -Sn 16384
```

### Servis olsuturalım
```
sudo tee /etc/systemd/system/viper.service > /dev/null << EOF
[Unit]
Description=viper service
After=network.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
User=root
Group=sudo
ExecStart=/usr/local/bin/viper network start
ExecStop=/usr/local/bin/viper network stop

[Install]
WantedBy=default.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable viper.service
sudo systemctl restart viper.service
```
```
journalctl -u viper -f
```
------------------------
### Port ayarları opsiyonel
NOT: baska standart port proje varsa burasını yapmak şart değil. özellikle sıfır sunucuya kuruyorsanız atlayınız.
```
echo "export viper_PORT="12"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
sed -i.bak -e "s%:26658%:${viper_PORT}658%g;
s%:26657%:${viper_PORT}657%g;
s%:26660%:${viper_PORT}060%g;
s%:26656%:${viper_PORT}656%g" $HOME/.viper/config/configuration.json
```
Not: düzeltme yapılcak sonra port değiştirdiyseniz

nano $HOME/.viper/config/configuration.json

![image](https://github.com/molla202/Viper-private/assets/91562185/5a248e2e-06aa-4223-9e59-c008aeece908)

------------------------------------------------
### Domain işlemleri

https://freedns.afraid.org/subdomain/

- Adresine gidiyoruz uyelik olusturuyoruz maili onaylıyrouz ve aşılan pencerede bir domain olusturuyoruz.Destination kısmına sunucu ipsini yazıyoruz

![image](https://github.com/molla202/Viper-private/assets/91562185/1636e6ad-348f-4fa1-98e3-259f60791f66)

![image](https://github.com/molla202/Viper-private/assets/91562185/9888b092-3594-4a29-bf84-cae86fbd35f8)

- sunucu işlemlerine geçelim

```
echo "export HOSTNAME="viper-molla202.strangled.net"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
HOSTNAME=buraya yukardaki resimdeki gibi aldığınız adresi yazıcaksınız.

sudo certbot --nginx --domain $HOSTNAME --register-unsafely-without-email --no-redirect --agree-tos

![image](https://github.com/molla202/Viper-private/assets/91562185/81cd0fc0-7ff7-4e1c-b245-5aba0c00f48b)
```
sudo nano /etc/nginx/sites-available/viper
```
Not: altaki kodu yapıstırıp ctrl x y enterla kaydedip cıkıoruz.
```
server {
    add_header Access-Control-Allow-Origin "*";
    listen 80 ;
    listen [::]:80 ;
    listen 8081 ssl;
    listen [::]:8081 ssl;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name $HOSTNAME;

    location / {
        try_files $uri $uri/ =404;
    }

    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/$HOSTNAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$HOSTNAME/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    access_log /var/log/nginx/reverse-access.log;
    error_log /var/log/nginx/reverse-error.log;

    location ~* ^/v1/client/(dispatch|relay|sim|trigger) {
        proxy_pass http://127.0.0.1:8082;
        add_header Access-Control-Allow-Methods "POST, OPTIONS";
        allow all;
    }

    location = /v1 {
        add_header Access-Control-Allow-Methods "GET";
        proxy_pass http://127.0.0.1:8082;
        allow all;
    }

    location = /v1/query/height {
        add_header Access-Control-Allow-Methods "GET";
        proxy_pass http://127.0.0.1:8082;
        allow all;
    }
}
```
### Ngnix başlatalım
```
sudo systemctl stop nginx
```
```
sudo rm /etc/nginx/sites-enabled/default
```
```
sudo ln -s /etc/nginx/sites-available/viper /etc/nginx/sites-enabled/viper
```
```
sudo systemctl start nginx
```
### Bakiye kontrol
```
sudo viper wallet query account-balance cüzdan-adresinizi-yazınız
```
Not: coin geldiyse stake edicez ağaıyı duzenlyin. domain ve cüzdan adresinizi yazınız
```
viper servicers stake self cüzdan-adresi 10000000000 0001 0C00 https://domainadınız:443 testnet
```
### Eşleştikmi ağla bakalım
Not: port değiştirdiyseniz 26657 12657 oalcak
```
curl http://127.0.0.1:26657/status
```
### Peer ekleme
```
nano $HOME/.viper/config/configuration.json
```

- "PersistentPeers": bu kısma aşağıdakileri ekletin tırnaklar arasına

```
859674aa64c0ee20ebce8a50e69390698750a65f@mynode1.testnet.vipernet.xyz:26656,eec6c84a7ededa6ee2fa25e3da3ff821d965f94d@mynode2.testnet.vipernet.xyz:26656,81f4c53ccbb36e190f4fc5220727e25c3186bfeb@mynode3.testnet.vipernet.xyz:26656,d53f620caab13785d9db01515b01d6f21ab26d54@mynode4.testnet.vipernet.xyz:26656,e2b1dc002270c8883abad96520a2fe5982cb3013@mynode5.testnet.vipernet.xyz:26656
```













