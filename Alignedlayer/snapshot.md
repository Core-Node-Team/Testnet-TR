```
sudo apt install liblz4-tool

systemctl stop alignedlayerd

cp $HOME/.alignedlayer/data/priv_validator_state.json $HOME/.alignedlayer/priv_validator_state.json.backup

alignedlayerd tendermint unsafe-reset-all --home $HOME/.alignedlayer --keep-addr-book

curl -L http://37.120.189.81/alignedlayer_testnet/alignedlayer_snap.tar | tar -xf - -C $HOME/.alignedlayer/data/

mv $HOME/.alignedlayer/priv_validator_state.json.backup $HOME/.alignedlayer/data/priv_validator_state.json
```
