Upgrade height: 3662000

### Manuel upgrade
```
cd $HOME/elys
git fetch --all
git checkout v0.14.0
make build
sudo mv $HOME/elys/build/elysd $(which elysd)
sudo systemctl restart elysd && sudo journalctl -u elysd -fo cat
```

### Cosmovisor Upgrade
```
cd $HOME
rm -rf elys
git clone https://github.com/elys-network/elys.git
cd elys
git checkout v0.14.0
```
```
make build
```
```
mkdir -p $HOME/.elys/cosmovisor/upgrades/v0.14.0/bin
mv build/elysd $HOME/.elys/cosmovisor/upgrades/v0.14.0/bin/
rm -rf build
```
