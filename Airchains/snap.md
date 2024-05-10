
```
sudo apt install liblz4-tool

systemctl stop junctiond

cp $HOME/.junction/data/priv_validator_state.json $HOME/.junction/priv_validator_state.json.backup

cp $HOME/.junction/config/priv_validator_key.json $HOME/.junction/priv_validator_key.json.backup

junctiond tendermint unsafe-reset-all --home $HOME/.junction --keep-addr-book

curl -L http://37.120.189.81/airchain_testnet/air_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.junction

mv $HOME/.junction/priv_validator_state.json.backup $HOME/.junction/data/priv_validator_state.json

sudo systemctl daemon-reload && sudo systemctl start junctiond && sudo journalctl -u junctiond -f --no-hostname -o cat
```
