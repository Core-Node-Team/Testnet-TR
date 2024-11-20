

## Manuel
```
cd $HOME
wget -O quicksilverd https://github.com/ingenuity-build/quicksilver/releases/download/v1.7.2/quicksilverd-v1.7.2-amd64
mv quicksilverd-v1.7.2-amd64 quicksilverd
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
git checkout v1.7.2
make install
```
## Cosmovisor
```
cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.7.2
```
### Build binaries
```
make build
```
### Prepare binaries for Cosmovisor
```
mkdir -p $HOME/.quicksilverd/cosmovisor/upgrades/v1.7.2/bin
mv build/quicksilverd $HOME/.quicksilverd/cosmovisor/upgrades/v1.7.2/bin/
rm -rf build
```

# OR

```
cd $HOME
wget -O quicksilverd https://github.com/ingenuity-build/quicksilver/releases/download/v1.7.2/quicksilverd-v1.7.2-amd64
mv quicksilverd-v1.7.2-amd64 quicksilverd
chmod +x quicksilverd
mkdir -p $HOME/.quicksilverd/cosmovisor/upgrades/v1.7.2/bin
mv $HOME/quicksilverd $HOME/.quicksilverd/cosmovisor/upgrades/v1.7.2/bin/
```



