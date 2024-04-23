<h1 align="center"> Mangata </h1>

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/7c0f2149-1b4f-4552-a993-e5d4bb2877ec)

## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [Mangata Resmi Websitesi](https://mangata.finance/)
 * [Mangata Resmi Twitter](https://twitter.com/MangataFinance)
 * [Mangata Resmi Discord]()
 * [Mangata Dökümantasyon](https://docs.mangata.finance/welcome/)
 


### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	2+ vcpu|
| ✔️RAM	| 4+ GB |
| ✔️Storage	| 100+ GB SSD |
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
sudo apt-get install ca-certificates curl gnupg
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
ver="1.21.6"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
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

- y diyelim.

- operator adresi ilk işlemdeki cıktıdaki Ethereum Address adresi.

- yukarıda girdiğiniz adresi girin yine

- goerli rpc lazım ücretsiz https://app.infura.io temin ediyoruz hesap oluşturup. YADA `https://rpc.ankr.com/eth_goerli` bunu kullanmayı deneyin.

- `ecdsa key` dosya yolu : /root/.eigenlayer/operator_keys/user.ecdsa.key.json

- `bls key` dosya yolu : /root/.eigenlayer/operator_keys/user.bls.key.json

- goerli seçiyoruz.





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

- `el_slasher_address`: 0x3865B5F5297f86c5295c7f818BAD1fA5286b8Be6

- `bls_public_key_compendium_address`: 0xc81d3963087Fe09316cd1E032457989C7aC91b19

- ctrl xy enter...




### register(kayıt)

- en yukarıda key olusturmustuk 2 kod vardı onalrın ilkinin çıktısında private key var. onu metamuska ekleyin. zor olacak ama goerli faucet bulun... sona işlem için aşağıdaki kodu girin...loglar biraz akacak biticek bekleyin...
```
eigenlayer operator register operator.yaml
```


### Mangata 

- reth ve steth lazım stake için https://app.uniswap.org/swap adresine gidelim private key import ettiğimiz mm bağlayalım eth yi reth ve steth çeviricez cüzzi miktarda..

- üstenn eth seçtik alttan tıklayın ve aşağıdaki contract adreslerini girince görürsünüz..
```
0x178e141a0e3b34152f73ff610437a7bf9b83267a
```
```
0x1643e812ae58766192cf7d2cf9567df2c37e9b7f
```
- şimdi stake edelim https://goerli.eigenlayer.xyz adresine gidelim

Lido Staked Ether
Rocket Pool Ether

- yukarıda yazan isimlerdeki poolara stake edelim.




### Dosyaları çekelim
```
git clone https://github.com/mangata-finance/avs-operator-setup.git
```
```
cd avs-operator-setup
```
```
chmod +x run.sh
```
```
nano .env
```


ETH_RPC_URL= infuradan alınan http linki

ETH_WS_URL= infuradan alınan wss linki

ECDSA_KEY_FILE_HOST=/root/.eigenlayer/operator_keys/user.ecdsa.key.json

BLS_KEY_FILE_HOST=/root/.eigenlayer/operator_keys/user.bls.key.json

ECDSA_KEY_PASSWORD=şifre oluşturmuştuk yazıverin gari

BLS_KEY_PASSWORD=şifre oluşturmuştuk yazıverin gari

- ctrl xy enter.

```
./run.sh opt-in
```
```
docker compose up -d
```
```
docker ps
```
- çıkan listede en başında doker id yazar sayılı falan onu yazıcaksınız aşağıdaki dosker-id kısmına...
```
docker logs -f --tail 100 docker-id
```
YADA
```
docker logs -f --tail 100 mangata-finalizer-node
```

- Loglar biraz aksın sonra resmini alın avs-operators kanalına atın discorda rol vericekler.Mangatarians diye ve bot var aynı kanalda tıklayarak node runner rolude alın. discord linki sayfanın basındakilinklerde var.


#### Operator durumu kontrol
```
eigenlayer operator status operator.yaml
```
#### daha sonrası için bir değişiklik olur ise metadatayı değiştirirseniz güncellemeniz gerekir aşağıdaki kod ile
```
eigenlayer operator update operator.yaml
```

### komple silmek

```
cd avs-operator-setup
```
```
docker compose down -v
```
```
cd 
rm -rf avs-operator-setup
rm -rf eigenlayer-cli
```
