```
systemctl stop elysd
wget -O $(which elysd) http://37.120.189.81/elys_testnet/elysd
chmod +x $(which elysd)
```
OR cosmovisor
```
systemctl stop elysd
wget -O /root/.elys/cosmovisor/upgrades/v0.37.0/bin/elysd http://37.120.189.81/elys_testnet/elysd
chmod +x /root/.elys/cosmovisor/upgrades/v0.37.0/bin/elysd
```
```
rm $HOME/.elys/config/addrbook.json
```
```
SEEDS=""
PEERS="0977dd5475e303c99b66eaacab53c8cc28e49b05@65.108.193.254:38656,0977dd5475e303c99b66eaacab53c8cc28e49b05@elys-testnet-rpc.itrocket.net:38656,0f3ff74800579700d492b3835a3ef66081882eb9@159.69.74.237:22356,40eb6a89b6fb0e3a0282e9d93cc0ebd3fa65fedf@148.251.91.158:22056,cdf9ae8529aa00e6e6703b28f3dcfdd37e07b27c@65.21.116.24:26656,98143b5dca162ba726536d07a6af6500d3e6fe1e@65.108.200.40:38656,8c971e7fed202339dc557c2170a5be125153436a@elys-testnet-rpc.stake-town.com:38656,57c605fa2f7796dd2371ab9ca412bcf9a57d3f71@65.108.106.168:10126,821fa0f7ce74a211c5f5ec93cc6cc301564b92b6@rpc.nodejumper.io:10126,609c64cc50fb4ebbe7cae3347545d3950ea2c018@65.108.195.29:23656,cc9c11f2c95ce2163d35b6cf9471ac9d61b7b9ac@65.108.131.146:26676"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.elys/config/config.toml
```
```
nano $HOME/.elys/config/app.toml
```
Note: change argument.
```
max_header_bytes = 1048576
db_backend = "pebbledb"
timeout_propose = "3s"
timeout_propose_delta = "500ms"
timeout_prevote = "1s"
timeout_prevote_delta = "500ms"
timeout_precommit = "1s"
timeout_precommit_delta = "0ms"
timeout_commit = "3s"
```
```
systemctl stop elysd

cp $HOME/.elys/data/priv_validator_state.json $HOME/.elys/priv_validator_state.json.backup

cp $HOME/.elys/config/priv_validator_key.json $HOME/.elys/priv_validator_key.json.backup

elysd tendermint unsafe-reset-all --home $HOME/.elys --keep-addr-book

curl -L http://37.120.189.81/elys_testnet/elys_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.elys

mv $HOME/.elys/priv_validator_state.json.backup $HOME/.elys/data/priv_validator_state.json
```
```
sudo systemctl daemon-reload
sudo systemctl restart elysd
sudo journalctl -u elysd.service -f --no-hostname -o cat
```
