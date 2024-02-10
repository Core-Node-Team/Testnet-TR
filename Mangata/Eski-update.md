```
cd
cd avs-operator-setup
```
```
docker compose down -v
```


```
cd 
rm -rf eigenlayer-cli
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

### Operator kayıt
```
eigenlayer operator config create
```

- y diyelim.

- operator adresi ilk işlemdeki cıktıdaki Ethereum Address adresi.

- yukarıda girdiğiniz adresi girin yine

- goerli rpc lazım ücretsiz https://app.infura.io temin ediyoruz hesap oluşturup. YADA `https://rpc.ankr.com/eth_goerli` bunu kullanmayı deneyin.

- `ecdsa key` dosya yolu : /root/.eigenlayer/operator_keys/user.ecdsa.key.json

- goerli seçiyoruz.

### operator dosyasını düzenleyelim...
```
nano operator.yaml
```

- `metadata_url` : `metadata.json` yüklemiştik githuba o dosyaya geldiğimizde sağ üst kısımda raw yazar tıklarsanız linkini kopyalar buraya onu yapıstırın...

- el_delegation_manager_address: 0x1b7b8F6b258f95Cf9596EabB9aa18B62940Eb0a8 # burda bu yazıyor olmalı

- ctrl xy enter...




### register(kayıt)

```
cd
eigenlayer operator register operator.yaml
```
```
cd avs-operator-setup
```
```
./run.sh opt-in
```
```
docker compose up -d
```
```
docker logs -f --tail 100 mangata-finalizer-node
```
