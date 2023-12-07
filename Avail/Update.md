# <h1 align="center">Avail's Clash of Nodes Testnet Update</h1>

![image](https://github.com/molla202/Avail/assets/91562185/a6461113-7737-40a0-9d2a-3049a7097663)

Not: şuan için güncelleme gerekli yazmamışlar bi kaç düzeltme ve senkron hızı artırmışlar...
### Ubuntu 22
```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```

```
wget https://github.com/availproject/avail/releases/download/v1.8.0.4/x86_64-ubuntu-2204-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2204-data-avail.tar.gz
```

```
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```
--------------------
### Ubuntu 20 
```
sudo systemctl stop availd.service
```
```
cd /root/avail-node/
```
rm - rf 
```
wget https://github.com/availproject/avail/releases/download/v1.8.0.4/x86_64-ubuntu-2004-data-avail.tar.gz
```
```
tar xvzf x86_64-ubuntu-2004-data-avail.tar.gz
```

```
sudo systemctl restart availd.service
```
```
journalctl -f -u availd.service
```

