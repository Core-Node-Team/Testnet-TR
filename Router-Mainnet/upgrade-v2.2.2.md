```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.2.2/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.1-to-2.2.2/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.2.1-to-2.2.2/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.2/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/2.2.2/bin/
```