```
sudo apt install liblz4-tool

systemctl stop babylond

cp $HOME/.babylond/data/priv_validator_state.json $HOME/.babylond/priv_validator_state.json.backup

babylond tendermint unsafe-reset-all --home $HOME/.babylond --keep-addr-book

curl -L http://snapshot.corenode.info/babylon_testnet/babylon_snap.tar.lz4 | tar -I lz4 -xf - -C /.babylond/data

mv $HOME/.babylond/priv_validator_state.json.backup $HOME/.babylond/data/priv_validator_state.json

sudo systemctl start babylond && sudo journalctl -u babylond -fo cat
```
