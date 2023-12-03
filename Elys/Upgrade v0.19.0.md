Upgrade height: 4225000

### Add Peer
```
PEERS="86987eeff225699e67a6543de3622b8a986cce28@91.183.62.162:26656,61284a4d71cd3a33771640b42f40b2afda389a1e@78.110.161.69:26656,ae22b82b1dc34fa0b1a64854168692310f562136@147.135.104.10:26656,cdf9ae8529aa00e6e6703b28f3dcfdd37e07b27c@147.135.9.107:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.elys/config/config.toml
sudo systemctl restart elysd && sudo journalctl -u elysd -fo cat
```
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
