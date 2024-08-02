NOT: genesis dosyası buyuk başlaması zaman alabilir. mutlaka yedekelrinizi manuel olarakta alın.
NOT: hazırlık HAZEN tarafından yapılmıştır. bazı ufak düzeltmeler olmuştur. corenode çalışıyor :D
```
sudo systemctl stop wardend
sudo systemctl disable wardend
```
```
cp $HOME/.warden/config/priv_validator_key.json $HOME/.warden/priv_validator_key.json.backup
cp $HOME/.warden/data/priv_validator_state.json $HOME/.warden/priv_validator_stateydk.json.backup
```
```
wardend tendermint unsafe-reset-all --home $HOME/.warden
```
```
rm -rf /root/.warden/cosmovisor/upgrades/v03-to-v04
rm -rf /root/.warden/cosmovisor/upgrades/v0.4.0
rm -rf /root/.warden/cosmovisor/genesis/bin/wardend
rm -rf $HOME/.warden/config/addrbook.json
rm -rf $HOME/.warden/wasm
```
```
cd $HOME
mkdir -p $HOME/.warden/cosmovisor/genesis/bin
wget https://github.com/warden-protocol/wardenprotocol/releases/download/v0.3.1/wardend_Linux_x86_64.zip
unzip -o wardend_Linux_x86_64.zip
rm -rf wardend_Linux_x86_64.zip
chmod +x wardend
```
```
mv wardend $HOME/.warden/cosmovisor/genesis/bin/
```
```
sudo ln -s $HOME/.warden/cosmovisor/genesis $HOME/.warden/cosmovisor/current -f
sudo ln -s $HOME/.warden/cosmovisor/current/bin/wardend /usr/local/bin/wardend -f
```
```
sudo wget -O /root/genesis.json.tar.xz https://buenavista-genesis.s3.eu-west-1.amazonaws.com/genesis.json.tar.xz && sudo tar -xJf /root/genesis.json.tar.xz -C /root && sudo rm /root/genesis.json.tar.xz /root/genesis.json.tar
```
```
sudo mv /root/genesis.json /root/.warden/config/
```
```
sudo tee /etc/systemd/system/wardend.service > /dev/null << EOF
[Unit]
Description=warden node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.warden"
Environment="DAEMON_NAME=wardend"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.warden/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```
```
PEERS="92ba004ac4bcd5afbd46bc494ec906579d1f5c1d@52.30.124.80:26656,ed5781ea586d802b580fdc3515d75026262f4b9d@54.171.21.98:26656,1eed7f989dee2a7d7cb0f067154dfc72eac09f5c@23.88.5.169:34656, 637077d431f618181597706810a65c826524fd74@5.9.151.56:27356,7d376fd173994fe1ad62b0a96d62634aaa94517a@142.132.194.124:30404,f9e6c035dbb6af84be7c7eb1bb1c29a96ab36bec@65.21.67.40:28656"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.warden/config/config.toml
```
```
wget -O $HOME/.warden/config/addrbook.json "https://raw.githubusercontent.com/hazennetworksolutions/wardenupdatev0.3.1/main/addrbook.json"
```
```
sudo systemctl daemon-reload
sudo systemctl enable wardend
sudo systemctl restart wardend
journalctl -fu wardend -o cat
```
