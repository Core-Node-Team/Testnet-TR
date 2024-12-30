### Orch update v2.0.22
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
