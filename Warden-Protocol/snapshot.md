# Snapshot

```bash
sudo apt install liblz4-tool

systemctl stop wardend

cp $HOME/.warden/data/priv_validator_state.json $HOME/.warden/priv_validator_state.json.backup

wardend tendermint unsafe-reset-all --home $HOME/.warden --keep-addr-book

curl -L http://37.120.189.81/hedge_testnet/hedge_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.hedge

mv $HOME/.warden/priv_validator_state.json.backup $HOME/.warden/data/priv_validator_state.json

sudo systemctl restart wardend && sudo journalctl -u wardend -fo cat
```
### Bizi takip edin [Twitter](https://twitter.com/corenodeHQ)
### Topluluğumuza katılın [Telegram](https://t.me/corenodechat)
