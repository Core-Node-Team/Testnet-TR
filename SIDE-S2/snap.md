# Snapshot

```bash
sudo apt install liblz4-tool

systemctl stop sided

cp $HOME/.side/data/priv_validator_state.json $HOME/.side/priv_validator_state.json.backup

sided tendermint unsafe-reset-all --home $HOME/.side --keep-addr-book

curl -L http://37.120.189.81/side_testnet/side_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.side

mv $HOME/.side/priv_validator_state.json.backup $HOME/.side/data/priv_validator_state.json

sudo systemctl restart sided && sudo journalctl -u sided -fo cat
```
### Bizi takip edin [Twitter](https://twitter.com/corenodeHQ)
### Topluluğumuza katılın [Telegram](https://t.me/corenodechat)
