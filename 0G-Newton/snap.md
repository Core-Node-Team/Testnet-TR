```
sudo apt install liblz4-tool

systemctl stop 0gchaind

cp $HOME/.0gchain/data/priv_validator_state.json $HOME/.0gchain/priv_validator_state.json.backup

cp $HOME/.0gchain/config/priv_validator_key.json $HOME/.0gchain/priv_validator_key.json.backup

0gchaind tendermint unsafe-reset-all --home $HOME/.0gchain --keep-addr-book

curl -L http://37.120.189.81/0g_testnet/0g_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.0gchain

mv $HOME/.0gchain/priv_validator_state.json.backup $HOME/.0gchain/data/priv_validator_state.json
```
```
sudo systemctl daemon-reload
sudo systemctl restart 0gchaind
sudo journalctl -u 0gchaind.service -f --no-hostname -o cat
```
