

![image](https://github.com/user-attachments/assets/5c22af91-0609-4738-88df-44a924caf2c8)

☄️Glacir Verifier Node

FORM : https://docs.google.com/forms/d/e/1FAIpQLSfE1QDdVzW5X9i1UZRpeqK00xcI0B89A8hbvVlZ3X87JDRrnQ/viewform

👉Adres kayıt
```
https://www.glacier.io/points/?inviter=0x05f16A0217e7973Df6288708b769d72e241A5e6a
```
👉Test bnb yi opbnb ye aktarıın ufak
```
https://opbnb-testnet-bridge.bnbchain.org/deposit
```
👉Node kontrol sitesi
```
https://testnet.nodes.glacier.io/status
```
🕹Galxy görevi
```
https://app.galxe.com/quest/glacierlabs/GChNBtVG6A
```
### Dosyaları çekelim
```
cd
mkdir -p glacier
cd glacier
wget https://glacier-labs.github.io/node-bootstrap/config.yaml
wget https://raw.githubusercontent.com/Glacier-Labs/node-bootstrap/refs/heads/main/testnet.yaml
wget -O verifier https://github.com/Glacier-Labs/node-bootstrap/releases/download/v0.0.1-beta/verifier_linux_amd64
chmod +x $HOME/glacier/verifier
```
NOT: config.yaml içinde private yazılacak. nasıl.  `nano $HOME/glacier/config.yaml`
### Servis kurulum
```
sudo tee /etc/systemd/system/glacierd.service > /dev/null <<EOF
[Unit]
Description=Glacier Node
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/glacier
ExecStart=$HOME/glacier/verifier
Restart=always
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable glacierd
sudo systemctl start glacierd
```
```
journalctl -u glacierd -fo cat
```

NOT: MANUEL BİNARY TESTLERİ ONUR TARAFINDAN YAPILMIŞ VE TEST EDİLMİŞTİR. SERVİSE ÇEVİRMEK İÇİN MAUSE TIKLAMAK YETERLİ OLDU :D

### Dockerlı kurulum...

☄️Glacir Verifier Node

👉Adres kayıt
```
https://www.glacier.io/points/?inviter=0x05f16A0217e7973Df6288708b769d72e241A5e6a
```
👉Test bnb yi opbnb ye aktarıın ufak
```
https://opbnb-testnet-bridge.bnbchain.org/deposit
```
👉Tek kod privateni yazıycaksın. Docker kurulu olması lazım yoksa diğer projelerden birinde yazıyordur yada ekleriz.
```
docker run -d -e PRIVATE_KEY="Ha-bura-private-yaz-cıfırsız" --name glacier-verifier docker.io/glaciernetwork/glacier-verifier:v0.0.1
```
👉Loglara bakalım
```
docker logs -f glacier-verifier
```
👉Node kontrol sitesi
```
https://testnet.nodes.glacier.io/status
```
🕹Galxy görevi
```
https://app.galxe.com/quest/glacierlabs/GChNBtVG6A
```
NOT: DOCKER KURULUMU GEREKLİ - TEST BNB GEREKLİ... ZATEN KURMANIZA GEREK YOKSA KURULUYSA DİYE HARİCİ EN ALTTA PAYLAŞTIM DOCKER KURULUMUNU

### Docker kurulumu ve gereklilikler.
```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


