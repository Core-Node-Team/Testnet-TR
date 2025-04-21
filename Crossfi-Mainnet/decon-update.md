```
cd $HOME
rm -rf bin
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.4.0/crossfi-node_0.4.0_linux_amd64.tar.gz
tar -xf crossfi-node_0.4.0_linux_amd64.tar.gz
rm crossfi-node_0.4.0_linux_amd64.tar.gz
mkdir -p $HOME/.crossfid/cosmovisor/upgrades/decon/bin
sudo mv $HOME/bin/crossfid $HOME/.crossfid/cosmovisor/upgrades/decon/bin/crossfid
```
