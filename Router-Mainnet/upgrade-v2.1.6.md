```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.1.6/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.1.1-nitro-to-2.1.6/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.1.1-nitro-to-2.1.6/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/v2.1.6/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/v2.1.6/bin/
```
