```
sudo apt install liblz4-tool

systemctl stop quicksilverd

cp $HOME/.quicksilverd/data/priv_validator_state.json $HOME/.quicksilverd/priv_validator_state.json.backup

quicksilverd tendermint unsafe-reset-all --home $HOME/.quicksilverd --keep-addr-book

curl -L http://37.120.189.81/quicksilver_mainnet/quicksilver_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.quicksilverd

mv $HOME/.quicksilverd/priv_validator_state.json.backup $HOME/.quicksilverd/data/priv_validator_state.json

sudo systemctl start quicksilverd && sudo journalctl -u quicksilverd -fo cat
```
