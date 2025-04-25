
Upgrade Summary:
Upgrade Height: 10776000
Date & Time:  22nd November 2024, 19:00:00 UTC
```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.2.4/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.3-to-2.2.4/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.2.3-to-2.2.4/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.4/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/2.2.4/bin/
```
### Orch update v2.0.18
```
cd $HOME
systemctl stop orchestrator.service
wget https://github.com/router-protocol/router-orchestrator-binary-release/raw/refs/heads/main/linux/router-orchestrator.tar.gz
tar -xzvf router-orchestrator.tar.gz
chmod +x router-orchestrator
mv router-orchestrator $(which router-orchestrator)
```
```
router-orchestrator version
```
```
systemctl daemon-reload && systemctl restart orchestrator.service && journalctl -u orchestrator.service -fo cat
```
