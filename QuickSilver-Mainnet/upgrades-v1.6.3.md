# v1.6.3 has been released (block 8722500).

## Manuel
```
cd $HOME
wget -O quicksilverd https://github.com/ingenuity-build/quicksilver/releases/download/v1.6.3/quicksilverd-v1.6.3-amd64
mv quicksilverd-v1.6.3-amd64 quicksilverd
chmod +x quicksilverd
sudo mv $HOME/quicksilverd $(which quicksilverd)
sudo systemctl restart quicksilverd && sudo journalctl -u quicksilverd -f
```
OR
```
cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.6.3
make install
```
## Cosmovisor
```
cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.6.3
```
### Build binaries
```
make build
```
### Prepare binaries for Cosmovisor
```
mkdir -p $HOME/.quicksilverd/cosmovisor/upgrades/v1.6.3/bin
mv build/quicksilverd $HOME/.quicksilverd/cosmovisor/upgrades/v1.6.3/bin/
rm -rf build
```
