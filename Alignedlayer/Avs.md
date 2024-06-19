<h1 align="center"> Aligned Layer

![image](https://github.com/molla202/AlignedLayer/assets/91562185/cb9fca1a-a370-4aee-b41d-546d27c4523b)



</h1>

## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Aligned Layer Website](https://alignedlayer.com/)<br>
 * [Discord](https://discord.gg/zHsXryD7)<br>
 * [Twitter](https://twitter.com/alignedlayer)<br>
 


### Sistem Gereksinimleri

LÜTFEN AŞAĞIDAKİLERİ BAZ ALMAYINIZ. FARZI MİSAL YAZILMIŞTIR

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4+ vcpu|
| ✔️RAM	| 8+ GB |
| ✔️Storage	| 200+ GB SSD |
| ✔️UBUNTU | 20-22 |


### Docker kurulumu
```
sudo apt update -y && sudo apt upgrade -y
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```
```
sudo apt-get update
```
```
sudo apt-get install ca-certificates curl gnupg git
```
```
sudo install -m 0755 -d /etc/apt/keyrings
```
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
```
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
```
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt update -y && sudo apt upgrade -y
```
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```



### Go
```
ver="1.21.11"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```

### Gereklilikler
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip pkg-config libssl-dev -y
```
#### Rust kuralım
Not: 1 seçelim
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source ~/.profile
```
```
source ~/.cargo/env
```

### EigenLayer

```
git clone https://github.com/Layr-Labs/eigenlayer-cli.git
```
```
cd eigenlayer-cli
```
```
mkdir -p build
```
```
go build -o build/eigenlayer cmd/eigenlayer/main.go
```
```
cd
sudo cp eigenlayer-cli/build/eigenlayer /usr/local/bin/
```

### Key oluşturma
NOT: şifre sayı buyuk harf ve sayı içermeli.Çıkan tum çıktıların yedeğini alıp kaydedin.
```
eigenlayer operator keys create --key-type ecdsa user
```
```
eigenlayer operator keys create --key-type bls user
```

### Keyleri listelemek isterseniz

```
eigenlayer operator keys list
```



### Operator kayıt
```
eigenlayer operator config create
```
Not: sıralama kayabilir.ben ss bırakıyorum anlarsınız

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/251ac3a1-7cf5-4afd-af9b-08b82003a360)


- y diyelim.

- operator adresi ilk işlemdeki cıktıdaki Ethereum Address adresi.

- yukarıda girdiğiniz adresi girin yine

- holesky rpc lazım ücretsiz mesela bu https://ethereum-holesky-rpc.publicnode.com
- `ecdsa key` dosya yolu : /root/.eigenlayer/operator_keys/user.ecdsa.key.json

- `bls key` dosya yolu : /root/.eigenlayer/operator_keys/user.bls.key.json

- holesky seçiyoruz.





### githubumuza geliyoruz...

- kendi isimimizde veya herhangi bir isimde repo olusturun.
- add file diyelim ve metadata.json olarak isim verip boş olarak kaydedelim.
- daha sonra yine add file kısmındna upload deyip orjinali png olan bir logo yükleyelim ama harbi png olacak öyle jpg uzantısını png çevirmeyin yemiyo :D
- resmi yüklediniz.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/a1d70d40-dd43-4bd2-8bab-486f690acf7c)

* bulunduğunuz sayfanın linkinin sonuna gelin. sonuna şunu ekleyip enterlayın. `?raw=true`

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b4e6e365-8378-4601-8a92-1f2612459303)

* artık bele görunecek link..

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9d2ef66e-9f75-4b2c-abc0-eb0070120550)

* ekrandada böle logonuz gorunecek.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/2640a771-3c66-4969-81ed-00de5d5f7246)

* tamamdır artık bu linki kullanabilirsiniz.

- evet resimide ayarladık şimdi olusturduğumuz metadata.json dosyasını düzenleyelim kalem işaretine tıklayıp
- altakodu yapıstırıp bi güzel gerekli olanalrı yazalım. sonra comiit deyip kaydedin.
```
{
  "name": "",
  "website": "",
  "description": "",
  "logo": "",
  "twitter": ""
}
```

* AŞAĞIDAKİ ANLAMANIZ AÇISINDAN SADECE ÖRNEKTİR. ÖRDEKTİR :)
```
{
  "name": "üfürükçü",
  "website": "https://github.com/hebelehübele",
  "description": "Ayrıntılar",
  "logo": "https://raw.githubusercontent.com/molla202/molla202/main/bilaloğlan.png",
  "twitter": "https://twitter.com/papuayeniginekınasıalcam"
}
```


### operator dosyasını düzenleyelim...
```
nano operator.yaml
```

- `metadata_url` : `metadata.json` yüklemiştik githuba o dosyaya geldiğimizde sağ üst kısımda raw yazar tıklarsanız linkini kopyalar buraya onu yapıstırın...


- ctrl xy enter...




### register(kayıt)

- en yukarıda key olusturmustuk 2 kod vardı onalrın ilkinin çıktısında private key var. onu metamuska ekleyin. zor olacak ama holoski faucet bulun... sona işlem için aşağıdaki kodu girin...loglar biraz akacak biticek bekleyin...
```
eigenlayer operator register operator.yaml
```


### Stake

https://testnet.ankr.com/staking/stake/ethereum/

- holesky eth yi stake adip ankreth alalım

- şimdi stake edelim https://holesky.eigenlayer.xyz/ adresine gidelim



### Aligned dosyaları çekelim
```
cd
git clone https://github.com/yetanotherco/aligned_layer.git
```
```
cd aligned_layer
```
```
make install_foundry
```
```
foundryup
```
```
make build_operator
```
Not: aşağıdaki kodda gerekli yerleri yazalım aldığımız keyleri vs resimde örnek bırakıyorum. gasptan hatırladığınız demi :D
```
nano /root/aligned_layer/config-files/config-operator.yaml
```
Not: işin kolayı yukardakini yazınca ctrl k ile tüm satırları sil alttakini düzenle düzenlencek yerler yazıyor yapıstır ctrl xy enterla kaydet çık
```
# Common variables for all the services
# 'production' only prints info and above. 'development' also prints debug
environment: "production"
aligned_layer_deployment_config_file_path: "./contracts/script/output/holesky/alignedlayer_deployment_output.json"
eigen_layer_deployment_config_file_path: "./contracts/script/output/holesky/eigenlayer_deployment_output.json"
eth_rpc_url: "https://ethereum-holesky-rpc.publicnode.com"
eth_ws_url: "wss://ethereum-holesky-rpc.publicnode.com"
eigen_metrics_ip_port_address: "localhost:9090"

## ECDSA Configurations
ecdsa:
  private_key_store_path: "/root/.eigenlayer/operator_keys/user.ecdsa.key.json"
  private_key_store_password: "cüzdan şifreni yaz"

## BLS Configurations
bls:
  private_key_store_path: "/root/.eigenlayer/operator_keys/user.bls.key.json"
  private_key_store_password: "cüzdan şifreni yaz"

## Operator Configurations
operator:
  aggregator_rpc_server_ip_port_address: aggregator.alignedlayer.com:8090
  address: "eigende olusturduğumuz cüzdanın adresi yaz"
  earnings_receiver_address: "eigende olusturduğumuz cüzdanın adresi yaz" #Can be the same as the operator.
  delegation_approver_address: "0x0000000000000000000000000000000000000000"
  staker_opt_out_window_blocks: 0
  metadata_url: "metadata.json dosyanızın linki"
  enable_metrics: true
  metrics_ip_port_address: localhost:9092
  max_batch_size: 268435456 # 256 MiB
```

```
sudo tee /etc/systemd/system/alignedavsd.service > /dev/null <<EOF
[Unit]
Description=alignedavsd node
After=network-online.target

[Service]
User=$USER
WorkingDirectory=/root/aligned_layer
ExecStart=/root/aligned_layer/operator/build/aligned-operator start --config /root/aligned_layer/config-files/config-operator.yaml

Restart=always
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable alignedavsd
sudo systemctl restart alignedavsd
```
### Log
```
sudo journalctl -u alignedavsd -fo cat
```
### Dockerla kurmak isterseniz opsiyonel kurulum
```
cd /root/aligned_layer/operator/docker
```
```
cp .env.example .env
```
```
nano .env
```
Not: içini bele yapalım kople silerek yapıstırabilirsiniz ctrl xy enterla kaydet çık
```
ECDSA_KEY_FILE_HOST=/root/.eigenlayer/operator_keys/user.ecdsa.key.json
BLS_KEY_FILE_HOST=/root/.eigenlayer/operator_keys/user.bls.key.json
OPERATOR_CONFIG_FILE_HOST=/root/aligned_layer/config-files/config-operator.docker.yaml
```
```
nano /root/aligned_layer/config-files/config-operator.docker.yaml
```
NOt: sadece aşağıdaki yerlerdekinleri değiştiriceksiniz. başka şeyleri ellemiyoruz aman dosya yolu yoktu falan hayır ellemiyoruz mubarek.
neden dockerın kendi içinde kaydedeceği yer bak bi üstte zaten biz ona bizdeki yeri söyledik o ordan alıcak dockerın içinde yere kaydedicek mantık bu.
```
private_key_store_password: "cüzdan şifreni yaz"
private_key_store_password: "cüzdan şifreni yaz"
address: "eigende olusturduğumuz cüzdanın adresi yaz"
earnings_receiver_address: "eigende olusturduğumuz cüzdanın adresi yaz" #Can be the same as the operator.
metadata_url: "metadata.json dosyanızın linki"
```
### Başlatalım
```
docker compose up -d
```
### Loglara bakalım
```
docker logs -f --tail 100 operator
```










