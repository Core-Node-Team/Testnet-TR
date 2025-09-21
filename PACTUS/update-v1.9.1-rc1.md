```
cd
systemctl stop pactusd
wget https://github.com/pactus-project/pactus/releases/download/v1.9.1-rc1/pactus-cli_1.9.1-rc1_linux_amd64.tar.gz
tar -xvf pactus-cli_1.9.1-rc1_linux_amd64.tar.gz
cp -r pactus-cli_1.9.1-rc1/* pac/
systemctl restart pactusd
```
```
journalctl -u pactusd -fo cat
```
