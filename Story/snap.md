
```
sudo apt install liblz4-tool
```
```
systemctl stop story story-geth
```
```
cp $HOME/.story/story/data/priv_validator_state.json $HOME/.story/priv_validator_state.json.backup
```
```
rm -rf $HOME/.story/story/data
rm -rf $HOME/.story/geth/aeneid/geth/chaindata
```
```
curl -L https://snapshot.corenodehq.xyz/story-test/story_testnet_cos_snap.lz4 | tar -I lz4 -xf - -C $HOME/.story/story
curl -L https://snapshot.corenodehq.xyz/story-test/story_testnet_geth_snap.lz4 | tar -I lz4 -xf - -C $HOME/.story/geth/aeneid/geth
```
```
mv $HOME/.story/priv_validator_state.json.backup $HOME/.story/story/data/priv_validator_state.json
```
```
sudo systemctl restart story-geth
sleep 5
sudo systemctl restart story
```
```
sudo journalctl -u story -u story-geth -f -o cat
```
