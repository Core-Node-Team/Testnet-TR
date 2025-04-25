### 🚧Snap
```
sudo apt install liblz4-tool

systemctl stop evmosd

cp $HOME/.evmosd/data/priv_validator_state.json $HOME/.evmosd/priv_validator_state.json.backup

cp $HOME/.evmosd/config/priv_validator_key.json $HOME/.evmosd/priv_validator_key.json.backup

evmosd tendermint unsafe-reset-all --home $HOME/.evmosd --keep-addr-book

curl -L http://37.120.189.81/0g_testnet/0g_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.evmosd

mv $HOME/.evmosd/priv_validator_state.json.backup $HOME/.evmosd/data/priv_validator_state.json
```
