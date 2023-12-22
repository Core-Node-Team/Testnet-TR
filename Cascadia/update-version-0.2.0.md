
### Manual Upgrade
```
sudo systemctl stop cascadiad
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.2.0/cascadiad -o cascadiad
chmod +x cascadiad
sudo mv cascadiad $(which cascadiad)
sudo systemctl start cascadiad
sudo journalctl -u cascadiad -f --no-hostname -o cat
```


### Güncelleme 
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.2.0.sh | bash
```

### cosmovisor upgrade
```
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.2.0/cascadiad -o cascadiad
sudo chmod u+x cascadiad

mkdir -p $HOME/.cascadiad/cosmovisor/upgrades/v0.2.0/bin
mv cascadiad $HOME/.cascadiad/cosmovisor/upgrades/v0.2.0/bin/

```
