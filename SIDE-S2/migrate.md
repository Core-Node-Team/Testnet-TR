
```
cd $HOME/side && git pull
git checkout v0.8.0
make install
sided config chain-id S2-testnet-1
wget -O $HOME/.side/config/genesis.json "https://raw.githubusercontent.com/molla202/Side/main/genesis.json"
peers="43cb99189637d1e35b8f11c1580cff305157c94b@54.249.68.205:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.side/config/config.toml
seeds="582dedd866dd77f25ac0575118cf32df1ee50f98@202.182.119.24:26656"
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:${SIDE_PORT}656\"/" $HOME/.side/config/config.toml
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.side/config/config.toml
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" ~/.side/config/config.toml
sided tendermint unsafe-reset-all --home /root/.side
wget -O $HOME/.side/config/addrbook.json "https://raw.githubusercontent.com/molla202/Side/main/addrbook.json"
systemctl restart sided && journalctl -u sided -f -o cat
```
