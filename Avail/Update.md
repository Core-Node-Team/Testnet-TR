# <h1 align="center">Avail's Clash of Nodes Testnet Update</h1>

![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

Not: şuan için güncelleme gerekli yazmamışlar bi kaç düzeltme ve senkron hızı artırmışlar...

```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```
```
rm -rf data-avail
```
```
wget https://github.com/availproject/avail/releases/download/v1.8.0.2/amd64-ubuntu-2204-data-avail.tar.gz
```
```
tar xvzf amd64-ubuntu-2204-data-avail.tar.gz
```
```
mv amd64-ubuntu-2204-data-avail data-avail
```
```
sudo systemctl restart availd.service
```
