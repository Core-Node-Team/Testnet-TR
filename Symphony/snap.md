
```
sudo apt install liblz4-tool

systemctl stop symphonyd

cp $HOME/.symphonyd/data/priv_validator_state.json $HOME/.symphonyd/priv_validator_state.json.backup

symphonyd tendermint unsafe-reset-all --home $HOME/.symphonyd --keep-addr-book

curl -L http://37.120.189.81/sym_testnet/sym_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.symphonyd

mv $HOME/.symphonyd/priv_validator_state.json.backup $HOME/.symphonyd/data/priv_validator_state.json

sudo systemctl restart symphonyd && sudo journalctl -u symphonyd -fo cat
```
