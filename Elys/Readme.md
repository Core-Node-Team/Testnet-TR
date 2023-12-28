![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/9d9b2b64-736b-4921-aa50-ae87f6d8d34b)


### OTO SETUP

```
curl -sSL -o elys_kurulum.sh https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/elys_kurulum.sh && chmod +x elys_kurulum.sh && bash ./elys_kurulum.sh
```
---------------------
### V0.24.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.24.0.sh | bash
```
### V0.20.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.20.0.sh | bash
```
### V0.19.0 UPGRADE Block:4225000
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.19.0.sh | bash
```
### V0.18.0 UPGRADE
```
curl -sSL https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Elys/upgrade-v0.18.0.sh | bash
```
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
