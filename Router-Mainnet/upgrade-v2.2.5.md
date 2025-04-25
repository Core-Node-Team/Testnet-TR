
Upgrade Summary:
Upgrade Height: 11925000
Date & Time:  22nd January 2025, 07:30:00 UTC
```
cd $HOME
wget https://raw.githubusercontent.com/router-protocol/router-chain-binary-release/v2.2.5/linux/routerd.tar.gz
tar -xzf routerd.tar.gz
chmod +x routerd
rm -f routerd.tar.gz

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.4-to-2.2.5/bin
cp -r routerd $HOME/.routerd/cosmovisor/upgrades/2.2.4-to-2.2.5/bin/

mkdir -p $HOME/.routerd/cosmovisor/upgrades/2.2.5/bin
mv routerd $HOME/.routerd/cosmovisor/upgrades/2.2.5/bin/
```
