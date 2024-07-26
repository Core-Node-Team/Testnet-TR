# Snap
```
sudo apt install liblz4-tool

systemctl stop routerd

cp $HOME/.routerd/data/priv_validator_state.json $HOME/.routerd/priv_validator_state.json.backup

routerd tendermint unsafe-reset-all --home $HOME/.routerd --keep-addr-book

curl -L http://37.120.189.81/router_mainnet/router_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.routerd

mv $HOME/.routerd/priv_validator_state.json.backup $HOME/.routerd/data/priv_validator_state.json

sudo systemctl restart routerd && sudo journalctl -u routerd -fo cat
```
