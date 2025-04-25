# Snapshot

```bash
sudo apt install liblz4-tool

systemctl stop hedged

cp $HOME/.hedge/data/priv_validator_state.json $HOME/.hedge/priv_validator_state.json.backup

hedged tendermint unsafe-reset-all --home $HOME/.hedge --keep-addr-book

curl -L http://37.120.189.81/hedge_testnet/hedge_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.hedge

mv $HOME/.hedge/priv_validator_state.json.backup $HOME/.hedge/data/priv_validator_state.json

sudo systemctl restart hedged && sudo journalctl -u hedged -fo cat
```
### Bizi takip edin [Twitter](https://twitter.com/corenodeHQ)
### Topluluğumuza katılın [Telegram](https://t.me/corenodechat)
