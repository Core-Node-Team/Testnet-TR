### v0.1.7 cosmovisor upgrade
```
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.7/cascadiad -o cascadiad
sudo chmod u+x cascadiad

mkdir -p $HOME/.cascadiad/cosmovisor/upgrades/v0.1.7/bin
mv cascadiad $HOME/.cascadiad/cosmovisor/upgrades/v0.1.7/bin/

```

## setup
```
cd $HOME
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.6/cascadiad -o cascadiad
sudo chmod u+x cascadiad
```

# Prepare binaries for Cosmovisor
```
mkdir -p $HOME/.cascadiad/cosmovisor/genesis/bin
mv cascadiad $HOME/.cascadiad/cosmovisor/genesis/bin/
```
------------------------
Notice: Skip this, if it gives an error you can use it. Problem log v0.1.6 
```
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.6/cascadiad -o cascadiad
sudo chmod u+x cascadiad

mkdir -p $HOME/.cascadiad/cosmovisor/upgrades/v0.1.6/bin
mv cascadiad $HOME/.cascadiad/cosmovisor/upgrades/v0.1.6/bin/
```
-----------
# set vars
Not: write moniker and wallet name
```
echo "export WALLET="wallet"" >> $HOME/.bash_profile
echo "export MONIKER="test"" >> $HOME/.bash_profile
echo "export CASCADIA_CHAIN_ID="cascadia_6102-1"" >> $HOME/.bash_profile
echo "export CASCADIA_PORT="40"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
# Create application symlinks
```
sudo ln -s $HOME/.cascadiad/cosmovisor/genesis $HOME/.cascadiad/cosmovisor/current -f
sudo ln -s $HOME/.cascadiad/cosmovisor/current/bin/cascadiad /usr/local/bin/cascadiad -f
```

# Download and install Cosmovisor (Install Cosmovisor and create a service)
```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0
```
# Create service
```
sudo tee /etc/systemd/system/cascadiad.service > /dev/null << EOF
[Unit]
Description=cascadia node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.cascadiad"
Environment="DAEMON_NAME=cascadiad"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.cascadiad/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
```

# config and init app
```
cascadiad config node tcp://localhost:${CASCADIA_PORT}657
cascadiad config keyring-backend os
cascadiad config chain-id cascadia_6102-1
cascadiad init $MONIKER --chain-id cascadia_6102-1
```
# download genesis and addrbook
```
wget -O $HOME/.cascadiad/config/genesis.json https://testnet-files.itrocket.net/cascadia/genesis.json
wget -O $HOME/.cascadiad/config/addrbook.json https://testnet-files.itrocket.net/cascadia/addrbook.json
```
# set seeds and peers
```
SEEDS="42c4a78f39935df1c20b51c4b0d0a21db8f01c88@cascadia-testnet-seed.itrocket.net:40656"
PEERS="c6e3921222655345d8296353994e917f13a1b4a1@cascadia-testnet-peer.itrocket.net:40656,f673bf30ddf117dd6064bdee79aec088ffb41856@167.235.7.34:33656,c9256e4f42a23bbdc9ea79805f497a1923a4beac@65.108.230.113:17096,46b554c4cddbde4adb7b10e7b6c66e46845ffc33@135.181.116.109:22796,9a6b8d5350908b430500a5916ebd155c3da0701b@185.135.137.145:26656,386e7cb835f42335439d369e5753c323545bdaac@207.180.241.227:26656,1d61222b7b8e180aacebfd57fbd2d8ab95ebdc4c@65.109.93.152:35656,16b622800dedb46f764eb052bd9596b762a05bfd@49.12.84.248:15656,096c0d1ea94f205c62c4b282f4d4ff5ae97e28de@78.27.236.220:656,565a1e397134e50a486e25575c6b3892cb8d4fee@65.108.46.100:40656,9e44042d58362be4899b64f9d90d9cf7503af1bb@82.208.22.201:26656,cd8db9754f4468021ee9aec018861763e29acf35@65.109.92.60:26656,bb6ad4cc558508e98d3937da02531eabafa681bd@65.21.95.46:56105,d5ba7a2288ed176ae2e73d9ae3c0edffec3caed5@65.21.134.202:16756,9b344d3bfa3444b53cebdd53cea8960e37216d5d@159.69.72.220:39656,dfdb5a1dba90c71aab590745dc784cc28edd0f6f@193.187.129.171:26656,e2d502525de6d44b1faf85ee92713b04b0a11048@173.212.247.15:26656,60cfcdd553333e2104bdde401baa523c848c9649@185.16.38.180:26656,e657618a9413d7414cf86ddaf4dd2d9947c7703b@185.135.137.20:26656,a50b21c31c98fbc62726a3a09177f8a60d5d6f0a@149.102.131.208:26656,2f0f98db7eb4addb2895085962c70f1fde29f80d@217.76.50.195:26656,4b7685d3a144546df964ba53a7230e534c4c03a2@95.217.115.184:30021,bc6cd5d772dd3125142b33a088bbd48c3eb391ba@167.235.39.5:56656,e85f72848ba9586c6704445d1118fb35e2ca5804@65.109.84.33:38656,8d5ba44f84fd5d94345fe52609d4d6e43344f34b@207.180.222.33:26656,4fba89759900b71c6a7011c2869a468b5922db68@85.173.112.154:22656,a2b41b91da1a6bb58a2dbf94daa8df088e591791@46.4.226.215:26656,11f2e6b2ce7845d738262d160be5a1249b0e1ae9@31.220.77.238:26656,fcfaab619a8961c7cbd0ef86eb4abb2864002023@45.67.217.3:26656,a656b8f16451128ce005ed0092c307b5d3bf7460@5.9.122.49:18656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.cascadiad/config/config.toml

# set custom ports in app.toml
sed -i.bak -e "s%:1317%:${CASCADIA_PORT}317%g;
s%:8080%:${CASCADIA_PORT}080%g;
s%:9090%:${CASCADIA_PORT}090%g;
s%:9091%:${CASCADIA_PORT}091%g;
s%:8545%:${CASCADIA_PORT}545%g;
s%:8546%:${CASCADIA_PORT}546%g;
s%:6065%:${CASCADIA_PORT}065%g" $HOME/.cascadiad/config/app.toml

# set custom ports in config.toml file
sed -i.bak -e "s%:26658%:${CASCADIA_PORT}658%g;
s%:26657%:${CASCADIA_PORT}657%g;
s%:6060%:${CASCADIA_PORT}060%g;
s%:26656%:${CASCADIA_PORT}656%g;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${CASCADIA_PORT}656\"%;
s%:26660%:${CASCADIA_PORT}660%g" $HOME/.cascadiad/config/config.toml

# config pruning
sed -i -e "s/^pruning *=.*/pruning = \"nothing\"/" $HOME/.cascadiad/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.cascadiad/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"50\"/" $HOME/.cascadiad/config/app.toml

# set minimum gas price, enable prometheus and disable indexing
sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.025aCC"/g' $HOME/.cascadiad/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.cascadiad/config/config.toml
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.cascadiad/config/config.toml
```
# reset and download snapshot
```
cascadiad tendermint unsafe-reset-all --home $HOME/.cascadiad
if curl -s --head curl https://testnet-files.itrocket.net/cascadia/snap_cascadia.tar.lz4 | head -n 1 | grep "200" > /dev/null; then
  curl https://testnet-files.itrocket.net/cascadia/snap_cascadia.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.cascadiad
    else
  echo no have snap
fi
```
# enable and start service
```
sudo systemctl daemon-reload
sudo systemctl enable cascadiad
sudo systemctl restart cascadiad && sudo journalctl -u cascadiad -fo cat
```
