


<h1 align="center"> ETHstorage </h1>

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/1e1fb499-4b87-4bb1-bc67-741afef78dc7)


## Linkler:
 * [Topluluk kanalımız](https://t.me/corenodechat)
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)
 * [ETHstorage Resmi Websitesi](https://ethstorage.io/#/)
 * [ETHstorage Resmi Twitter](https://x.com/EthStorage)
 * [ETHstorage Dökümantasyon](https://docs.ethstorage.io/storage-provider-guide/tutorials)
 * [ETHstorage Discord](https://discord.gg/bHU3pfX3)


### Sistem Gereksinimleri

| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️CPU |	4 vcpu|
| ✔️RAM	| 8 GB |
| ✔️Storage	| 550+ GB SSD |
| ✔️UBUNTU | 20-22 |





### Form
- Form dolduruyoruz twit atıyoruz. etiketliyerek ve cüzdan adresinide yazıyoruz twite gerrisi taktiri ilahi :D

https://dawme4mo.forms.app/ethstorage-2nd-campaign-application




### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
```

### Docker kurulumu ve gereklilikler.

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
```
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Docker image çekip başlatalım
- yeni bi mm cüzdan olusturup adresini ve private keyini alalım ve altaki kısımlara yazalım.
```
AD=cüzdan adresini yaz
PR=private keyini yaz
```
NOT: alttakini olduğu gibi tekte değiştirmeden.
```
docker run --name es  -d  \
          -v ./es-data:/es-node/es-data \
          -e ES_NODE_STORAGE_MINER=$AD \
          -e ES_NODE_SIGNER_PRIVATE_KEY=$PR \
          -p 9545:9545 \
          -p 9222:9222 \
          -p 30305:30305/udp \
          --entrypoint /es-node/run.sh \
          ghcr.io/ethstorage/es-node:v0.1.15 \
          --l1.rpc https://ethereum-sepolia-rpc.publicnode.com \
          --l1.beacon https://ethereum-sepolia-beacon-api.publicnode.com
```

#### Loglara bakmak için
```
docker logs -f --tail 100 es
```

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/11cc1a5d-722a-4cc5-af68-0db01ecc4906)
