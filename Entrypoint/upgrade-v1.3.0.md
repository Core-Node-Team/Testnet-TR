Block : 680,000

```
sudo systemctl stop entrypointd
cd $HOME
wget -O entrypointd https://github.com/entrypoint-zone/testnets/releases/download/v1.3.0/entrypointd-1.3.0-linux-amd64
chmod +x entrypointd
sudo mv $HOME/entrypointd $(which entrypointd)
sudo systemctl restart entrypointd && sudo journalctl -u entrypointd -fo cat
```
