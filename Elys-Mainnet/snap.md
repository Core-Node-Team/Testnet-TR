

<h1 align="center"> 0G

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9d9b2b64-736b-4921-aa50-ae87f6d8d34b)


</h1>


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Discord](https://discord.com/invite/0glabs)<br>





```
sudo systemctl stop elysd
cp $HOME/.elys/data/priv_validator_state.json $HOME/.elys/priv_validator_state.json.backup
rm -rf $HOME/.elys/data
curl http://37.120.189.81/elys_mainnet/elys_snap.lz4 | lz4 -dc - | tar -xf - -C $HOME/.elys
mv $HOME/.elys/priv_validator_state.json.backup $HOME/.elys/data/priv_validator_state.json
sudo systemctl restart elysd && sudo journalctl -u elysd -f
```
