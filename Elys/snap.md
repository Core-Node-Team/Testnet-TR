```
sudo apt install liblz4-tool

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
