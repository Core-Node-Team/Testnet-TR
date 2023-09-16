```
sudo apt install liblz4-tool

systemctl stop cascadiad

cp $HOME/.cascadiad/data/priv_validator_state.json $HOME/.cascadiad/priv_validator_state.json.backup

cascadiad tendermint unsafe-reset-all --home $HOME/.cascadiad --keep-addr-book 

curl -L http://128.140.4.67/CoreNode_Chain_Services/cascadia_snapshot.tar.lz4 | tar -I lz4 -xf - -C $HOME/.cascadiad/data

mv $HOME/.cascadiad/priv_validator_state.json.backup $HOME/.cascadiad/data/priv_validator_state.json 

sudo systemctl start cascadiad && sudo journalctl -u cascadiad -fo cat
```
