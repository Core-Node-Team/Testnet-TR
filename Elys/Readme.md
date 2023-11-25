![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/6b8fb6e5-57f0-46c8-8dfd-6912d22fd6ce)

### OTO SETUP

```
curl -sSL -o elys_kurulum.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/elys_kurulum.sh && chmod +x elys_kurulum.sh && bash ./elys_kurulum.sh
```
---------------------
### V0.17.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.17.0.sh | bash
```
### V0.16.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.16.0.sh | bash
```
### V0.15.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.15.0.sh | bash
```
### V0.14.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.14.0.sh | bash
```
AND
### Change block time
```
sed -i -e "s/^timeout_commit *=.*/timeout_commit = \"3s\"/" $HOME/.elys/config/config.toml
sudo systemctl restart elysd && sudo journalctl -u elysd -f -o cat
```
-----------
### V0.13.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.13.0.sh | bash
```
