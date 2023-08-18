## sorulara önce 1 sona 0 diceniz

## Sunucu Güncellemesi
```
sudo apt-get update -y && sudo apt-get upgrade -y
```
## Gerekli Kütüphaneleri yükleyelim.
```
sudo apt install -y build-essential libssl-dev cmake screen git htop
```
```
wget -c https://pre-alpha-download.opside.network/testnet-auto-install-v3.tar.gz 
```
```
tar -C ./ -xzf testnet-auto-install-v3.tar.gz
```
```
chmod +x -R ./testnet-auto-install-v3
```
## Kuruluma başlayalım.
```
cd ./testnet-auto-install-v3
```
```
./install-ubuntu-1.0.sh
```

/———OPSİDE RESETLEME———-\

———-durdurma komutları v2———-
```
cd
cd testnet-auto-install-v2
opside-chain/stop-all.sh
```
———-durdurma komutları v3———-
```
cd
cd testnet-auto-install-v3
opside-chain/stop-all.sh
```
———- baslatma komutları v2———-
```
cd
testnet-auto-install-v2/opside-chain/start-geth.sh
testnet-auto-install-v2/opside-chain/start-beaconChain.sh
testnet-auto-install-v2/opside-chain/start-validator.sh
```
———- baslatma komutları v3———-
```
cd
testnet-auto-install-v3/opside-chain/start-geth.sh
testnet-auto-install-v3/opside-chain/start-beaconChain.sh
testnet-auto-install-v3/opside-chain/start-validator.sh
```
————Log Kontrol v2———
```
cd
cd testnet-auto-install-v2/
```
not: alttakiler sırayla girilip bakılacak
```
opside-chain/show-geth-log.sh
```
```
opside-chain/show-beaconChain-log.sh
```
```
opside-chain/show-validator-log.sh
```
————Log Kontrol v3———
```
cd
cd testnet-auto-install-v3/
```
not: alttakiler sırayla girilip bakılacak
```
opside-chain/show-geth-log.sh
```
```
opside-chain/show-beaconChain-log.sh
```
```
opside-chain/show-validator-log.sh
```
NOT: control panelinden yapanlar. önce stoplasın biraz beklesin sonra restart yapsın.  KODLARLA yapanlar durdurup biraz beklesin sonra baslatma kodlarını girsin. loglarıda kontrol ediniz bazen baslamayan oluyor adımları tekrarlarsınız


## Port Değiştirme.
Not: içlerinde portlar yazıyor. değiştirmeniz gerekeni değiştirip ctrl+x y enterla kaydedin sonra opsideye reset atın ve portları kontrol edin.
port kontrol
```
sudo lsof -nP -iTCP -sTCP:LISTEN
```
```
nano /root/testnet-auto-install-v3/opside-chain/geth/run.sh
```
```
nano /root/testnet-auto-install-v3/opside-chain/prysm/beaconChain/run.sh
```
```
nano /root/testnet-auto-install-v3/opside-chain/prysm/validator/run.sh
```
