



Upgrade Summary:
Upgrade Height: 12591458
Date & Time:  26th February 2025, 18:52:02 UTC
```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.2.6/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.5-to-2.2.6/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.2.5-to-2.2.6/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.6/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/2.2.6/bin/
```
