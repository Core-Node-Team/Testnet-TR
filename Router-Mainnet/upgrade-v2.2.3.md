
Upgrade Summary:
Upgrade Height: 10133000
Date & Time:  21 October 2024, 05:00:22 UTC
```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.2.2/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.2-to-2.2.3/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.2.2-to-2.2.3/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.3/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/2.2.3/bin/
```
