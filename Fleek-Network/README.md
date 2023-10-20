
<div align="center">
  <h1>Fleek-Network </h1>
</div>

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/74fad132-3c1f-4bf8-a90a-9afa5cba3f64)


* [CoreNode Telegram](https://t.me/corenodechat)<br>
* [CoreNode Twitter](https://twitter.com/corenodeHQ)<br>
* [Fleek Network](https://fleek.network/)<br>
* [Fleek Network Twitter](https://twitter.com/fleek_net)<br>
* [Fleek Network DOC](https://docs.fleek.network/docs)<br>


 ## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️ CPU |	4 |
| ✔️ RAM	| 16 GB |
| ✔️ Storage	| ~GB SSD |

### RESMİ OTO KURULUM UBUNTU 22 HERSEY DAHİL
```
adduser lgtn
```
```
usermod -aG sudo lgtn
```
```
su lgtn
```
```
sudo fallocate -l 10240M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
```
curl https://get.fleek.network | bash
```
NOT: eğer ilk kurup waitlist onaylandıysa alttan update edin...
```
curl https://get.fleek.network/update | bash
```
NOT: ekranda gözükmesse keyler...
```
lgtn keys show
```
```
sudo systemctl daemon-reload
sudo systemctl enable lightning
sudo systemctl restart lightning
```
### durumuna bakalım...
```
sudo systemctl status lightning.service
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/87cb0357-c904-406a-ba4f-0484fc2ca2e2)


### Log kontrol
```
tail -f /var/log/lightning/output.log
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/26aa640f-43e5-4fec-a8d6-c2aa4957435b)


```
tail -f /var/log/lightning/diagnostic.log
```

* NOT: arkadaslar vaziyet çok karışık :D bi whitelist mevzusu var evet publicteyiz ama var neyse çok karıştırmışlar herşeyi birbirine düzelecektir. discord üzerinden whitelist işlemini onaylatırsak olacak dalga dalga olaucak dıyorlar.
* NOT: arkadaslar bir kullanıcı olusturduk adı `lgtn` daha sonra sunucunuza girdiğiniz işlem yapacaksanız. `su lgtn` yazıp bu kullanıcıya geçmeniz gerekiyor.
# MANUEL KURULUM....
### 🏠 Update edelim
```bash
sudo apt update; sudo apt upgrade 
```
### 🤖 Gerekli olanlar
```
sudo apt install screen curl tar wget jq build-essential make clang pkg-config libssl-dev cmake gcc
```
### 🤖 Rustup kuruyoruz
✏️ Not: 1 seçeceksiniz. daha önce kuruluysa kurmanıza gerek yok.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source ~/.profile
source ~/.cargo/env
```
### 🤖 Protobuf ve sccache Kuruyoruz
```
cargo install sccache
```
```
sudo apt-get install protobuf-compiler
```
### diski ram oalrka kullanalım kurarken hata vermesin diye
```
sudo fallocate -l 10240M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
### 👷 `fleek-network/lightning.git` 'i klonluyoruz.
```
cd $HOME 
git clone -b testnet-alpha-0 https://github.com/fleek-network/lightning.git ~/lightning
cd lightning
```
```
cargo +stable build --release
```
```
sudo rm -f "/usr/local/bin/lgtn"
sudo ln -s "$HOME/lightning/target/release/lightning-node" /usr/local/bin/lgtn
```
* `cargo +stable build` uzun sürer. hata verirse tekrar gir hata vermeyeseye kadar.
* daha sonra version kontrol edin: 📖`lgtn --version`
* version: `lightning-node 0.1.0`✅
### 🚀 key alma işlemi...

```
lgtn keys generate
```
### servis olarak çalıştıralım...
```
sudo tee /etc/systemd/system/lightning.service > /dev/null <<EOF
[Unit]
Description=Fleek Network Node lightning service
    
[Service]
User=root
Type=simple
MemoryHigh=32G
RestartSec=15s
Restart=always
ExecStart=lgtn run
StandardOutput=append:/var/log/lightning/output.log
StandardError=append:/var/log/lightning/diagnostic.log
    
[Install]
WantedBy=multi-user.target
EOF
```
```
sudo mkdir -p /var/log/lightning
sudo touch /var/log/lightning/output.log
sudo touch /var/log/lightning/diagnostic.log
```
```
sudo systemctl daemon-reload
sudo systemctl enable lightning
sudo systemctl restart lightning
```
### durumuna bakalım...
```
sudo systemctl status lightning.service
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/87cb0357-c904-406a-ba4f-0484fc2ca2e2)

### Log kontrol
```
tail -f /var/log/lightning/output.log
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/26aa640f-43e5-4fec-a8d6-c2aa4957435b)

```
tail -f /var/log/lightning/diagnostic.log
```

* NOT: arkadaslar vaziyet çok karışık :D bi whitelist mevzusu var evet publicteyiz ama var neyse çok karıştırmışlar herşeyi birbirine düzelecektir. discord üzerinden whitelist işlemini onaylatırsak olacak dalga dalga olaucak dıyorlar.

### ♻️ Key dosyası yedekleme
* Dosyalarınız bu konumda yer alıyor. ``~/.lightning/keystore``  yedekleyiniz.alttaki kod port değişikliği için deneyeceğiz :D
```
nano ~/.lightning/config.toml
```
NOT: MİNT STAKE SAYFASINDAN DEVAM EDİN



