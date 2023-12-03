Upgrade height: 4225000

### Manuel upgrade
```
cd $HOME/elys
git fetch --all
git checkout v0.19.0
make build
sudo mv $HOME/elys/build/elysd $(which elysd)
sudo systemctl restart elysd && sudo journalctl -u elysd -fo cat
```
### Oto upgrade

```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.19.0.sh | bash
```

### Cosmovisor Upgrade
```
cd $HOME
rm -rf elys
git clone https://github.com/elys-network/elys.git
cd elys
git checkout v0.19.0
```
```
make build
```
```
mkdir -p $HOME/.elys/cosmovisor/upgrades/v0.19.0/bin
mv build/elysd $HOME/.elys/cosmovisor/upgrades/v0.19.0/bin/
rm -rf build
```
