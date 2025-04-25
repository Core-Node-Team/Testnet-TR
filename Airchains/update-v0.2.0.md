### Manuel
Güncelleme Block: 2383911


### Cosmovisor
```
cd $HOME
wget -O junctiond https://github.com/airchains-network/junction/releases/download/v0.2.0/junctiond-linux-amd64
chmod +x junctiond
mkdir -p $HOME/.junction/cosmovisor/upgrades/jip-2/bin
sudo mv $HOME/junctiond $HOME/.junction/cosmovisor/upgrades/jip-2/bin
```



```
cd $HOME
wget -O junctiond https://github.com/airchains-network/junction/releases/download/v0.2.0/junctiond-linux-amd64
chmod +x junctiond
sudo mv $HOME/junctiond $(which junctiond)
```
```
sudo systemctl restart junctiond && sudo journalctl -u junctiond -f
```
