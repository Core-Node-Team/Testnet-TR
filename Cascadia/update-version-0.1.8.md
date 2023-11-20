`Upgrade to 0.1.8`

`height: 3,400,000`

### Update block time
```
cd
cd ~/.cascadiad/config
sed -i "s/^timeout_propose =.*/timeout_propose = \"2.7s\"/" config.toml
sed -i "s/^timeout_prevote =.*/timeout_prevote = \"0.9s\"/" config.toml
sed -i "s/^timeout_precommit =.*/timeout_precommit = \"0.9s\"/" config.toml
sed -i "s/^timeout_commit =.*/timeout_commit = \"3.6s\"/" config.toml
sudo systemctl restart cascadiad
```
### Scheduled Auto Update
```
screen -S cascadiad-0.1.8
wget https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/ScheduledUpdate_v0.1.8.sh && chmod +x ScheduledUpdate_v0.1.8.sh && bash ./ScheduledUpdate_v0.1.8.sh
```
CTRL+A+D

### Manual Upgrade
```
sudo systemctl stop cascadiad
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.8/cascadiad -o cascadiad
chmod +x cascadiad
sudo mv cascadiad $(which cascadiad)
sudo systemctl start cascadiad
sudo journalctl -u cascadiad -f --no-hostname -o cat
```

### Oto

### Güncelleme 
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/update-version-0.1.8.sh | bash
```

### cosmovisor upgrade
```
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.8/cascadiad -o cascadiad
sudo chmod u+x cascadiad

mkdir -p $HOME/.cascadiad/cosmovisor/upgrades/v0.1.8/bin
mv cascadiad $HOME/.cascadiad/cosmovisor/upgrades/v0.1.8/bin/

```
