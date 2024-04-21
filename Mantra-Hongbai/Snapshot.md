# Snapshot

```bash
sudo apt install liblz4-tool

systemctl stop mantrachaind

cp $HOME/.mantrachain/data/priv_validator_state.json $HOME/.mantrachain/priv_validator_state.json.backup

mantrachaind tendermint unsafe-reset-all --home $HOME/.mantrachain --keep-addr-book

curl -L http://37.120.189.81/warden_testnet/warden_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.mantrachain

mv $HOME/.mantrachain/priv_validator_state.json.backup $HOME/.mantrachain/data/priv_validator_state.json

sudo systemctl restart mantrachaind && sudo journalctl -u mantrachaind -fo cat
```
### Bizi takip edin [Twitter](https://twitter.com/corenodeHQ)
### Topluluğumuza katılın [Telegram](https://t.me/corenodechat)
